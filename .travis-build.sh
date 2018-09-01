#!/bin/bash

echo "Entering checker-framework-demos/.travis-build.sh"

# Fail the whole script if any command fails
set -e

export SHELLOPTS

ROOT=$TRAVIS_BUILD_DIR/..

export CHECKERFRAMEWORK=`readlink -f ${CHECKERFRAMEWORK:-$ROOT/checker-framework}`

## Build Checker Framework
SLUGOWNER=${TRAVIS_REPO_SLUG%/*}
if [[ "$SLUGOWNER" == "" ]]; then
  SLUGOWNER=typetools
fi

## Build Checker Framework
if [ -d $CHECKERFRAMEWORK ] ; then
    git -C $CHECKERFRAMEWORK pull
else
    [ -d /tmp/plume-scripts ] || (cd /tmp && git clone --depth 1 https://github.com/plume-lib/plume-scripts.git)
    REPO=`/tmp/plume-scripts/git-find-fork ${SLUGOWNER} typetools checker-framework`
    BRANCH=`/tmp/plume-scripts/git-find-branch ${REPO} ${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}`
    echo "About to execute: (git clone -b $BRANCH --single-branch --depth 1 $REPO)"
    git clone -b ${BRANCH} --single-branch --depth 1 ${REPO}{CHECKERFRAMEWORK} || git clone -b ${BRANCH} --single-branch --depth 1 ${REPO} ${CHECKERFRAMEWORK}
fi

# This also builds annotation-tools and jsr308-langtools
(cd $CHECKERFRAMEWORK && ./.travis-build-without-test.sh downloadjdk jdk8)

## Run test
ant -Djsr308.home=$ROOT

echo "Exiting checker-framework-demos/.travis-build.sh"
