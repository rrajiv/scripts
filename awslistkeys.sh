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

for r in ap-northeast-1 ap-northeast-2 ap-northeast-3 ap-south-1 ap-southeast-1 ap-southeast-2 ca-central-1 eu-central-1 eu-west-1 eu-west-2 eu-west-3 sa-east-1 us-east-1 us-east-2 us-west-1 us-west-2
do
    # import the key into $r region
    echo "Checking region... $r"
    aws ec2 describe-key-pairs --region $r
done