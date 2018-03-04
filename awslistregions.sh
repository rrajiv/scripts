#!/bin/bash

# this script is used to obtain a list of regions in ec2
aws ec2 describe-regions | jq '.[][].RegionName' | sed -e 's/\"//g' | tr '\n' ' '