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

# Release workflow

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
   to the per-section subfolder of the company share
   (`~/MZT/company-shared/documents/CL60/<section>/`). For the `manuals`
   section it also regenerates and GPG detach-signs the HotStart sim checklist:

   ```sh
   scripts/download-and-publish-docs.fish <envelope_id> [manuals|simulator-profiles]
   ```

   The section is picked with `fzf` if omitted.

Both wrappers prompt for `DOCUMENSO_API_KEY` (skipped if it is already set in
the environment) and, on first run, build the repo-local `.venv/` from
`scripts/requirements.txt` (`documenso-sdk`, `httpx`, `pypdf`).
