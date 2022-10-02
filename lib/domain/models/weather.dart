class Weather {
  String date;
  double weatherCode;
  double minTemperature;
  double maxTemperature;
  
  Weather({
    required this.date,
    required this.weatherCode,
    required this.minTemperature,
    required this.maxTemperature,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Weather &&
      other.date == date &&
      other.weatherCode == weatherCode &&
      other.minTemperature == minTemperature &&
      other.maxTemperature == maxTemperature;
  }

  @override
  int get hashCode {
    return date.hashCode ^
      weatherCode.hashCode ^
      minTemperature.hashCode ^
      maxTemperature.hashCode;
  }

  Weather copyWith({
    String? date,
    double? weatherCode,
    double? minTemperature,
    double? maxTemperature,
  }) {
    return Weather(
      date: date ?? this.date,
      weatherCode: weatherCode ?? this.weatherCode,
      minTemperature: minTemperature ?? this.minTemperature,
      maxTemperature: maxTemperature ?? this.maxTemperature,
    );
  }
}

class DailyWeather {
  List<String> dates;
  List<double> weatherCodes;
  List<double> minTemperatures;
  List<double> maxTemperatures;
  
  DailyWeather({
    required this.dates,
    required this.weatherCodes,
    required this.minTemperatures,
    required this.maxTemperatures,
  });

  factory DailyWeather.fromMap(Map<String, dynamic> map) {
    return DailyWeather(
      dates: List<String>.from(map['time']),
      weatherCodes: List<double>.from(map['weathercode']),
      minTemperatures: List<double>.from(map['temperature_2m_min']),
      maxTemperatures: List<double>.from(map['temperature_2m_max']),
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
