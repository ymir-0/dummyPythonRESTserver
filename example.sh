#!/bin/env bash
set -x
# constants
URL="http://127.0.0.1:5000"
# index
curl ${URL}
# unsecured WS
curl ${URL}/test/dummiest
curl ${URL}/test/dummiest?foo=bar
