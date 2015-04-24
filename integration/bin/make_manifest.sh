#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd $DIR/..

REDIS_VERSION=$(cat releases/redis/version)
STEMCELL_VERSION=$(cat stemcell/version)

mkdir -p manifests
cat >manifests/stub.yml <<EOF
---
meta:
  release_versions:
    redis: $REDIS_VERSION
  stemcell:
    version: $STEMCELL_VERSION
EOF

spiff merge \
  templates/redis/deployment.yml \
  templates/redis/jobs.yml \
  templates/infrastructure-warden.yml \
  templates/workload.yml \
  templates/stemcell.yml \
  environment/networking.yml \
  environment/properties.yml \
  environment/director.yml \
  environment/name.yml \
  environment/scaling.yml \
  manifests/stub.yml
