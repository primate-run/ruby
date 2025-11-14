#!/usr/bin/env bash
set -euo pipefail

mkdir -p pkg
rm -f pkg/primate-run-*.gem

# Build the gem
gem build primate-run.gemspec

# Move the built gem into pkg/
mv primate-run-*.gem pkg/

# Show result
echo "Built:"
ls -lh pkg/primate-run-*.gem
