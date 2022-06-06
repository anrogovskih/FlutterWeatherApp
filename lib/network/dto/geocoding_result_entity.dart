import 'dart:convert';
import 'package:flutter_weather_app/generated/json/base/json_field.dart';
import 'package:flutter_weather_app/generated/json/geocoding_result_entity.g.dart';

class GeocodingResultsList {
  final List<GeocodingResultEntity> results = [];
  GeocodingResultsList.fromJson(List<dynamic> jsonItems) {
    for (var jsonItem in jsonItems) {
      results.add(GeocodingResultEntity.fromJson(jsonItem));
    }
  }
}

@JsonSerializable()
class GeocodingResultEntity {

	late String name;
	@JSONField(name: "local_names")
	GeocodingResultLocalNames? localNames;
	late double lat;
	late double lon;
	late String country;
	String? state;
  
  GeocodingResultEntity();

  factory GeocodingResultEntity.fromJson(Map<String, dynamic> json) => $GeocodingResultEntityFromJson(json);

  Map<String, dynamic> toJson() => $GeocodingResultEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class GeocodingResultLocalNames {

	late String en;
	String? ru;
  
  GeocodingResultLocalNames();

  factory GeocodingResultLocalNames.fromJson(Map<String, dynamic> json) => $GeocodingResultLocalNamesFromJson(json);

  Map<String, dynamic> toJson() => $GeocodingResultLocalNamesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}