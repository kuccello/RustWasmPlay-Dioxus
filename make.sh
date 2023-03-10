#!/bin/sh
# usage: ./make.sh build

echo "Building..."
DIR="$(dirname "$0")"

if cargo "$@"; then
    [ -d "$DIR/target/debug" ] && cp -r "$DIR/resources" "$DIR/target/debug/resources"
    [ -d "$DIR/target/release" ] && cp -r "$DIR/resources" "$DIR/target/release/resources"
fi
echo "...done"