#!/bin/sh
# usage: ./publish.sh build --release

echo "Publishing to docs..."
DIR="$(dirname "$0")"

if trunk "$@"; then
  rm -rf ./docs
  cp -R dist ./docs
fi
echo "...done"