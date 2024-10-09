#!/bin/bash
# Usage: ./run.sh [filter]

CONFIG="phpunit.coverage.pre-10.1.0.xml"

if [ -z "$1" ]; then
    FILTER_ARG=""
else
    FILTER_ARG="--filter $1"
fi

clear
phpunit --configuration $CONFIG $FILTER_ARG
