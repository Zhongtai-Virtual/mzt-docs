from documenso_sdk import *
import httpx
import os
import re
import sys

api_key = os.getenv("DOCUMENSO_API_KEY", "")
envelope_id = sys.argv[1]
output_path = sys.argv[2]


def resolve_envelope_id(documenso, raw):
    """The Documenso webhook sends the numeric document id; envelopes.get needs
    the envelope_... token. Resolve a numeric id via get-many by documentId."""
    if not re.fullmatch(r"\d+", str(raw)):
        return raw
    res = documenso.envelope.envelope_get_many(
        ids={"type": "documentId", "ids": [int(raw)]}
    )
    data = res.data
    rec = data[0] if isinstance(data, list) else data
    for cand in (getattr(rec, "id", None), getattr(rec, "secondary_id", None)):
        if isinstance(cand, str) and cand.startswith("envelope_"):
            return cand
    raise SystemExit(f"could not resolve envelope token for document id {raw}")


with Documenso(
    api_key=api_key,
    server_url="https://documenso.mzt.app/api/v2/"
) as documenso:
    envelope_id = resolve_envelope_id(documenso, envelope_id)
    envelope = documenso.envelopes.get(envelope_id=envelope_id)
    for item in envelope.envelope_items:
        if isinstance(item, EnvelopeGetEnvelopeItem):
            item_url = f"{documenso.sdk_configuration.server_url}envelope/item/{item.id}/download?version=signed"
            headers = {
                "Authorization": f"{api_key}",
            }
            with httpx.Client(timeout=60.0) as client:
                res = client.get(item_url, headers=headers)
                with open(os.path.join(output_path, item.title), 'wb') as file:
                    for chunk in res.iter_bytes():
                        file.write(chunk)
            #res = documenso.envelopes.items.download(envelope_item_id=item.id, version=EnvelopeItemDownloadVersion.SIGNED)
