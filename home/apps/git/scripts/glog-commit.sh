#!/usr/bin/env bash
test -n "$1" && git log --grep "$1" --pretty=reference -1 || true
