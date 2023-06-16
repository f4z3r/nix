#!/usr/bin/env bash
test -n "$1" && git log --author="$1" --pretty="%an <%ae>" -1 || true
