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

    for r in ap-northeast-1 ap-northeast-2 ap-northeast-3 ap-south-1 ap-southeast-1 ap-southeast-2 ca-central-1 eu-central-1 eu-west-1 eu-west-2 eu-west-3 sa-east-1 us-east-1 us-east-2 us-west-1 us-west-2
    do
        # import the key into $r region
        echo "Checking region... $r"
        aws ec2 import-key-pair --key-name $keyname --region $r --public-key-material file://$keylocation
    done

else
	echo "$1 not found"
fi