"""Documenso -> GitHub bridge.

A small self-hosted HTTP server that receives Documenso `DOCUMENT_COMPLETED`
webhooks and triggers the GitHub `release-publish` workflow via a
`repository_dispatch` event. GitHub cannot be the webhook target directly
because Documenso can only send a fixed `X-Documenso-Secret` header, not
GitHub's auth header or dispatch payload shape.

Flow:
    Documenso  --DOCUMENT_COMPLETED-->  this bridge  --repository_dispatch-->  GitHub

Auth to GitHub (in order of preference):
  * GitHub App  -- set GITHUB_APP_ID, GITHUB_APP_INSTALLATION_ID, and
                   GITHUB_APP_PRIVATE_KEY (PEM contents). Mints a short-lived
                   installation token per request. Needs PyJWT[crypto]
                   (see scripts/bridge-requirements.txt).
  * PAT         -- set GITHUB_TOKEN (fine-grained, contents:write). Simpler,
                   good for quick testing.

Required env:
  DOCUMENSO_WEBHOOK_SECRET   the secret configured on the Documenso webhook
  GITHUB_REPO                "owner/repo"
Optional env:
  PORT                       listen port (default 8080)
"""

import hmac
import json
import os
import sys
import time
import urllib.request
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

WEBHOOK_SECRET = os.environ["DOCUMENSO_WEBHOOK_SECRET"]
GITHUB_REPO = os.environ["GITHUB_REPO"]
PORT = int(os.getenv("PORT", "8080"))

# Reverse of upload.py's TITLES: envelope title prefix -> section.
TITLE_TO_SECTION = {
    "CL60 Manuals": "manuals",
    "CL60 Simulator Profiles": "simulator-profiles",
}


def parse_title(title):
    """Return (section, tag) parsed from an envelope title, or (None, None)."""
    for prefix, section in TITLE_TO_SECTION.items():
        if title == prefix:
            return section, ""
        if title.startswith(prefix + " "):
            return section, title[len(prefix) + 1:]
    return None, None


def _gh_request(url, token, method="GET", body=None):
    data = json.dumps(body).encode() if body is not None else None
    req = urllib.request.Request(url, data=data, method=method, headers={
        "Authorization": f"Bearer {token}",
        "Accept": "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28",
        "Content-Type": "application/json",
    })
    with urllib.request.urlopen(req, timeout=30) as resp:
        return resp.status, (resp.read() or b"")


def github_token():
    """Mint a GitHub App installation token, or fall back to a PAT."""
    app_id = os.getenv("GITHUB_APP_ID")
    if app_id:
        import jwt  # PyJWT[crypto]
        # Private key from the env var, or a file via GITHUB_APP_PRIVATE_KEY_FILE
        # (friendlier for a multiline PEM in a systemd EnvironmentFile).
        private_key = os.getenv("GITHUB_APP_PRIVATE_KEY")
        if not private_key and os.getenv("GITHUB_APP_PRIVATE_KEY_FILE"):
            with open(os.environ["GITHUB_APP_PRIVATE_KEY_FILE"]) as fh:
                private_key = fh.read()
        now = int(time.time())
        assertion = jwt.encode(
            {"iat": now - 60, "exp": now + 540, "iss": app_id},
            private_key,
            algorithm="RS256",
        )
        installation = os.environ["GITHUB_APP_INSTALLATION_ID"]
        _, body = _gh_request(
            f"https://api.github.com/app/installations/{installation}/access_tokens",
            assertion, method="POST", body={},
        )
        return json.loads(body)["token"]
    return os.environ["GITHUB_TOKEN"]


def dispatch(section, tag, envelope_id):
    token = github_token()
    _gh_request(
        f"https://api.github.com/repos/{GITHUB_REPO}/dispatches",
        token, method="POST",
        body={
            "event_type": "documenso-completed",
            "client_payload": {"section": section, "tag": tag, "envelope_id": envelope_id},
        },
    )


class Handler(BaseHTTPRequestHandler):
    def _reply(self, code, msg=""):
        self.send_response(code)
        self.end_headers()
        if msg:
            self.wfile.write(msg.encode())

    def do_POST(self):
        # Verify the shared secret with a constant-time comparison.
        provided = self.headers.get("X-Documenso-Secret", "")
        if not hmac.compare_digest(provided, WEBHOOK_SECRET):
            return self._reply(401, "bad secret")

        length = int(self.headers.get("Content-Length", "0"))
        try:
            event = json.loads(self.rfile.read(length))
        except json.JSONDecodeError:
            return self._reply(400, "bad json")

        if event.get("event") != "DOCUMENT_COMPLETED":
            return self._reply(204)  # ignore other events

        doc = event.get("payload", {})
        section, tag = parse_title(doc.get("title", ""))
        if section is None:
            print(f"ignoring unknown title: {doc.get('title')!r}", file=sys.stderr)
            return self._reply(204)

        try:
            dispatch(section, tag, doc.get("id"))
        except Exception as exc:  # noqa: BLE001 - surface and 500 so Documenso retries
            print(f"dispatch failed: {exc}", file=sys.stderr)
            return self._reply(500, "dispatch failed")

        print(f"dispatched section={section} tag={tag} envelope={doc.get('id')}", file=sys.stderr)
        self._reply(204)

    def log_message(self, *args):  # quieter default logging
        pass


if __name__ == "__main__":
    ThreadingHTTPServer(("", PORT), Handler).serve_forever()
