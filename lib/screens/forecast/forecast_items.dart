import 'package:flutter_weather_app/extensions.dart';

import '../../network/dto/forecast_response_entity.dart';

abstract class ForecastItem {
  String getIconUrl();
  String getDescription();
}

class ForecastForDay implements ForecastItem {
  final List<ForecastForTime> forecast;
  final int timestamp;
  bool isOpen = false;
  String? _iconUrl;
  String? _weatherDescription;
  int? _maxTemp;
  int? _minTemp;

  ForecastForDay(List<ForecastResponseList> forecast)
      : forecast = forecast.map((e) => ForecastForTime(e)).toList(),
        timestamp = forecast.first.dt * 1000;

  @override
  String getIconUrl() {
    return _iconUrl ?? buildWeatherForDay().iconUrl;
  }

  String getDescription() {
    return _weatherDescription ?? buildWeatherForDay().description;
  }

  int getMaxTemp() {
    return _maxTemp ?? buildWeatherForDay().maxTemp;
  }

  int getMinTemp() {
    return _minTemp ?? buildWeatherForDay().minTemp;
  }

  WeatherForDay buildWeatherForDay() {
    double minTemp = double.maxFinite;
    double maxTemp = double.minPositive;
    Map<String, int> weatherMap = {};
    Map<String, int> iconsMap = {};

    for (int i = 0; i < forecast.length; i++) {
      var element = forecast[i].forecast;
      if (element.main.tempMin < minTemp) {
        minTemp = element.main.tempMin;
      }
      if (element.main.tempMax > maxTemp) {
        maxTemp = element.main.tempMax;
      }
      for (int i = 0; i < element.weather.length; i++) {
        var weather = element.weather[i];
        var currentWeatherCount = weatherMap[weather.description] ?? 0;
        weatherMap[weather.description] = ++currentWeatherCount;

        var currentIconCount = iconsMap[weather.icon] ?? 0;
        iconsMap[weather.icon] = ++currentIconCount;
      }
    }
    this._minTemp = minTemp.toInt();
    this._maxTemp = maxTemp.toInt();
    var icon = iconsMap.keyWithMaxValue()?.asIconUrl() ?? '';
    _iconUrl = icon;
    var weather = weatherMap.keyWithMaxValue() ?? '';
    _weatherDescription = weather;

    return WeatherForDay(icon, weather, maxTemp.toInt(), minTemp.toInt());
  }
}

class WeatherForDay {
  final String iconUrl;
  final String description;
  final int maxTemp;
  final int minTemp;

  WeatherForDay(this.iconUrl, this.description, this.maxTemp, this.minTemp);
}

class ForecastForTime implements ForecastItem {
  final ForecastResponseList forecast;

  ForecastForTime(this.forecast);

  @override
  String getDescription() {
    return forecast.weather.first.description;
  }

  @override
  String getIconUrl() {
    return forecast.weather.first.icon.asIconUrl();
  }
}
