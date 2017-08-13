#!/bin/bash

# Fail the whole script if any command fails
set -e

export SHELLOPTS

ROOT=$TRAVIS_BUILD_DIR/..

## Build Checker Framework
(cd $ROOT && git clone --depth 1 https://github.com/typetools/checker-framework.git)
# This also builds jsr308-langtools
(cd $ROOT/checker-framework && ./.travis-build-without-test.sh downloadjdk)
export CHECKERFRAMEWORK=$ROOT/checker-framework

## Run test
ant -Djsr308.home=$ROOT
