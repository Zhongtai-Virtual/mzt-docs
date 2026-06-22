from documenso_sdk import *
import httpx
import os
import sys
from pypdf import PdfReader

api_key = os.getenv("DOCUMENSO_API_KEY", "")
path = sys.argv[1]
part = sys.argv[2]

TITLES = {
    "manuals": "MZT Manuals",
    "simulator-profiles": "MZT Simulator Profiles",
}
title = TITLES[part]

def count_pdf_pages(pdf_path):
    with open(pdf_path, "rb") as filehandle:
        reader = PdfReader(filehandle)
        return reader.get_num_pages()

def read_file(file_path):
    with open(file_path, "rb") as filehandle:
        return filehandle.read()

files = {
    filename: (os.path.join(path, filename), count_pdf_pages(os.path.join(path, filename)))
    for filename in os.listdir(path) 
    if filename.endswith("pdf")
}

with Documenso(
    api_key=api_key,
    server_url="https://documenso.mzt.app/api/v2/"
) as documenso:
    envelope_id = documenso.envelopes.create(
        payload={
            "title": title,
            "type": EnvelopeCreateType.DOCUMENT,
            "recipients": [
                # POI
                {"email": "redcrown@mzt.app", "name": "Tony Lin", "role": EnvelopeCreateRole.SIGNER, "signing_order": 0},
                # APM
                {"email": "haoyu@mzt.app", "name": "Haoyu Wu", "role": EnvelopeCreateRole.SIGNER, "signing_order": 2},
                # VP Flight Ops
                {"email": "jack@mzt.app", "name": "Jiashu Ye", "role": EnvelopeCreateRole.APPROVER, "signing_order": 1},
            ],
            "global_access_auth": [EnvelopeCreateGlobalAccessAuth.ACCOUNT],
            #"global_action_auth": [EnvelopeCreateGlobalActionAuth.ACCOUNT],
            "meta": {
                "signing_order": EnvelopeCreateSigningOrder.SEQUENTIAL,
            }
        },
        files=[
            {"file_name": filename, "content": read_file(path)}
            for (filename, (path, _)) in files.items()
        ]
    ).id
    envelope = documenso.envelopes.get(envelope_id=envelope_id)
    poi_id = envelope.recipients[0].id
    apm_id = envelope.recipients[1].id

    def get_fields(item: EnvelopeGetEnvelopeItem):
        res = [ 
            { "envelopeItemId": item.id, "type": "SIGNATURE", "recipientId": int(poi_id), "placeholder": "{{POI/SIGNATURE}}", "matchAll": True, },
            { "envelopeItemId": item.id, "type": "SIGNATURE", "recipientId": int(apm_id), "placeholder": "{{APM/SIGNATURE}}", "matchAll": True, },
            { "envelopeItemId": item.id, "type": "DATE", "recipientId": int(poi_id), "placeholder": "{{POI/DATE-TIME}}", "matchAll": True, "width": 14 },
            { "envelopeItemId": item.id, "type": "DATE", "recipientId": int(apm_id), "placeholder": "{{APM/DATE-TIME}}", "matchAll": True, "width": 14 },
        ] 
        (_, pages) = files[item.title]
        if pages > 1:
            res += [
                { "envelopeItemId": item.id, "type": "INITIALS", "recipientId": int(poi_id), "placeholder": "{{POI/INIT}}", "matchAll": True },
                { "envelopeItemId": item.id, "type": "INITIALS", "recipientId": int(apm_id), "placeholder": "{{APM/INIT}}", "matchAll": True },
            ]
        return res
    fields = [get_fields(item) for item in envelope.envelope_items]
    field_payload = { 
        "envelopeId": envelope_id, 
        # flattening
        "data": [item for sublist in fields for item in sublist]
    }
    field_url = f"{documenso.sdk_configuration.server_url}envelope/field/create-many"
    headers = {
        "Authorization": f"{api_key}",
        "Content-Type": "application/json"
    }
    with httpx.Client(timeout=60.0) as client:
        res = client.post(field_url, json=field_payload, headers=headers)
        print(res.text)

    #documenso.envelopes.distribute(envelope_id=envelope_id)
