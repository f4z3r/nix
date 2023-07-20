#!/usr/bin/env bash
var="$(git log --author="$1" --pretty="%an <%ae>" -1)" && test -n "$var" && echo -n "$var" || echo -n "$1"
