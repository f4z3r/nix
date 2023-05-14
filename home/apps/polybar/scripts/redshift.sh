#!/usr/bin/env bash

redshift -p | grep -i period | cut -d' ' -f2
