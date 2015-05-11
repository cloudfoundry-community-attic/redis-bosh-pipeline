#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR/..

bosh_() {
  bosh -t ${bosh_target} -u ${bosh_username} -p ${bosh_password} $@
}

stemcell=$(ls stemcell/*.tgz)
bosh_ upload stemcell ${stemcell}

release=$(ls releases/redis/*.tgz)
bosh_ upload release ${release}

compiled_package=$(ls compiled_packages/*.tgz)
bosh_ import compiled_packages ${compiled_package}
