# Ensure and activate the repo-local Python venv for the release scripts.
# Expects $repo to be set by the caller (the repo root). Source this file:
#     source $repo/scripts/activate-venv.fish; or exit 1
set -l venv $repo/.venv
# Guard on activate.fish (the file we source) so a partial/broken venv is
# rebuilt rather than skipped.
if not test -f $venv/bin/activate.fish
    echo "Creating Python venv at $venv ..." >&2
    #rm -rf $venv
    python3 -m venv $venv; or return 1
    $venv/bin/python -m pip install -q -r $repo/scripts/requirements.txt; or return 1
end
source $venv/bin/activate.fish
