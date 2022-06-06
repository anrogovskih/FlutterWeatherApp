import 'package:flutter_weather_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_weather_app/network/dto/weather_entity.dart';

WeatherEntity $WeatherEntityFromJson(Map<String, dynamic> json) {
	final WeatherEntity weatherEntity = WeatherEntity();
	final WeatherCoord? coord = jsonConvert.convert<WeatherCoord>(json['coord']);
	if (coord != null) {
		weatherEntity.coord = coord;
	}
	final List<WeatherWeather>? weather = jsonConvert.convertListNotNull<WeatherWeather>(json['weather']);
	if (weather != null) {
		weatherEntity.weather = weather;
	}
	final WeatherMain? main = jsonConvert.convert<WeatherMain>(json['main']);
	if (main != null) {
		weatherEntity.main = main;
	}
	final WeatherWind? wind = jsonConvert.convert<WeatherWind>(json['wind']);
	if (wind != null) {
		weatherEntity.wind = wind;
	}
	final WeatherClouds? clouds = jsonConvert.convert<WeatherClouds>(json['clouds']);
	if (clouds != null) {
		weatherEntity.clouds = clouds;
	}
	final WeatherSys? sys = jsonConvert.convert<WeatherSys>(json['sys']);
	if (sys != null) {
		weatherEntity.sys = sys;
	}
	final int? timezone = jsonConvert.convert<int>(json['timezone']);
	if (timezone != null) {
		weatherEntity.timezone = timezone;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		weatherEntity.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		weatherEntity.name = name;
	}
	final int? cod = jsonConvert.convert<int>(json['cod']);
	if (cod != null) {
		weatherEntity.cod = cod;
	}
	return weatherEntity;
}

Map<String, dynamic> $WeatherEntityToJson(WeatherEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['coord'] = entity.coord.toJson();
	data['weather'] =  entity.weather.map((v) => v.toJson()).toList();
	data['main'] = entity.main.toJson();
	data['wind'] = entity.wind.toJson();
	data['clouds'] = entity.clouds.toJson();
	data['sys'] = entity.sys.toJson();
	data['timezone'] = entity.timezone;
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['cod'] = entity.cod;
	return data;
}

WeatherCoord $WeatherCoordFromJson(Map<String, dynamic> json) {
	final WeatherCoord weatherCoord = WeatherCoord();
	final double? lon = jsonConvert.convert<double>(json['lon']);
	if (lon != null) {
		weatherCoord.lon = lon;
	}
	final double? lat = jsonConvert.convert<double>(json['lat']);
	if (lat != null) {
		weatherCoord.lat = lat;
	}
	return weatherCoord;
}

Map<String, dynamic> $WeatherCoordToJson(WeatherCoord entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['lon'] = entity.lon;
	data['lat'] = entity.lat;
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
	final int? pressure = jsonConvert.convert<int>(json['pressure']);
	if (pressure != null) {
		weatherMain.pressure = pressure;
	}
	final int? humidity = jsonConvert.convert<int>(json['humidity']);
	if (humidity != null) {
		weatherMain.humidity = humidity;
	}
	final int? seaLevel = jsonConvert.convert<int>(json['sea_level']);
	if (seaLevel != null) {
		weatherMain.seaLevel = seaLevel;
	}
	final int? grndLevel = jsonConvert.convert<int>(json['grnd_level']);
	if (grndLevel != null) {
		weatherMain.grndLevel = grndLevel;
	}
	return weatherMain;
}

Map<String, dynamic> $WeatherMainToJson(WeatherMain entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['temp'] = entity.temp;
	data['feels_like'] = entity.feelsLike;
	data['temp_min'] = entity.tempMin;
	data['temp_max'] = entity.tempMax;
	data['pressure'] = entity.pressure;
	data['humidity'] = entity.humidity;
	data['sea_level'] = entity.seaLevel;
	data['grnd_level'] = entity.grndLevel;
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

WeatherSys $WeatherSysFromJson(Map<String, dynamic> json) {
	final WeatherSys weatherSys = WeatherSys();
	final int? sunrise = jsonConvert.convert<int>(json['sunrise']);
	if (sunrise != null) {
		weatherSys.sunrise = sunrise;
	}
	final int? sunset = jsonConvert.convert<int>(json['sunset']);
	if (sunset != null) {
		weatherSys.sunset = sunset;
	}
	return weatherSys;
}

Map<String, dynamic> $WeatherSysToJson(WeatherSys entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['sunrise'] = entity.sunrise;
	data['sunset'] = entity.sunset;
	return data;
}