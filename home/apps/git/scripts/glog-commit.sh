#!/usr/bin/env bash
var="$(git log --grep "$1" --pretty=reference -1)" && test "$var" != "" && echo -n "$var" || echo -n "$1"
