#!/usr/bin/env fish

# Repo root = parent of this script's directory (scripts/), as an absolute path.
set repo (path resolve (status dirname)/..)

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

# Publish root must be supplied via the environment (e.g. the local company
# share, or a temp dir in CI before uploading to a GitHub Release). The signed
# documents are filed into a per-section subfolder beneath it.
if test -z "$MZT_DOC_PUBLISH_DIR"
    echo "set MZT_DOC_PUBLISH_DIR to the publish root (e.g. ~/MZT/company-shared/documents/CL60)" >&2
    exit 1
end
set dest $MZT_DOC_PUBLISH_DIR/$section
mkdir -p $dest

set dir (mktemp -d)
echo $dir
source $repo/scripts/activate-venv.fish; or exit 1
if test -z "$DOCUMENSO_API_KEY"
    set -x DOCUMENSO_API_KEY (read -s -P "Documenso API Key: ")
end
python $repo/scripts/download.py $envelope_id $dir; or begin
    rm -rf $dir
    exit 1
end

# The HotStart sim checklist is built from the manuals data, so only
# regenerate and sign it when publishing the manuals section.
if test "$section" = manuals
    python $repo/scripts/toml2cl60.py >$dir/checklists.xml; or begin; rm -rf $dir; exit 1; end
    gpg --sign --detach-sign <$dir/checklists.xml >$dir/checklists.xml.sig; or begin; rm -rf $dir; exit 1; end
    gpg --verify $dir/checklists.xml.sig
end

# Guard against an empty download (fish errors on an unmatched glob).
if test (count (find $dir -mindepth 1 -maxdepth 1)) -eq 0
    echo "no documents were downloaded" >&2
    rm -rf $dir
    exit 1
end
mv $dir/* $dest/
rm -rf $dir
