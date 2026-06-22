# Intro

This repository holds the (mainly aircraft) documentation of **Zhongtai Virtual**,
covering the Bombardier Challenger 650 (CL60) as flown in the HotStart CL650
simulator add-on.

The documents are authored in [Typst](https://typst.app/), with checklist and
flow content kept as TOML data so it can feed both the printed PDFs and the
in-sim checklist system.

# Layout

| Path | Contents |
| --- | --- |
| `manuals/` | The main document set — normal checklist, flows, flow diagrams, adverse weather, briefing, ops reference (`cl60-*.typ`) plus their `checklist.toml` / `flows.toml` data. |
| `simulator-profiles/` | Sim evaluation and captain validation profiles (`cl60-*.typ`). |
| `manuals/`, `simulator-profiles/` | Each also has a `revisions.toml` + `revisions.typ` that render a per-folder **Record of Revisions** PDF. |
| `scripts/` | Release/packaging scripts (sim checklist export + the Documenso signing/publishing pipeline). |
| `common.typ` | Shared Typst library: page template, header, checklist/flow/revision renderers, signature field. |
| `meta.toml` | Repo-wide metadata (accent colour, revision date). |
| `standard_callouts.typ` | Standard pilot callouts. |

Generated artifacts (`*.pdf`, `*.xml`, `*.sig`) and the local `.venv/` are
git-ignored.

# Prerequisites

- [Typst](https://typst.app/) — renders the documents.
- Python 3.14 — runs the release scripts. A repo-local `.venv/` is created and
  populated automatically on first run, so no manual setup is needed (the first
  run needs network access to install from `scripts/requirements.txt`).
- [fish](https://fishshell.com/) — runs the wrapper scripts.
- `fzf` and `gpg` — the section picker and detached-signing step.
- A Documenso API key for the `documenso.mzt.app` instance (the scripts prompt
  for it).
- `MZT_DOC_PUBLISH_DIR` set to the publish root (where signed documents are
  filed), required by the download/publish step.

# Rendering PDFs

The documents import `/common.typ`, so Typst must be told the repo root with
`--root`:

```sh
typst compile --root . --input RELEASE=1 manuals/cl60-checklist.typ
```

`--input RELEASE=1` switches the document from draft to release:

- **Without it** the page is stamped *WORK IN PROGRESS / NOT FOR OPERATION*.
- **With it** the draft stamp is removed, the approval border is drawn, and the
  digital-signature field plus its `{{POI/...}}` / `{{APM/...}}` placeholders are
  emitted for the signing pipeline below.

# Exporting the sim checklist

To regenerate the HotStart CL650 checklist XML from `manuals/checklist.toml`
and `manuals/flows.toml`:

```sh
python scripts/toml2cl60.py >/output/path/checklists.xml
```

It is recommended to back up the original `checklists.xml` first.

# Release workflow (manual)

Releasing a section (`manuals` or `simulator-profiles`) is a two-stage,
human-in-the-loop process backed by a self-hosted
[Documenso](https://documenso.com) instance (`documenso.mzt.app`).

1. **Upload for approval.** Compiles the section's `.typ` files with
   `RELEASE=1` and creates a Documenso envelope, placing signature/date/initials
   fields on the `{{POI/...}}` / `{{APM/...}}` placeholders for sequential
   signing (POI → VP Flight Ops → APM):

   ```sh
   scripts/upload-docs-for-approval.fish [manuals|simulator-profiles]
   ```

   The script creates the envelope and fields but does **not** distribute it —
   send it for signing from the Documenso web UI.

2. **Sign.** Each signer/approver completes the envelope in turn.

3. **Download & publish.** Once fully signed, pull the signed PDFs and move them
   into a per-section subfolder beneath `$MZT_DOC_PUBLISH_DIR` (the publish root,
   which must be set in the environment). For the `manuals` section it also
   regenerates and GPG detach-signs the HotStart sim checklist:

   ```sh
   set -x MZT_DOC_PUBLISH_DIR ~/MZT/company-shared/documents/CL60
   scripts/download-and-publish-docs.fish <envelope_id> [manuals|simulator-profiles]
   ```

   The section is picked with `fzf` if omitted.

Both wrappers prompt for `DOCUMENSO_API_KEY` (skipped if it is already set in
the environment) and, on first run, build the repo-local `.venv/` from
`scripts/requirements.txt` (`documenso-sdk`, `httpx`, `pypdf`).

# CI/CD

GitHub Actions (`.github/workflows/`):

- **`ci.yml`** — on push/PR, compiles every document with `RELEASE=1` and runs
  the sim-checklist export, so a broken `.typ`/`.toml` fails fast. Fonts are
  downloaded by the `setup-build` composite action (`TYPST_FONT_PATHS=fonts`).
- **`release-upload.yml`** — automates the upload half of the release workflow.
- **`release-publish.yml`** — automates the publish half.

## Automated release

Each section is released with its **own tag**:

| Section | Tag |
| --- | --- |
| `manuals` | `cl60-manual/<date>` (e.g. `cl60-manual/2026-06-22`) |
| `simulator-profiles` | `cl60-profile/<date>` |

A commit may carry both tags; GitHub fires one `release-upload` run per tag, and
each run resolves its section from the tag prefix. The flow:

```
tag push ─► release-upload.yml ─► Documenso envelope (distributed)
                                       │  POI → VP Flight Ops → APM sign
                                       ▼
                              DOCUMENT_COMPLETED webhook
                                       │
                              documenso-webhook-bridge.py
                                       │  repository_dispatch
                                       ▼
                            release-publish.yml ─► download signed PDFs,
                            GPG-sign checklists.xml (manuals), create the
                            GitHub Release and upload the assets
```

The release tag is embedded in the Documenso envelope title so the bridge can
map a completed envelope back to its tag (the webhook payload carries only the
title, no metadata).

## The webhook bridge

GitHub can't be a Documenso webhook target directly (Documenso sends only a
fixed `X-Documenso-Secret` header, not GitHub's auth or dispatch payload). So
`scripts/documenso-webhook-bridge.py` runs locally, verifies the secret, parses
the completed envelope's title into `(section, tag)`, and triggers
`release-publish.yml` via `repository_dispatch`.

Run it (deps: `scripts/bridge-requirements.txt`, only needed for GitHub App
auth):

```sh
set -x DOCUMENSO_WEBHOOK_SECRET ...
set -x GITHUB_REPO Zhongtai-Virtual/mzt-docs
# GitHub App auth (preferred):
set -x GITHUB_APP_ID ...
set -x GITHUB_APP_INSTALLATION_ID ...
set -x GITHUB_APP_PRIVATE_KEY (cat app-private-key.pem)
# …or a PAT instead: set -x GITHUB_TOKEN ...
python scripts/documenso-webhook-bridge.py    # listens on $PORT (default 8080)
```

Then in Documenso, add a webhook for **DOCUMENT_COMPLETED** pointing at this
host, with the same secret.

## Required configuration

- **GitHub Actions secrets:** `DOCUMENSO_API_KEY`, and `GPG_PRIVATE_KEY`
  (base64-encoded; use a dedicated CI signing subkey with an expiry, not a
  personal key).
- **`release` environment** with required reviewers — `release-upload.yml` is
  gated on it, so a stray tag can't fire real signature requests unattended.
- **GitHub App** (for the bridge): grant `contents: write`, install it on this
  repo, and give the bridge the app id, installation id, and private key. App
  installation tokens are short-lived and repo-scoped — preferred over a PAT.
