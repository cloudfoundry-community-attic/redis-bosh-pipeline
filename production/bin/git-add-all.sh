#!/bin/bash

dir=$1; shift
message=$1; shift
if [[ "${dir}X" == "X" ]]; then
  echo "USAGE: git-add-all.sh path/to/git/repo"
  exit 1
fi
message=${message:-"Pipeline didn't mention why it made this commit"}

set -e

git config --global user.email "nobody@concourse.ci"
git config --global user.name "Concourse"

pushd $dir
  echo "Checking for changes..."
  if [[ "$(git status -s)X" != "X" ]]; then
    git add . --all
    git commit -m "${message}"
  fi
popd
