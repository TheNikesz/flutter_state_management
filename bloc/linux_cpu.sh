#!/bin/bash
# save output with pid to variable
flutter drive --target=test_driver/app.dart --profile -d linux > pid.txt &
sleep 2

# read date and from system
day=$(date +%Y%m%d%H%M%S)
# for loop to get cpu usage of linux process every 100 miliseconds
# save it to csv file with name containing day and time
# while loop when i is less than 100

# run loop when pid is empty
while [ -z "$pid" ]
do
  # read pid from pid.txt
  pid=$(cat pid.txt | grep "pid" | awk '{print $2}')
  sleep 0.5
done

echo $pid

top -b -n 50 -d 0.2 -p $pid | grep $pid | awk '{print $11","$9","$10";"}'  >> cpu_usage_$day.csv