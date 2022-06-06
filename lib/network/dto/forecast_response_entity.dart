import 'dart:convert';
import 'package:flutter_weather_app/generated/json/base/json_field.dart';
import 'package:flutter_weather_app/generated/json/forecast_response_entity.g.dart';
import 'package:flutter_weather_app/network/dto/weather_entity.dart';

@JsonSerializable()
class ForecastResponseEntity {

	late String cod;
	late int message;
	late int cnt;
	late List<ForecastResponseList> list;
	late ForecastResponseCity city;
  
  ForecastResponseEntity();

  factory ForecastResponseEntity.fromJson(Map<String, dynamic> json) => $ForecastResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => $ForecastResponseEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ForecastResponseList {

	late int dt;
	late WeatherMain main;
	late List<WeatherWeather> weather;
	late WeatherClouds clouds;
	late WeatherWind wind;
  
  ForecastResponseList();

  factory ForecastResponseList.fromJson(Map<String, dynamic> json) => $ForecastResponseListFromJson(json);

  Map<String, dynamic> toJson() => $ForecastResponseListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ForecastResponseCity {

	late int id;
	late String name;
	late ForecastResponseCityCoord coord;
	late String country;
	late int population;
	late int timezone;
	late int sunrise;
	late int sunset;
  
  ForecastResponseCity();

  factory ForecastResponseCity.fromJson(Map<String, dynamic> json) => $ForecastResponseCityFromJson(json);

  Map<String, dynamic> toJson() => $ForecastResponseCityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ForecastResponseCityCoord {

	late double lat;
	late double lon;
  
  ForecastResponseCityCoord();

  factory ForecastResponseCityCoord.fromJson(Map<String, dynamic> json) => $ForecastResponseCityCoordFromJson(json);

  Map<String, dynamic> toJson() => $ForecastResponseCityCoordToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}