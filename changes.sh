#!/bin/bash
set -e
# reusing common_functions
cwd="$(dirname "$0")"
source $cwd/common_functions.sh || {
    source $(find -name common_functions.sh)
}

folder=${1}
DIRNAME="$(dirname $(readlink -f "$0"))"
ref=$(cat "${DIRNAME}/.LAST_GREEN_COMMIT")
# Always indicate changes unless valid green commit ref given, #1
if [[ ! ${ref:+1} ]]; then
  pprint "other" 'No LAST_GREEN_COMMIT. Assuming changes.'
  exit 0
fi

pprint "other" "Checking for changes of folder '${folder}' from ref '${ref}'..."

git diff ${ref} --name-only | grep -qw "^${folder}" && {
  pprint "other" "Folder '${folder}' has changed. RETURN 0"
  exit 0
} || {
  pprint "other" "Folder '${folder}' has not changed. RETURN ERROR"
  exit 1
}

exit 0
