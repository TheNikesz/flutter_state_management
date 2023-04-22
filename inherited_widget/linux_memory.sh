#!/bin/bash

for run in {1..20}
do
  # echo run number in green color
  echo -e "\033[32m run number $run \033[0m"
  day=$(date +%Y%m%d%H%M%S)
  # save output with pid to variable
  flutter drive --target=test_driver/app.dart --profile -d linux | grep "ram" | awk '{print $3";"}' > ./build/ram_$day.csv
  sleep 1
done