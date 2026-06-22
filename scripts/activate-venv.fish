# Ensure and activate the repo-local Python venv for the release scripts.
# Expects $repo to be set by the caller (the repo root). Source this file:
#     source $repo/scripts/activate-venv.fish; or exit 1
set -l venv $repo/.venv
if not test -x $venv/bin/python
    echo "Creating Python venv at $venv ..." >&2
    python3 -m venv $venv; or return 1
    $venv/bin/pip install -q -r $repo/scripts/requirements.txt; or return 1
end
source $venv/bin/activate.fish
