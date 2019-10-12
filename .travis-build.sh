#!/bin/bash

echo "Entering `pwd`/.travis-build.sh"

# Fail the whole script if any command fails
set -e

export SHELLOPTS

ROOT=`readlink -f ..`

export CHECKERFRAMEWORK=`readlink -f ${CHECKERFRAMEWORK:-$ROOT/checker-framework}`

git -C /tmp/plume-scripts pull > /dev/null 2>&1 \
  || git -C /tmp clone --depth 1 -q https://github.com/plume-lib/plume-scripts.git

## Build Checker Framework
if [ -d $CHECKERFRAMEWORK ] ; then
    # Fails if not currently on a branch
    git -C $CHECKERFRAMEWORK pull || true
else
    /tmp/plume-scripts/git-clone-related typetools checker-framework ${CHECKERFRAMEWORK}
fi

# This also builds annotation-tools and jsr308-langtools
(cd $CHECKERFRAMEWORK && ./.travis-build-without-test.sh downloadjdk jdk8)

## Run test
ant -Djsr308.home=$ROOT

echo "Exiting checker-framework-demos/.travis-build.sh"
