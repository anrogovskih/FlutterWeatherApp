import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dto/forecast_response_entity.dart';
import 'dto/geocoding_result_entity.dart';
import 'dto/weather_entity.dart';

class NetworkRepository {
  static const String apiKey = "a9d83b2157c49f5b2e18dbd053600cff";
  static const String baseUrl = "http://api.openweathermap.org/";
  static const String dataUrl = "${baseUrl}data/2.5/";
  static const String geocodingUrl = "${baseUrl}geo/1.0/direct?appid=$apiKey&limit=3";
  static const String weatherUrl = "${dataUrl}weather?appid=$apiKey&units=metric";
  static const String forecastUrl = "${dataUrl}forecast?appid=$apiKey&units=metric";

  Future<GeocodingResultsList> search(String query) async {
    var url = Uri.parse("$geocodingUrl&q=$query");
    http.Response response = await http.get(url);
    var body = response.body;
    List<dynamic> data = jsonDecode(body);
    return GeocodingResultsList.fromJson(data);
  }

  Future<WeatherEntity> getCurrentWeather(double latitude, double longitude) async {
    var url = Uri.parse("$weatherUrl&lat=$latitude&lon=$longitude");
    http.Response response = await http.get(url);
    var body = response.body;
    Map<String, dynamic> json = jsonDecode(body);
    return WeatherEntity.fromJson(json);
  }

  Future<WeatherEntity> getCurrentWeatherById(int id) async {
    var url = Uri.parse("$weatherUrl&id=$id&");
    http.Response response = await http.get(url);
    var body = response.body;
    Map<String, dynamic> json = jsonDecode(body);
    return WeatherEntity.fromJson(json);
  }

  Future<ForecastResponseEntity> getForecast(int id) async {
    var url = Uri.parse("$forecastUrl&id=$id&");
    http.Response response = await http.get(url);
    var body = response.body;
    print(body);
    Map<String, dynamic> json = jsonDecode(body);
    return ForecastResponseEntity.fromJson(json);
  }
}