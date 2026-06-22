from documenso_sdk import *
import httpx
import os
import sys

api_key = os.getenv("DOCUMENSO_API_KEY", "")
envelope_id = sys.argv[1]
output_path = sys.argv[2]

with Documenso(
    api_key=api_key,
    server_url="https://documenso.mzt.app/api/v2/"
) as documenso:
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
