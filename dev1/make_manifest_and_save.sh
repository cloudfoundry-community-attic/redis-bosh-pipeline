#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

output_manifest=$1; shift
if [[ "${output_manifest}X" == "X" ]]; then
  echo "USAGE: make_manifest_and_save.sh manifest.yml [args.yml to.yml spiff.yml merge.yml]"
  exit 1
fi

set -e

cd $DIR
./make_manifest.sh $@ > $output_manifest
