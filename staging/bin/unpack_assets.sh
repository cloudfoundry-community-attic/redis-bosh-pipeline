#!/bin/bash

assets_tgz=$1; shift

set -e

if [[ ! -f ${assets_tgz} ]]; then
  echo "USAGE: ./bin/unpack_assets.sh path/to/candidate-assets-x.y.z.tgz"
  exit 1
fi

ls -opR ${assets_tgz}

tar xfz ${assets_tgz}

ls -opR pipeline-assets/
