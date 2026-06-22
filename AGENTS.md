# AGENTS.md

Guidance for AI agents working in this repository.

## What this is

Zhongtai Virtual (MZT) aircraft documentation for the Bombardier Challenger 650
(CL60), as flown in the HotStart CL650 simulator. Documents are authored in
[Typst](https://typst.app/); checklist/flow content lives as TOML so it feeds
both the printed PDFs and the in-sim checklist XML.

See `readme.md` for the full layout, build, and release workflow.

## Layout

- `manuals/` — main document set (`cl60-*.typ`) + `checklist.toml`, `flows.toml`.
- `simulator-profiles/` — sim evaluation and captain validation profiles.
- `manuals/`, `simulator-profiles/` — each has `revisions.toml` + `revisions.typ`
  rendering a per-folder **Record of Revisions** PDF.
- `scripts/` — release/packaging: `toml2cl60.py` (sim checklist export),
  `upload.py`/`download.py` (Documenso), fish wrappers, `requirements.txt`.
- `common.typ` — shared Typst library (page template, header, checklist/flow/
  revision renderers, signature field).
- `meta.toml` — repo-wide metadata (accent colour, revision date).
- `experimental/` — local drafts; **untracked and not ready**, leave it alone.

## Building

Documents import `/common.typ`, so Typst needs `--root` at the repo root:

```sh
typst compile --root . --input RELEASE=1 manuals/cl60-checklist.typ
```

- `RELEASE=1` removes the WORK IN PROGRESS draft stamp, draws the approval
  border, and emits the `{{POI/...}}`/`{{APM/...}}` signature placeholders.
- Without it, the page is stamped draft / NOT FOR OPERATION.

After editing a `.typ`/`.toml`, compile the affected document to confirm it
still builds before reporting done.

## Sim checklist export

`python scripts/toml2cl60.py` reads `manuals/checklist.toml`,
`manuals/flows.toml`, and `meta.toml` relative to the repo root (independent of
CWD) and writes the HotStart checklist XML to stdout.

## Conventions

- **Page codes** follow `<category-letter><number>` (e.g. `N1`, `R2`, `T1a`).
  Record of Revisions docs currently use an empty page code.
- **Record of Revisions** entries list one section per document, named by that
  document's **header title** (not the filename), with dated entries; entries
  end with a period. Add new entries newest-first.
- Use the aviation term **"Record of Revisions"** — not "changelog".
- The shared renderer is `render-revisions(config)` in `common.typ`; each folder
  has an identical thin `revisions.typ` wrapper loading its local
  `revisions.toml`.
- Generated artifacts (`*.pdf`, `*.xml`, `*.sig`) and `.venv/` are git-ignored.
- Python 3.14; deps are pinned in `scripts/requirements.txt` and installed into a
  repo-local `.venv/` auto-created by `scripts/activate-venv.fish`.

## Git

- Make focused, logical commits; split unrelated changes (e.g. a folder move vs
  a feature) into separate commits.
- Keep `experimental/` untracked.
- End commit messages with the `Co-Authored-By` trailer used in history.
- Commit/push only when asked.
