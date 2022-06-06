import 'package:flutter_weather_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_weather_app/network/dto/geocoding_result_entity.dart';

GeocodingResultEntity $GeocodingResultEntityFromJson(Map<String, dynamic> json) {
	final GeocodingResultEntity geocodingResultEntity = GeocodingResultEntity();
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		geocodingResultEntity.name = name;
	}
	final GeocodingResultLocalNames? localNames = jsonConvert.convert<GeocodingResultLocalNames>(json['local_names']);
	if (localNames != null) {
		geocodingResultEntity.localNames = localNames;
	}
	final double? lat = jsonConvert.convert<double>(json['lat']);
	if (lat != null) {
		geocodingResultEntity.lat = lat;
	}
	final double? lon = jsonConvert.convert<double>(json['lon']);
	if (lon != null) {
		geocodingResultEntity.lon = lon;
	}
	final String? country = jsonConvert.convert<String>(json['country']);
	if (country != null) {
		geocodingResultEntity.country = country;
	}
	final String? state = jsonConvert.convert<String>(json['state']);
	if (state != null) {
		geocodingResultEntity.state = state;
	}
	return geocodingResultEntity;
}

Map<String, dynamic> $GeocodingResultEntityToJson(GeocodingResultEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] = entity.name;
	data['local_names'] = entity.localNames?.toJson();
	data['lat'] = entity.lat;
	data['lon'] = entity.lon;
	data['country'] = entity.country;
	data['state'] = entity.state;
	return data;
}

GeocodingResultLocalNames $GeocodingResultLocalNamesFromJson(Map<String, dynamic> json) {
	final GeocodingResultLocalNames geocodingResultLocalNames = GeocodingResultLocalNames();
	final String? en = jsonConvert.convert<String>(json['en']);
	if (en != null) {
		geocodingResultLocalNames.en = en;
	}
	final String? ru = jsonConvert.convert<String>(json['ru']);
	if (ru != null) {
		geocodingResultLocalNames.ru = ru;
	}
	return geocodingResultLocalNames;
}

Map<String, dynamic> $GeocodingResultLocalNamesToJson(GeocodingResultLocalNames entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['en'] = entity.en;
	data['ru'] = entity.ru;
	return data;
}