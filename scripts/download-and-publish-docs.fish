#!/usr/bin/env fish

# Repo root = parent of this script's directory (scripts/).
set repo (path dirname (status dirname))

set dir (mktemp -d)
echo $dir
source ~/Code/documenso/venv/bin/activate.fish
set -x DOCUMENSO_API_KEY (read -s -P "Documenso API Key: ")
python $repo/scripts/download.py $argv[1] $dir
python $repo/scripts/toml2cl60.py >$dir/checklists.xml
gpg --sign --detach-sign <$dir/checklists.xml >$dir/checklists.xml.sig
gpg --verify $dir/checklists.xml.sig
mv $dir/* ~/MZT/company-shared/documents/CL60/
rm -rf $dir
