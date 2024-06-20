#!/bin/bash

cd src
files=${2:-*}
grep --color "$1" $files
