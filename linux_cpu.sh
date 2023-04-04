#!/bin/bash

# read date and from system
day=$(date +%Y%m%d%H%M%S)
# for loop to get cpu usage of linux process every 100 miliseconds
# save it to csv file with name containing day and time
for i in {1..100}
do
  top -b -n 2 -d 0.1 -p 52466 | tail -1 | awk '{print $9";"}' >> cpu_usage_$day.csv
  sleep 0.1
done