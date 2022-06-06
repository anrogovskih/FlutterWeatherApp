import 'package:flutter_weather_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_weather_app/network/dto/forecast_response_entity.dart';

import '../../network/dto/weather_entity.dart';

ForecastResponseEntity $ForecastResponseEntityFromJson(Map<String, dynamic> json) {
	final ForecastResponseEntity forecastResponseEntity = ForecastResponseEntity();
	final String? cod = jsonConvert.convert<String>(json['cod']);
	if (cod != null) {
		forecastResponseEntity.cod = cod;
	}
	final int? message = jsonConvert.convert<int>(json['message']);
	if (message != null) {
		forecastResponseEntity.message = message;
	}
	final int? cnt = jsonConvert.convert<int>(json['cnt']);
	if (cnt != null) {
		forecastResponseEntity.cnt = cnt;
	}
	final List<ForecastResponseList>? list = jsonConvert.convertListNotNull<ForecastResponseList>(json['list']);
	if (list != null) {
		forecastResponseEntity.list = list;
	}
	final ForecastResponseCity? city = jsonConvert.convert<ForecastResponseCity>(json['city']);
	if (city != null) {
		forecastResponseEntity.city = city;
	}
	return forecastResponseEntity;
}

Map<String, dynamic> $ForecastResponseEntityToJson(ForecastResponseEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cod'] = entity.cod;
	data['message'] = entity.message;
	data['cnt'] = entity.cnt;
	data['list'] =  entity.list.map((v) => v.toJson()).toList();
	data['city'] = entity.city.toJson();
	return data;
}

ForecastResponseList $ForecastResponseListFromJson(Map<String, dynamic> json) {
	final ForecastResponseList forecastResponseList = ForecastResponseList();
	final int? dt = jsonConvert.convert<int>(json['dt']);
	if (dt != null) {
		forecastResponseList.dt = dt;
	}
	final WeatherMain? main = jsonConvert.convert<WeatherMain>(json['main']);
	if (main != null) {
		forecastResponseList.main = main;
	}
	final List<WeatherWeather>? weather = jsonConvert.convertListNotNull<WeatherWeather>(json['weather']);
	if (weather != null) {
		forecastResponseList.weather = weather;
	}
	final WeatherClouds? clouds = jsonConvert.convert<WeatherClouds>(json['clouds']);
	if (clouds != null) {
		forecastResponseList.clouds = clouds;
	}
	final WeatherWind? wind = jsonConvert.convert<WeatherWind>(json['wind']);
	if (wind != null) {
		forecastResponseList.wind = wind;
	}
	return forecastResponseList;
}

Map<String, dynamic> $ForecastResponseListToJson(ForecastResponseList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['dt'] = entity.dt;
	data['main'] = entity.main.toJson();
	data['weather'] =  entity.weather.map((v) => v.toJson()).toList();
	data['clouds'] = entity.clouds.toJson();
	data['wind'] = entity.wind.toJson();
	return data;
}

WeatherMain $WeatherMainFromJson(Map<String, dynamic> json) {
	final WeatherMain weatherMain = WeatherMain();
	final double? temp = jsonConvert.convert<double>(json['temp']);
	if (temp != null) {
		weatherMain.temp = temp;
	}
	final double? feelsLike = jsonConvert.convert<double>(json['feels_like']);
	if (feelsLike != null) {
		weatherMain.feelsLike = feelsLike;
	}
	final double? tempMin = jsonConvert.convert<double>(json['temp_min']);
	if (tempMin != null) {
		weatherMain.tempMin = tempMin;
	}
	final double? tempMax = jsonConvert.convert<double>(json['temp_max']);
	if (tempMax != null) {
		weatherMain.tempMax = tempMax;
	}
	final int? humidity = jsonConvert.convert<int>(json['humidity']);
	if (humidity != null) {
		weatherMain.humidity = humidity;
	}
	return weatherMain;
}

Map<String, dynamic> $WeatherMainToJson(WeatherMain entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['temp'] = entity.temp;
	data['feels_like'] = entity.feelsLike;
	data['temp_min'] = entity.tempMin;
	data['temp_max'] = entity.tempMax;
	data['humidity'] = entity.humidity;
	return data;
}

WeatherWeather $WeatherWeatherFromJson(Map<String, dynamic> json) {
	final WeatherWeather weatherWeather = WeatherWeather();
	final String? main = jsonConvert.convert<String>(json['main']);
	if (main != null) {
		weatherWeather.main = main;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		weatherWeather.description = description;
	}
	final String? icon = jsonConvert.convert<String>(json['icon']);
	if (icon != null) {
		weatherWeather.icon = icon;
	}
	return weatherWeather;
}

Map<String, dynamic> $WeatherWeatherToJson(WeatherWeather entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['main'] = entity.main;
	data['description'] = entity.description;
	data['icon'] = entity.icon;
	return data;
}

WeatherClouds $WeatherCloudsFromJson(Map<String, dynamic> json) {
	final WeatherClouds weatherClouds = WeatherClouds();
	final int? all = jsonConvert.convert<int>(json['all']);
	if (all != null) {
		weatherClouds.all = all;
	}
	return weatherClouds;
}

Map<String, dynamic> $WeatherCloudsToJson(WeatherClouds entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['all'] = entity.all;
	return data;
}

WeatherWind $WeatherWindFromJson(Map<String, dynamic> json) {
	final WeatherWind weatherWind = WeatherWind();
	final double? speed = jsonConvert.convert<double>(json['speed']);
	if (speed != null) {
		weatherWind.speed = speed;
	}
	final int? deg = jsonConvert.convert<int>(json['deg']);
	if (deg != null) {
		weatherWind.deg = deg;
	}
	final double? gust = jsonConvert.convert<double>(json['gust']);
	if (gust != null) {
		weatherWind.gust = gust;
	}
	return weatherWind;
}

Map<String, dynamic> $WeatherWindToJson(WeatherWind entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['speed'] = entity.speed;
	data['deg'] = entity.deg;
	data['gust'] = entity.gust;
	return data;
}

ForecastResponseCity $ForecastResponseCityFromJson(Map<String, dynamic> json) {
	final ForecastResponseCity forecastResponseCity = ForecastResponseCity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		forecastResponseCity.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		forecastResponseCity.name = name;
	}
	final ForecastResponseCityCoord? coord = jsonConvert.convert<ForecastResponseCityCoord>(json['coord']);
	if (coord != null) {
		forecastResponseCity.coord = coord;
	}
	final String? country = jsonConvert.convert<String>(json['country']);
	if (country != null) {
		forecastResponseCity.country = country;
	}
	final int? population = jsonConvert.convert<int>(json['population']);
	if (population != null) {
		forecastResponseCity.population = population;
	}
	final int? timezone = jsonConvert.convert<int>(json['timezone']);
	if (timezone != null) {
		forecastResponseCity.timezone = timezone;
	}
	final int? sunrise = jsonConvert.convert<int>(json['sunrise']);
	if (sunrise != null) {
		forecastResponseCity.sunrise = sunrise;
	}
	final int? sunset = jsonConvert.convert<int>(json['sunset']);
	if (sunset != null) {
		forecastResponseCity.sunset = sunset;
	}
	return forecastResponseCity;
}

Map<String, dynamic> $ForecastResponseCityToJson(ForecastResponseCity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['coord'] = entity.coord.toJson();
	data['country'] = entity.country;
	data['population'] = entity.population;
	data['timezone'] = entity.timezone;
	data['sunrise'] = entity.sunrise;
	data['sunset'] = entity.sunset;
	return data;
}

ForecastResponseCityCoord $ForecastResponseCityCoordFromJson(Map<String, dynamic> json) {
	final ForecastResponseCityCoord forecastResponseCityCoord = ForecastResponseCityCoord();
	final double? lat = jsonConvert.convert<double>(json['lat']);
	if (lat != null) {
		forecastResponseCityCoord.lat = lat;
	}
	final double? lon = jsonConvert.convert<double>(json['lon']);
	if (lon != null) {
		forecastResponseCityCoord.lon = lon;
	}
	return forecastResponseCityCoord;
}

Map<String, dynamic> $ForecastResponseCityCoordToJson(ForecastResponseCityCoord entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['lat'] = entity.lat;
	data['lon'] = entity.lon;
	return data;
}