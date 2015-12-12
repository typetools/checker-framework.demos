#!/bin/bash

ROOT=$TRAVIS_BUILD_DIR/..

## Build Checker Framework
(cd $ROOT && git clone https://github.com/typetools/checker-framework.git)
# This also builds jsr308-langtools
(cd $ROOT/checker-framework/ && ./.travis-build-without-test.sh)

## Run test
ant
