#!/bin/bash

# Fail the whole script if any command fails
set -e

ROOT=$TRAVIS_BUILD_DIR/..

## Build Checker Framework
(cd $ROOT && git clone https://github.com/typetools/checker-framework.git)
# This also builds jsr308-langtools
(cd $ROOT/checker-framework && ./.travis-build-without-test.sh)
export CHECKERFRAMEWORK=$ROOT/checker-framework

## Run test
ant -Djsr308.home=$ROOT
