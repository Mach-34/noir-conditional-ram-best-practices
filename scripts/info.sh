#!/bin/bash
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
cd $SCRIPT_DIR/..

# echo "Compiling all circuits..."
# nargo compile --force --silence-warnings

# echo "Getting circuit info..."
# nargo info --silence-warnings

# echo "Getting circuit constraint counts..."
# ARRAY_BAD_SIZE=$(bb gates -b target/array_bad.json | grep "circuit" | grep -o '[0-9]\+')
# ARRAY_GOOD_SIZE=$(bb gates -b target/array_good.json | grep "circuit" | grep -o '[0-9]\+')
# BOUNDED_VEC_BAD_SIZE=$(bb gates -b target/bounded_vec_bad.json | grep "circuit" | grep -o '[0-9]\+')
# BOUNDED_VEC_GOOD_SIZE=$(bb gates -b target/bounded_vec_good.json | grep "circuit" | grep -o '[0-9]\+')


# echo "==========[GATES]=========="
# echo "Bad Array Circuit: $ARRAY_BAD_SIZE gates"
# echo "Bad BoundedVec Circuit: $BOUNDED_VEC_BAD_SIZE gates"
# echo "Good Array Circuit: $ARRAY_GOOD_SIZE gates"
# echo "Good BoundedVec Circuit: $BOUNDED_VEC_GOOD_SIZE gates"

cd - > /dev/null
