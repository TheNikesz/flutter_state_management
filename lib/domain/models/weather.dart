class Weather {
  String cityName;
  String date;
  int weatherCode;
  double minTemperature;
  double maxTemperature;
  double minApparentTemperature;
  double maxApparentTemperature;
  String sunrise;
  String sunset;
  double rainSum;
  double snowfallSum;
  double windSpeed;
  int windDirection;
  
  Weather({
    required this.cityName,
    required this.date,
    required this.weatherCode,
    required this.minTemperature,
    required this.maxTemperature,
    required this.minApparentTemperature,
    required this.maxApparentTemperature,
    required this.sunrise,
    required this.sunset,
    required this.rainSum,
    required this.snowfallSum,
    required this.windSpeed,
    required this.windDirection,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Weather &&
      other.cityName == cityName &&
      other.date == date &&
      other.weatherCode == weatherCode &&
      other.minTemperature == minTemperature &&
      other.maxTemperature == maxTemperature &&
      other.minApparentTemperature == minApparentTemperature &&
      other.maxApparentTemperature == maxApparentTemperature &&
      other.sunrise == sunrise &&
      other.sunset == sunset &&
      other.rainSum == rainSum &&
      other.snowfallSum == snowfallSum &&
      other.windSpeed == windSpeed &&
      other.windDirection == windDirection;
  }

  @override
  int get hashCode {
    return cityName.hashCode ^
      date.hashCode ^
      weatherCode.hashCode ^
      minTemperature.hashCode ^
      maxTemperature.hashCode ^
      minApparentTemperature.hashCode ^
      maxApparentTemperature.hashCode ^
      sunrise.hashCode ^
      sunset.hashCode ^
      rainSum.hashCode ^
      snowfallSum.hashCode ^
      windSpeed.hashCode ^
      windDirection.hashCode;
  }

  Weather copyWith({
    String? cityName,
    String? date,
    int? weatherCode,
    double? minTemperature,
    double? maxTemperature,
    double? minApparentTemperature,
    double? maxApparentTemperature,
    String? sunrise,
    String? sunset,
    double? rainSum,
    double? snowfallSum,
    double? windSpeed,
    int? windDirection,
  }) {
    return Weather(
      cityName: cityName ?? this.cityName,
      date: date ?? this.date,
      weatherCode: weatherCode ?? this.weatherCode,
      minTemperature: minTemperature ?? this.minTemperature,
      maxTemperature: maxTemperature ?? this.maxTemperature,
      minApparentTemperature: minApparentTemperature ?? this.minApparentTemperature,
      maxApparentTemperature: maxApparentTemperature ?? this.maxApparentTemperature,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      rainSum: rainSum ?? this.rainSum,
      snowfallSum: snowfallSum ?? this.snowfallSum,
      windSpeed: windSpeed ?? this.windSpeed,
      windDirection: windDirection ?? this.windDirection,
    );
  }
}

class DailyWeather {
  List<String> dates;
  List<int> weatherCodes;
  List<double> minTemperatures;
  List<double> maxTemperatures;
  List<double> minApparentTemperatures;
  List<double> maxApparentTemperatures;
  List<String> sunrises;
  List<String> sunsets;
  List<double> rainSums;
  List<double> snowfallSums;
  List<double> windSpeeds;
  List<int> windDirections;

  DailyWeather({
    required this.dates,
    required this.weatherCodes,
    required this.minTemperatures,
    required this.minApparentTemperatures,
    required this.maxApparentTemperatures,
    required this.maxTemperatures,
    required this.sunrises,
    required this.sunsets,
    required this.rainSums,
    required this.snowfallSums,
    required this.windSpeeds,
    required this.windDirections,
  });

  factory DailyWeather.fromMap(Map<String, dynamic> map) {
    return DailyWeather(
      dates: List<String>.from(map['time']),
      weatherCodes: List<int>.from(map['weathercode']),
      minTemperatures: List<double>.from(map['temperature_2m_min']),
      maxTemperatures: List<double>.from(map['temperature_2m_max']),
      minApparentTemperatures: List<double>.from(map['apparent_temperature_min']),
      maxApparentTemperatures: List<double>.from(map['apparent_temperature_max']),
      sunrises: List<String>.from(map['sunrise']),
      sunsets: List<String>.from(map['sunset']),
      rainSums: List<double>.from(map['rain_sum']),
      snowfallSums: List<double>.from(map['snowfall_sum']),
      windSpeeds: List<double>.from(map['windspeed_10m_max']),
      windDirections: List<int>.from(map['winddirection_10m_dominant']),
    );
  }

  factory DailyWeather.fromJson(Map<String, dynamic> source) => DailyWeather.fromMap(source);
}

class WeeklyWeather {
  DailyWeather dailyWeather;
  
  WeeklyWeather({
    required this.dailyWeather,
  });

  factory WeeklyWeather.fromMap(Map<String, dynamic> map) {
    return WeeklyWeather(
      dailyWeather: DailyWeather.fromMap(map['daily']),
    );
  }

  factory WeeklyWeather.fromJson(Map<String, dynamic> source) => WeeklyWeather.fromMap(source);
}