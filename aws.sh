#!/bin/bash

# script to quickly create an AWS US EAST vm
# Pre-requisite for this: Assuming you have the following:
# 1) Installed the aws cli
# 2) run aws configure to set up the credentials
# 3) Output is in JSON

# this is the ami for ubuntu us-east-1
awsami="ami-41e0b93b"
awssecgroupname="us-east-1 sec grp"
awssecgroupdesc="Rajiv us-east-1 sec grp"
awskeyname="us-eastva"
awsinstancetype="m1.small"

echo "---"
echo "step 1: create a new security group"

# step 1: create a security group for the region
awssecgroupid=$(aws ec2 create-security-group --group-name "$awssecgroupname" --description "$awssecgroupdesc" | jq ".GroupId" | sed -e s'/\"//g')
echo $awssecgroupid "-> sec group id"
echo "---"

# step 2: set the security group permissions
echo "step 2: set up the security group permissions"

# obtain the local ip of the machine
currentip=$(curl -sk http://checkip.amazonaws.com/)
echo $currentip "-> current ip"

# allow SSH into the group from current ip
aws ec2 authorize-security-group-ingress --group-id $awssecgroupid --protocol tcp --port 22 --cidr $currentip/32

echo "status of the new security group:"

aws ec2 describe-security-groups --group-id $awssecgroupid

echo "---"
echo "step 3: create a single m1.small instance in us-east-1"

aws ec2 run-instances --image-id $awsami --key-name $awskeyname --security-group-ids $awssecgroupid --instance-type $awsinstancetype --placement AvailabilityZone=us-east-1a --block-device-mappings DeviceName=/dev/sdh,Ebs={VolumeSize=8} --count 1