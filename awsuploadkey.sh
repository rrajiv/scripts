#!/bin/bash

# script to upload an aws key to all aws regions
# Pre-requisite for this: Assuming you have the following:
# 1) Installed the aws cli
# 2) run aws configure to set up the credentials
# 3) Output is in JSON

if test $# -ne 1
then
	echo "Usage: ./awsuploadkey.sh <pathtokey>"
	exit -1
fi

# check that the key file exists on the machine
if [ -f "$1" ]
then
    # file exists, save the location
    keylocation="$1"

    # this should be a unique name but for now, keep it as awskey
    keyname="awskey"

    # obtain all the regions
    ec2regions=$(sh awslistregions.sh)
    
    for r in $ec2regions
    do
        # import the key into $r region
        echo "Checking region... $r"
        aws ec2 import-key-pair --key-name $keyname --region $r --public-key-material file://$keylocation
    done

else
	echo "$1 not found"
fi