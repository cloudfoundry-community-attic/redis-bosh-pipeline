#!/bin/bash

assets_tgz=$1; shift
pipeline_stage_dir=$1; shift

set -e

tar xfz ${assets_tgz}

ls -opR pipeline-assets/

rm -rf $pipeline_stage_dir/bin
cp -r pipeline-assets/bin $pipeline_stage_dir/

rm -rf $pipeline_stage_dir/templates
cp -r pipeline-assets/templates $pipeline_stage_dir/

rm -rf $pipeline_stage_dir/releases
cp -r pipeline-assets/releases $pipeline_stage_dir/

rm -rf $pipeline_stage_dir/stemcell
cp -r pipeline-assets/stemcell $pipeline_stage_dir/
