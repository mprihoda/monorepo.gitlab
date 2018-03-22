#!/bin/bash
set -e
# reusing common_functions
cwd="$(dirname "$0")"
source $cwd/common_functions.sh || {
    source $(find -name common_functions.sh)
}

folder=${1}
command=${@:2}
DIRNAME="$(dirname $(readlink -f "$0"))"
${DIRNAME}/changes.sh ${folder}
if [[ $? -ne 0 ]]; then
  pprint "Error" "Skipping build for '${folder}'."
  exit 0
fi


pprint "other" "Building '${folder}'..."
pprint "other" "Executing '${command}'..."

${command} && {
  pprint "$0 Successfull"
} || {
  pprint "$0 Failed"
}

exit 0
