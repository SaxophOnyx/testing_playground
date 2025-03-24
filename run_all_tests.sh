#!/bin/bash

if [[ "$1" == "--fail-fast" ]]; then
    set -e
    echo "Fail-fast mode enabled"
fi

cd "data"
echo "Running tests for data"
flutter test -r expanded

cd "../features"
find . -type d -name "test" -exec dirname {} \; | sort -u | while read -r dir; do
    echo "Running tests for $dir"
    cd "$dir"
    flutter test -r expanded
    cd ".."
done

cd ".."
echo "Running integration tests"
patrol test
