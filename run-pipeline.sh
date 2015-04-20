#!/bin/bash

stub=$1; shift
trigger_job=$1; shift
set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export ATC_URL=${ATC_URL:-"http://192.168.100.4:8080"}
echo "Tutorial $(basename $DIR)"
echo "Concourse API $ATC_URL"

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

usage() {
  echo "USAGE: run-pipeline.sh credentials.yml"
  exit 1
}

if [[ "${stub}X" == "X" ]]; then
  usage
fi
stub=$(realpath $stub)
if [[ ! -f ${stub} ]]; then
  usage
fi

pushd $DIR
  yes y | fly configure -c pipeline.yml --vars-from ${stub}
  if [[ "${trigger_job}X" != "X" ]]; then
    curl $ATC_URL/jobs/${trigger_job}/builds -X POST
    fly watch -j ${trigger_job}
  fi
popd
