#!/bin/bash

if [[ ! -f release-version/number ]]; then
  echo "save_deployment_pipeline.sh requires release-version/number to contain the candidate version number"
  exit 1
fi
release_version=$(cat release-version/number)

mkdir -p pipeline-assets
cp resource-bosh-release-redis/*.tgz pipeline-assets/
cp resource-bosh-stemcell/*.tgz pipeline-assets/

pipeline=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )
cp -r $pipeline/templates pipeline-assets/
cp -r $pipeline/bin pipeline-assets/

# not /pipeline as each subsequent stage has own pipeline/ folder

ls -la pipeline-assets/

tar -cvzf pipeline-assets-${release_version}.tgz pipeline-assets

ls -la pipeline-assets*.tgz
