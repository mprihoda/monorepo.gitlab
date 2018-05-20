#!/bin/bash
set -e
: ${CI_SERVER_URL:=$CI_PROJECT_URL}

CI_SERVER_URL=${CI_SERVER_URL%$CI_PROJECT_PATH}
CI_SERVER_URL=${CI_SERVER_URL%/}

DIRNAME="$(dirname $(readlink -f "$0"))"
pushd ${DIRNAME}
url="${CI_SERVER_URL}/api/v4/projects/${CI_PROJECT_ID}/pipelines?private_token=${PRIVATE_TOKEN}&status=success&ref=${CI_COMMIT_REF_NAME}"

if [ $(which curl 2>/dev/null;) ] && [ $(which jq 2>/dev/null;) ]; then
  commit=$(curl -s ${url} | jq -r -f jq.filter)
else
  echo "Missing curl or jq; using python fallback"
  commit=$(${DIRNAME}/last_green_commit.py ${url})
fi
echo "Last green commit is '${commit}'."
echo ${commit} > .LAST_GREEN_COMMIT
popd
