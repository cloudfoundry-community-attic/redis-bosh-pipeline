#!/bin/bash

assets_tgz=$1; shift

set -e

tar xfz ${assets_tgz}

ls -opR pipeline-assets/
