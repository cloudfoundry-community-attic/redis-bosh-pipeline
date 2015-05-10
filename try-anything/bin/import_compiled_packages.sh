#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR/..
set -e

# compiled packages are in subfolder:
# bosh-warden-boshlite-ubuntu-trusty-go_agent/redis/redis-9.1-bosh-warden-boshlite-ubuntu-trusty-go_agent-2776.tgz
compiled_package=$(ls compiled_packages/*.tgz)

bosh -t ${bosh_target} -u ${bosh_username} -p ${bosh_password} \
  import compiled_packages ${compiled_package}
