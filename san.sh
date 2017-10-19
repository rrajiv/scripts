#!/bin/bash

# check the command line arguments
# needs 2 arguments

if test $# -ne 1
then
	echo "Usage: ./san.sh <hostname>"
	exit -1
fi

echo | openssl s_client -showcerts -connect "$1":443 2>/dev/null | openssl x509 -noout -text | grep -i "DNS" | sed -e "s/DNS://g" | sed -e "s/ //g" | tr "," "\n" | sort | awk '{ print $1 }'