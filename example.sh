#!/bin/env bash
set -x
#####
#####
# constants
URL="http://127.0.0.1:5000"
# index
curl ${URL}
# ***** UNSECURED WS *****
# ----- no reserved character -----
curl ${URL}/test/dummiest
curl ${URL}"/test/dummiest?foo=bar"
# ----- reserved character without escape -----
# :
curl ${URL}"/test/dummiest?foo:fum=bar"
# /
curl ${URL}"/test/dummiest?foo/fum=bar"
# ?
curl ${URL}"/test/dummiest?foo?fum=bar"
# []
curl ${URL}"/test/dummiest?foo[fum]=bar"
# @
curl ${URL}"/test/dummiest?foo@fum=bar"
# '
curl ${URL}"/test/dummiest?foo'fum=bar"
# ()
curl ${URL}"/test/dummiest?foo(fum)=bar"
# *
curl ${URL}"/test/dummiest?foo*fum=bar"
# ,
curl ${URL}"/test/dummiest?foo,fum=bar"
# ;
curl ${URL}"/test/dummiest?foo;fum=bar"
# ----- reserved character with escape -----
# # -> %23
curl ${URL}"/test/dummiest?foo%23fum=bar"
# ! -> %21
curl ${URL}"/test/dummiest?foo%21fum=bar"
# $ -> %24
curl ${URL}"/test/dummiest?foo%24fum=bar"
# & -> %26
curl ${URL}"/test/dummiest?foo%26fum=bar"
# + -> %2B
curl ${URL}"/test/dummiest?foo%2Bfum=bar"
# = -> %3D
curl ${URL}"/test/dummiest?foo%3Dfum=bar"
# ----- other character with escape -----
# % -> %3D
curl ${URL}"/test/dummiest?foo%25fum=bar"
# " -> %3D
curl ${URL}"/test/dummiest?foo%22fum=bar"
# -
curl ${URL}"/test/dummiest?foo-fum=bar"
# .
curl ${URL}"/test/dummiest?foo.fum=bar"
# <>
curl ${URL}"/test/dummiest?foo<fum>=bar"
# '\'
curl ${URL}"/test/dummiest?foo\fum=bar"
# ^
curl ${URL}"/test/dummiest?foo^fum=bar"
# _
curl ${URL}"/test/dummiest?foo_fum=bar"
# `
curl ${URL}"/test/dummiest?foo%60fum=bar"
# {}
curl ${URL}"/test/dummiest?foo%7Bfum%7D=bar"
# |
curl ${URL}"/test/dummiest?foo|fum=bar"
