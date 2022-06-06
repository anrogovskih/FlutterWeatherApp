import 'dart:convert';
import 'package:flutter_weather_app/generated/json/base/json_field.dart';
import 'package:flutter_weather_app/generated/json/weather_entity.g.dart';

@JsonSerializable()
class WeatherEntity {

	late WeatherCoord coord;
	late List<WeatherWeather> weather;
	late WeatherMain main;
	late WeatherWind wind;
	late WeatherClouds clouds;
	late WeatherSys sys;
	late int timezone;
	late int id;
	late String name;
	late int cod;
  
  WeatherEntity();

  factory WeatherEntity.fromJson(Map<String, dynamic> json) => $WeatherEntityFromJson(json);

  Map<String, dynamic> toJson() => $WeatherEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WeatherCoord {

	late double lon;
	late double lat;
  
  WeatherCoord();

  factory WeatherCoord.fromJson(Map<String, dynamic> json) => $WeatherCoordFromJson(json);

  Map<String, dynamic> toJson() => $WeatherCoordToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WeatherWeather {

	late String main;
	late String description;
	late String icon;
  
  WeatherWeather();

  factory WeatherWeather.fromJson(Map<String, dynamic> json) => $WeatherWeatherFromJson(json);

  Map<String, dynamic> toJson() => $WeatherWeatherToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WeatherMain {

	late double temp;
	@JSONField(name: "feels_like")
	late double feelsLike;
	@JSONField(name: "temp_min")
	late double tempMin;
	@JSONField(name: "temp_max")
	late double tempMax;
	late int pressure;
	late int humidity;
	@JSONField(name: "sea_level")
	late int seaLevel;
	@JSONField(name: "grnd_level")
	late int grndLevel;
  
  WeatherMain();

  factory WeatherMain.fromJson(Map<String, dynamic> json) => $WeatherMainFromJson(json);

  Map<String, dynamic> toJson() => $WeatherMainToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WeatherWind {

	late double speed;
	late int deg;
	double? gust;
  
  WeatherWind();

  factory WeatherWind.fromJson(Map<String, dynamic> json) => $WeatherWindFromJson(json);

  Map<String, dynamic> toJson() => $WeatherWindToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WeatherClouds {

	late int all;
  
  WeatherClouds();

  factory WeatherClouds.fromJson(Map<String, dynamic> json) => $WeatherCloudsFromJson(json);

  Map<String, dynamic> toJson() => $WeatherCloudsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WeatherSys {

	late int sunrise;
	late int sunset;
  
  WeatherSys();

  factory WeatherSys.fromJson(Map<String, dynamic> json) => $WeatherSysFromJson(json);

  Map<String, dynamic> toJson() => $WeatherSysToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}