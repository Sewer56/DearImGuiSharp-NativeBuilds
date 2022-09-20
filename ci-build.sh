#!/usr/bin/env bash

scriptPath="`dirname \"$0\"`"

if [[ "$OSTYPE" == "darwin"* ]]; then
  $scriptPath/build-native.sh release -osx-architectures 'x86_64'
else
  $scriptPath/build-native.sh release
fi
