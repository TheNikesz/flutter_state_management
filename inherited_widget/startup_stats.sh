# execute commands 10 times
for i in {11..20}
do
    # echo in green color
    echo -e "\033[32m start flutter application $i time \033[0m"
    pid=$(flutter run --profile --trace-startup -d linux | grep "pid" | awk '{print $3}')
    # rename file to startup_trace_$i.json
    mv ./build/start_up_info.json ./build/start_up_info_$i.json
    # echo info about killing the process
    sleep 3;
    echo -e "\033[32m kill process $pid \033[0m"
    kill $pid
    sleep 3;
done
