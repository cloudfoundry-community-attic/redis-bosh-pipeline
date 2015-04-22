#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

message=$1; shift
if [[ "${message}X" == "X" ]]; then
  echo "USAGE: git-add-all.sh 'commit message'"
  exit 1
fi

set -e

git config --global user.email "nobody@concourse.ci"
git config --global user.name "Concourse"

pushd $DIR/..
  echo "Checking for changes in $(pwd)..."
  if [[ "$(git status -s)X" != "X" ]]; then
    git add . --all
    git commit -m "${message}"
  fi
popd
