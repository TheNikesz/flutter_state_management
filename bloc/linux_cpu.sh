#!/bin/bash
# save output with pid to variable
# flutter drive --target=test_driver/app.dart --profile -d linux | grep "pid" | awk '{print $2}'
# save output of afforementioned command to variable
pid=(flutter drive --target=test_driver/app.dart --profile -d linux) &

# read date and from system
day=$(date +%Y%m%d%H%M%S)
# for loop to get cpu usage of linux process every 100 miliseconds
# save it to csv file with name containing day and time
# while loop when i is less than 100
i=0
while [ $i -lt 100 ]
do
  # execute when pid is not empty
  if [ -n "$pid" ]
  then
    top -b -n 2 -d 0.1 -p $pid | tail -1 | awk '{print $9";"}' >> cpu_usage_$day.csv
    i=$((i+1))
    sleep 0.1
  fi
done