#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5f91b6a0af6ff8001e1c8290/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5f91b6a0af6ff8001e1c8290
fi
curl -s -X POST https://api.stackbit.com/project/5f91b6a0af6ff8001e1c8290/webhook/build/ssgbuild > /dev/null
gatsby build
curl -s -X POST https://api.stackbit.com/project/5f91b6a0af6ff8001e1c8290/webhook/build/publish > /dev/null
