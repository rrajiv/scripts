#!/bin/bash

# script to list keys in all aws regions
# Pre-requisite for this: Assuming you have the following:
# 1) Installed the aws cli
# 2) run aws configure to set up the credentials
# 3) Output is in JSON

if test $# -ne 0
then
	echo "Usage: ./awslistkeys.sh"
	exit -1
fi

# obtain all the regions
ec2regions=$(sh awslistregions.sh)

for r in $ec2regions
do
    echo "Checking region... $r"
    aws ec2 describe-key-pairs --region $r
done