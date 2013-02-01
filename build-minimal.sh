#!/bin/sh

set -e

(cd tr && make clean all ; )
cabal configure --disable-library-profiling -flags="-vircheck"
cabal build
