# Weather app

Weather application in four versions, each using a different state management approach (BLoC, Riverpod, Inherited Widget, Triple+GetIt). The main purpose was to test the impact of these state management approaches on performance, which was a topic of the master's thesis.

## Scope of work

[TheNikesz](https://github.com/TheNikesz): Weather application built from the ground up using BLoC and its Riverpod port

[30james00](https://github.com/30james00): Inherited Widget and Triple with GetIt port of the application

## Technologies

* Dart: 2.19.4
* Flutter: 3.7.7
* flutter_bloc: 8.1.2
* flutter_riverpod: 2.2.0
* flutter_triple: 2.0.0
* get_it: 7.2.0

## Features

* select the city from the search
* check the day weather forecast for the next week for the selected city
* check the night weather forecast for the next week for the selected city
* check the weather details for one of the days
* display the temperature as a chart
* change and save settings such as temperature unit, start view and time of day

## Illustrations

![Main page of the application](https://github.com/TheNikesz/flutter_state_management/blob/main/docs/main.png)
![Main page of the application with temperature chart](https://github.com/TheNikesz/flutter_state_management/blob/main/docs/chart.png)
![Weather details page of the application](https://github.com/TheNikesz/flutter_state_management/blob/main/docs/details.png)
![Settings page of the application](https://github.com/TheNikesz/flutter_state_management/blob/main/docs/settings.png)
![Main page of the application with temperature in Fahrenheit](https://github.com/TheNikesz/flutter_state_management/blob/main/docs/fahrenheit.png)
![Main page of the application with night weather and temperature in Fahrenheit](https://github.com/TheNikesz/flutter_state_management/blob/main/docs/night.png)