#!/usr/bin/env ruby

credentials = File.read("credentials.yml")

try_anything_host=`cat ~/.bosh_config | yaml2json | jq -r '.aliases.target["try-anything-bosh-lite"]'`.strip
credentials[/^bosh-try-anything-target:.*/] = "bosh-try-anything-target: #{try_anything_host}"

preprod_host=`cat ~/.bosh_config | yaml2json | jq -r '.aliases.target["preprod-bosh-lite"]'`.strip
credentials[/^bosh-preprod-target:.*/] = "bosh-preprod-target: #{preprod_host}"

production_host=`cat ~/.bosh_config | yaml2json | jq -r '.aliases.target["prod-bosh-lite"]'`.strip
credentials[/^bosh-production-target:.*/] = "bosh-production-target: #{production_host}"

File.open("credentials.yml", "w") {|f| f << credentials }

# DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# cd $DIR/..
# set -e
#
# # Updates credentials.yml with IP for 3 different BOSH for three diff deployments
#
# if [[ ! -f credentials.yml ]]; then
#   echo "Create your credentials.yml first"
#   exit 1
# fi
# if [[ "$(which yaml2json)X" == "X" ]]; then
#   echo "Install yaml2json first"
#   exit 1
# fi
# if [[ "$(which jq)X" == "X" ]]; then
#   echo "Install jq first"
#   exit 1
# fi
#
# try_anything_host=$(cat ~/.bosh_config | yaml2json | jq -r '.aliases.target["try-anything-bosh-lite"]')
# if [[ "${try_anything_host}X" == "X" ]]; then
#   echo "bosh target try-anything-bosh-lite is missing"
#   exit 1
# fi
#
# preprod_host=$(cat ~/.bosh_config | yaml2json | jq -r '.aliases.target["preprod-bosh-lite"]')
# if [[ "${preprod_host}X" == "X" ]]; then
#   echo "bosh target preprod-bosh-lite is missing"
#   exit 1
# fi
#
# prod_host=$(cat ~/.bosh_config | yaml2json | jq -r '.aliases.target["prod-bosh-lite"]')
# if [[ "${prod_host}X" == "X" ]]; then
#   echo "bosh target prod-bosh-lite is missing"
#   exit 1
# fi
#
# perl -pi -e "s/bosh-try-anything-target:.*$/bosh-try-anything-target: try_anything_host/g" credentials.yml
# perl -pi -e "s/bosh-preprod-target:.*/bosh-preprod-target: preprod_host/g" credentials.yml
# perl -pi -e "s/bosh-production-target:.*/bosh-production-target: prod_host/g" credentials.yml
