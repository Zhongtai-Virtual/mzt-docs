#!/usr/bin/env fish

# Repo root = parent of this script's directory (scripts/).
set repo (path dirname (status dirname))
set docs_repo $repo

set section $argv[1]
if test -z "$section"
    set section (printf '%s\n' manuals simulator-profiles | fzf --prompt="Which part to upload? ")
end

if not contains -- "$section" manuals simulator-profiles
    echo "usage: upload-docs-for-approval.fish [manuals|simulator-profiles]" >&2
    exit 1
end

set pdf_dir (mktemp -d)
for typ_file in $docs_repo/$section/*.typ
    typst compile --root="$docs_repo" --input RELEASE=1 $typ_file $pdf_dir/(path basename -E $typ_file).pdf || exit 1
end
source ~/Code/documenso/venv/bin/activate.fish
set -x DOCUMENSO_API_KEY (read -s -P "Documenso API Key: ")
python $repo/scripts/upload.py $pdf_dir $section
echo $pdf_dir
rm -rf $pdf_dir
