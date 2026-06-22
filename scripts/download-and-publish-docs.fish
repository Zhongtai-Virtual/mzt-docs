#!/usr/bin/env fish

# Repo root = parent of this script's directory (scripts/).
set repo (path dirname (status dirname))

set envelope_id $argv[1]
if test -z "$envelope_id"
    echo "usage: download-and-publish-docs.fish <envelope_id> [manuals|simulator-profiles]" >&2
    exit 1
end

set section $argv[2]
if test -z "$section"
    set section (printf '%s\n' manuals simulator-profiles | fzf --prompt="Which part to publish? ")
end

if not contains -- "$section" manuals simulator-profiles
    echo "usage: download-and-publish-docs.fish <envelope_id> [manuals|simulator-profiles]" >&2
    exit 1
end

set dest ~/MZT/company-shared/documents/CL60/$section
mkdir -p $dest

set dir (mktemp -d)
echo $dir
source $repo/scripts/activate-venv.fish; or exit 1
if test -z "$DOCUMENSO_API_KEY"
    set -x DOCUMENSO_API_KEY (read -s -P "Documenso API Key: ")
end
python $repo/scripts/download.py $envelope_id $dir

# The HotStart sim checklist is built from the manuals data, so only
# regenerate and sign it when publishing the manuals section.
if test "$section" = manuals
    python $repo/scripts/toml2cl60.py >$dir/checklists.xml
    gpg --sign --detach-sign <$dir/checklists.xml >$dir/checklists.xml.sig
    gpg --verify $dir/checklists.xml.sig
end

mv $dir/* $dest/
rm -rf $dir
