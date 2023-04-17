# start flutter application 10 time
for i in {1..10}
do
    # echo in green color
    echo -e "\033[32m start flutter application $i time \033[0m"
    flutter drive --target=test_driver/app.dart --profile -d linux
    sleep 3;
done