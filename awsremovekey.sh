#!/bin/bash

# script to remove an aws key to all aws regions
# Pre-requisite for this: Assuming you have the following:
# 1) Installed the aws cli
# 2) run aws configure to set up the credentials
# 3) Output is in JSON

if test $# -ne 1
then
	echo "Usage: ./awsremovekey.sh <keyname>"
	exit -1
fi

# obtain all the regions
ec2regions=$(sh awslistregions.sh)

keyname="$1"

for r in $ec2regions
do
    echo "Checking region... $r"
    aws ec2 delete-key-pair --key-name $keyname --region $r
done