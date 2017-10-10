#!/bin/bash
#
# This program dumps out the current times of various time zones of the world
# This was created because of the global nature of my work and the need to know
# the local times for important locations.
# 
# Current list:
# Hawaii
# Pacific
# Costa Rica
# Eastern
# GMT
# London
# Zurich
# Dubai
# Bangalore
# Singapore
# Tokyo
# Sydney

########

# define the date format
dateformat="%A %B %e %r %Z %Y %z"

# array1 - all the timezone labels
# array2 - all the locations
# array1 and array2 are 1:1 mapping

timezonelabel=('US/Hawaii' 'US/Pacific' 'America/Costa_Rica' 'US/Eastern' 'UTC' 'Europe/London' 'Europe/Zurich' 'Asia/Dubai' 'Asia/Calcutta' 'Asia/Singapore' 'Asia/Tokyo' 'Australia/Sydney')
timezonename=('Hawaii' 'Pacific' 'Costa Rica' 'Eastern' 'GMT' 'London' 'Zurich' 'Dubai' 'Bangalore' 'Singapore' 'Tokyo' 'Sydney')

# loop through the timezone array
i="0"
len="${#timezonelabel[@]}" 

while [ $i -lt $len ]
do
    tzl=${timezonelabel[$i]}
    tzn=${timezonename[$i]}    
    env TZ=$tzl date +"$tzn - $dateformat"
    i=$[$i+1]
done