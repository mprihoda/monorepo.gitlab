#!/bin/bash
set -e
# reusing common_functions
cwd="$(dirname "$0")"
source $cwd/common_functions.sh || {
    source $(find -name common_functions.sh)
}

folderRegex=${1}
DIRNAME="$(dirname $(readlink -f "$0"))"
ref=$(cat "${DIRNAME}/.LAST_GREEN_COMMIT")
# Always indicate changes unless valid green commit ref given, #1
if [[ ! ${ref:+1} ]]; then
  pprint "other" 'No LAST_GREEN_COMMIT. Assuming changes.'
  exit 0
fi

pprint "other" "Checking for changes of folder '${folderRegex}' from ref '${ref}'..."

#git diff ${ref} --name-only
changes=$(git diff ${ref} --name-only | grep -E -w "${foldfolderRegexer}") && {
  pprint "other" "Folder '${changes}' has changed. RETURN 0"
  exit 0
} || {
  pprint "other" "Folder '${folderRegex}' has not changed. RETURN ERROR"
  exit 1
}

exit 0
