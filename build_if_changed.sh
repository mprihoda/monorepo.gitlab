#!/bin/bash
set -e
# reusing common_functions
cwd="$(dirname "$0")"
source $cwd/common_functions.sh || {
    source $(find -name common_functions.sh)
}

folder=${1}

DIRNAME="$(dirname $(readlink -f "$0"))"
${DIRNAME}/changes.sh ${folder}  || {
  pprint "Warn" "Skipping build for '${folder}'."
  echo "1" > ${ROOT}/.SKIP_THIS_JOB
  exit 0
} && {
  pprint "other" "Building '${folder}'..."
  exit 0
}




