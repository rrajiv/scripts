#!/bin/bash

if test $# -ne 1
then
	echo "Usage: ./dig2.sh <hostname>"
	exit -1
fi

# get the first cli param
hostname=$1

# calculate the ips
ipv4=$(dig $hostname A +short | egrep -e '\d+\.\d+.\d+.\d+' | head -n1)
ipv6=$(dig $hostname AAAA +short | egrep -e '[a-zA-Z0-9]+:[a-zA-Z0-9:]+' | head -n1)

echo "$hostname - $ipv4"
echo "$hostname - $ipv6"