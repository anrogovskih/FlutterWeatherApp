import 'package:sqflite/sqflite.dart';
import '../network/dto/geocoding_result_entity.dart';
import '../network/dto/weather_entity.dart';
import 'tables/location_weather.dart';

class DatabaseRepository {
  static final DatabaseRepository _singleton = DatabaseRepository._internal();

  Database? _db;

  factory DatabaseRepository() {
    return _singleton;
  }

  DatabaseRepository._internal();

  Future<Database> _initDatabase() async {
    return await openDatabase('weather_db.db', version: 1,
        onCreate: (Database db, int version) async {
          await LocationWeatherProvider.createTable(db);
          _db = db;
        });
  }

  Future<Database> _getDatabase() async {
    return _db ?? await _initDatabase();
  }

  Future<List<LocationWeather>> getLocations() async {
    return await LocationWeatherProvider(await _getDatabase()).getAll();
  }

  Future<LocationWeather?> getLocation(int id) async {
    return await LocationWeatherProvider(await _getDatabase()).get(id);
  }

  Future<List<LocationWeather>> getLocationsToUpdate() async {
    return await LocationWeatherProvider(await _getDatabase()).getLocationsToUpdate();
  }

  Future<void> delete(LocationWeather location) async {
    await LocationWeatherProvider(await _getDatabase()).delete(location);
  }

  update(LocationWeather location, WeatherEntity weatherEntity) async {
    var weather = weatherEntity.weather.first;
    var mainWeatherData = weatherEntity.main;
    var windWeatherData = weatherEntity.wind;
    var entity = LocationWeather(
        weatherEntity.id,
        location.name,
        location.country,
        location.state,
        location.lat,
        location.lon,
        weather.main,
        weather.description,
        weather.icon,
        mainWeatherData.temp,
        mainWeatherData.feelsLike,
        mainWeatherData.tempMin,
        mainWeatherData.tempMax,
        mainWeatherData.humidity,
        windWeatherData.speed,
        windWeatherData.deg,
        windWeatherData.gust ?? 0.0,
        weatherEntity.clouds.all,
        weatherEntity.sys.sunrise,
        weatherEntity.sys.sunset,
        DateTime.now().millisecondsSinceEpoch
    );

    await LocationWeatherProvider(await _getDatabase()).update(entity);
  }

  save(GeocodingResultEntity location, WeatherEntity weatherEntity) async {

    var weather = weatherEntity.weather.first;
    var mainWeatherData = weatherEntity.main;
    var windWeatherData = weatherEntity.wind;
    var entity = LocationWeather(
        weatherEntity.id,
        location.name,
        location.country,
        location.state ?? '',
        location.lat,
        location.lon,
        weather.main,
        weather.description,
        weather.icon,
        mainWeatherData.temp,
        mainWeatherData.feelsLike,
        mainWeatherData.tempMin,
        mainWeatherData.tempMax,
        mainWeatherData.humidity,
        windWeatherData.speed,
        windWeatherData.deg,
        windWeatherData.gust ?? 0.0,
        weatherEntity.clouds.all,
        weatherEntity.sys.sunrise,
        weatherEntity.sys.sunset,
        DateTime.now().millisecondsSinceEpoch
    );

    await LocationWeatherProvider(await _getDatabase()).insert(entity);
  }
}