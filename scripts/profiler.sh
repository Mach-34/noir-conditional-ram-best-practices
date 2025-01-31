#!/bin/bash
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
cd $SCRIPT_DIR/..

profile() {
    echo "Profiling $1..."
    noir-profiler gates \
        --artifact-path ./target/$1.json \
        --backend-path $BACKEND_BINARY_PATH \
        --output ./flame_graphs
    mv flame_graphs/main::gates.svg flame_graphs/$1.svg
}

BACKEND_BINARY_PATH=$(which bb)

profile array_bad
profile array_good
profile bounded_vec_bad
profile bounded_vec_good

cd - > /dev/null