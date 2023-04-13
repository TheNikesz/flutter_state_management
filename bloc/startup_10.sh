# start flutter application 10 time
for i in {1..10}
do
    flutter run --trace-startup --profile -d linux
done