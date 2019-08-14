#!/bin/bash

echo "Entering `pwd`/.travis-build.sh"

# Fail the whole script if any command fails
set -e

export SHELLOPTS

ROOT=`readlink -f ..`

export CHECKERFRAMEWORK=`readlink -f ${CHECKERFRAMEWORK:-$ROOT/checker-framework}`

git -C /tmp/plume-scripts pull > /dev/null 2>&1 \
  || git -C /tmp clone --depth 1 -q https://github.com/plume-lib/plume-scripts.git
SLUGOWNER=`/tmp/plume-scripts/git-organization typetools`

## Build Checker Framework
if [ -d $CHECKERFRAMEWORK ] ; then
    # Fails if not currently on a branch
    git -C $CHECKERFRAMEWORK pull || true
else
    [ -d /tmp/plume-scripts ] || (cd /tmp && git clone --depth 1 https://github.com/plume-lib/plume-scripts.git)
    REPO=`/tmp/plume-scripts/git-find-fork ${SLUGOWNER} typetools checker-framework`
    BRANCH=`/tmp/plume-scripts/git-find-branch ${REPO} ${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}`
    echo "About to execute: (git clone -b $BRANCH --single-branch --depth 1 $REPO)"
    git clone -b ${BRANCH} --single-branch --depth 1 ${REPO} ${CHECKERFRAMEWORK} || git clone -b ${BRANCH} --single-branch --depth 1 ${REPO} ${CHECKERFRAMEWORK}
fi

# This also builds annotation-tools and jsr308-langtools
(cd $CHECKERFRAMEWORK && ./.travis-build-without-test.sh downloadjdk jdk8)

## Run test
ant -Djsr308.home=$ROOT

echo "Exiting checker-framework-demos/.travis-build.sh"
