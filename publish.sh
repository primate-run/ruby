#!/usr/bin/env bash
set -euo pipefail

./build.sh

GEM_PATH=$(ls -t pkg/primate-run-*.gem | head -n1)
echo "Pushing $GEM_PATH"
gem push "$GEM_PATH"
