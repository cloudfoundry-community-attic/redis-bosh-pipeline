#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
manifest=${manifest:-"manifest.yml"}

set -e

cd $DIR
./make_manifest.sh $@ > $manifest
