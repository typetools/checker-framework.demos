#!/bin/bash

echo "Entering `pwd`/.travis-build.sh"

# Fail the whole script if any command fails
set -e

export SHELLOPTS

ROOT=`readlink -f ..`

export CHECKERFRAMEWORK=`readlink -f ${CHECKERFRAMEWORK:-$ROOT/checker-framework}`

if [ -d "/tmp/git-scripts" ] ; then
  (cd /tmp/git-scripts && git pull -q) > /dev/null 2>&1
else
  (cd /tmp && git clone --depth=1 -q https://github.com/plume-lib/git-scripts.git)
fi

## Build Checker Framework
if [ -d $CHECKERFRAMEWORK ] ; then
    # Fails if not currently on a branch
    git -C $CHECKERFRAMEWORK pull || true
else
    /tmp/git-scripts/git-clone-related typetools checker-framework ${CHECKERFRAMEWORK}
fi

# This also builds annotation-tools and jsr308-langtools
(cd $CHECKERFRAMEWORK && ./.travis-build-without-test.sh downloadjdk jdk8)

## Run test
ant -Djsr308.home=$ROOT

echo "Exiting checker-framework.demos/.travis-build.sh"
