#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd $DIR/..
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
  environment/scaling.yml
