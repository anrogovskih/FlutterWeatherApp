import 'dart:async';

import 'package:flutter_weather_app/database/repositories/base_stream_repository.dart';
import 'package:flutter_weather_app/network/network.dart';

import '../../network/dto/geocoding_result_entity.dart';
import '../../network/dto/weather_entity.dart';
import '../database.dart';
import '../tables/location_weather.dart';

class LocationWeatherRepository extends BaseStreamRepository<List<LocationWeather>> {

  static final LocationWeatherRepository _singleton = LocationWeatherRepository._internal();

  factory LocationWeatherRepository() {
    return _singleton;
  }

  LocationWeatherRepository._internal() {
    // Retrieve all the locations on initialization
    getLocations();
  }

  final _networkRepository = NetworkRepository();

  void getLocations() async {
    // print("getLocations");
    // Retrieve all the locations from the database
    List<LocationWeather> locations = await DatabaseRepository().getLocations();
    // print("_inLocations.add ${locations.length} locations");

    // Add all of the locations to the stream so we can grab them later from our pages
    streamSink.add(locations);
  }

  Future<void> save(GeocodingResultEntity location, WeatherEntity weatherEntity) async {
    await DatabaseRepository().save(location, weatherEntity);
    getLocations();
  }

  void update() async {
    print("update");
    var database = DatabaseRepository();
    var expiredData = await database.getLocationsToUpdate();
    if (expiredData.isNotEmpty){
      print("found ${expiredData.length} expiredData");
      for(var i = 0; i< expiredData.length; i++) {
        var location = expiredData[i];
        var updatedWeather = await _networkRepository.getCurrentWeatherById(location.id);
        await database.update(location, updatedWeather);
      }
      getLocations();
      print("expiredData was updated");
    }
  }

  void delete(LocationWeather location) async {
    await DatabaseRepository().delete(location);
    getLocations();
  }
}