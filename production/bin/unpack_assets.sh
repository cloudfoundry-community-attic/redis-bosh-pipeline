#!/bin/bash

assets_tgz=$1; shift
pipeline_stage_dir=$1; shift

set -e

tar xfz ${assets_tgz}

ls -opR pipeline-assets/

cp -r pipeline-assets/bin $pipeline_stage_dir/
cp -r pipeline-assets/templates $pipeline_stage_dir/
