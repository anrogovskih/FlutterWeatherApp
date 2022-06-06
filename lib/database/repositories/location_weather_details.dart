import 'dart:async';

import '../../network/network.dart';
import '../database.dart';
import '../tables/location_weather.dart';
import 'base_stream_repository.dart';

class LocationWeatherDetailsRepository extends BaseStreamRepository<LocationWeather> {
  int locationId;

  LocationWeatherDetailsRepository(this.locationId){
    _getLocation();
  }

  final _networkRepository = NetworkRepository();
  final _databaseRepository = DatabaseRepository();

  void _getLocation() async {
      var location = await _databaseRepository.getLocation(locationId);
      if (location != null) {
        if (location.isExpired()) {
          _getLocationFromNetwork(location);
        }
        else {
          streamSink.add(location);
        }
      }
  }

  void _getLocationFromNetwork(LocationWeather location) async {
      var weather = await _networkRepository.getCurrentWeatherById(locationId);
      _databaseRepository.update(location, weather);
      _getLocation();
  }
}