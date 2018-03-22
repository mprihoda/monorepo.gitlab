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

git diff ${ref} --name-only | grep -qw "^${folder}"
changes=$?
if [[ ${changes} -eq 0 ]]; then
  pprint "other" "Folder '${folder}' has changed."
else
  pprint "error" "Folder '${folder}' has not changed."
fi
exit 0
