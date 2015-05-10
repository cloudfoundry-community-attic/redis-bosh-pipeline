#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR/..
set -e

if [[ ! -f releases/redis/version ]]; then
  echo "missing resource input ${stage}/releases/redis/version"
  exit
fi
REDIS_VERSION=$(cat releases/redis/version)

if [[ ! -f stemcell/version ]]; then
  echo "missing resource input ${stage}/stemcell/version"
  exit
fi
STEMCELL_VERSION=$(cat stemcell/version)


release_name_version="redis/${REDIS_VERSION}"
stemcell_name_version="bosh-warden-boshlite-ubuntu-trusty-go_agent/${STEMCELL_VERSION}"

download_dir="compiled_packages"
mkdir ${download_dir}

manifest=pipeline/try-anything/manifests/manifest.yml
bosh -t ${bosh-target} -u ${bosh-username} -p ${bosh-password} -d ${manifest} \
  export compiled_packages ${release_name_version} ${stemcell_name_version} \
    ${download_dir}
