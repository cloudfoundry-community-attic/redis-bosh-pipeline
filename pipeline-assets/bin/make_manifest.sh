#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd $DIR/..
spiff merge \
  templates/redis/deployment.yml \
  templates/redis/jobs.yml \
  templates/infrastructure-warden.yml \
  templates/workload.yml \
  templates/stemcell.yml \
  pipeline/networking.yml \
  pipeline/properties.yml \
  pipeline/director.yml \
  pipeline/name.yml \
  pipeline/scaling.yml
