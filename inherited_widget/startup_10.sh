# start flutter application 10 time
for i in {1..10}
do
    flutter drive --target=test_driver/app.dart --profile -d macos
done