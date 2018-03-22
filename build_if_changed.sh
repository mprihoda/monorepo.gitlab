#!/bin/bash
set -e
# reusing common_functions
cwd="$(dirname "$0")"
source $cwd/common_functions.sh || {
    source $(find -name common_functions.sh)
}

folder=${1}
#read -r -d '' command
command=${@:2}
DIRNAME="$(dirname $(readlink -f "$0"))"
${DIRNAME}/changes.sh ${folder}  || {
  pprint "Error" "Skipping build for '${folder}'."
  exit 0
} && {
  pprint "other" "Building '${folder}'..."
  pprint "other" "Executing '${command}'..."

  ${command} && {
    pprint "$0 Successfull"
  } || {
    pprint "$0 Failed"
    exit 1
  }

  exit 0

}




