#!/usr/bin/env bash

dartfmt_change=$(dartfmt -l 120 -n .)

if [ -n "$dartfmt_change" ]
then
  exit 1
fi

pub run test:test .
