#!/usr/bin/env fish

# Repo root = parent of this script's directory (scripts/), as an absolute path.
set repo (path resolve (status dirname)/..)
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
    typst compile --root="$docs_repo" --input RELEASE=1 $typ_file $pdf_dir/(basename $typ_file .typ).pdf || exit 1
end
source $repo/scripts/activate-venv.fish; or exit 1
if test -z "$DOCUMENSO_API_KEY"
    set -x DOCUMENSO_API_KEY (read -s -P "Documenso API Key: ")
end
python $repo/scripts/upload.py $pdf_dir $section; or begin
    rm -rf $pdf_dir
    exit 1
end
echo $pdf_dir
rm -rf $pdf_dir
