import 'package:flutter_weather_app/extensions.dart';
import 'package:sqflite/sqflite.dart';

const String tableName = "locationsWeather";
const String columnId = '_id';
const String columnName = "name";
const String columnCountry = 'country';
const String columnState = 'state';
const String columnLatitude = 'lat';
const String columnLongitude = 'lon';
const String columnWeather = 'weather';
const String columnWeatherDescription = 'weatherDescription';
const String columnWeatherIcon = 'weatherIcon';
const String columnTemp = 'temp';
const String columnFeelsLike = 'feelsLike';
const String columnTempMin = 'tempMin';
const String columnTempMax = 'tempMax';
const String columnHumidity = 'humidity';
const String columnWindSpeed = 'windSpeed';
const String columnWindDegrees = 'windDegrees';
const String columnWindGust = 'windGust';
const String columnCloudsCoverage = 'cloudsCoverage';
const String columnSunrise = 'sunrise';
const String columnSunset = 'sunset';
const String columnUpdateTimestamp = 'updateTimestamp';

const int validityTime = 1000 * 60 * 5;

class LocationWeather {
  int id;
  String name;
  String country;
  String state;

  double lat;
  double lon;

  String weather;
  String weatherDescription;
  String weatherIcon;

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int humidity;

  double windSpeed;
  int windDegrees;
  double windGust;

  int cloudsCoverage;

  int sunrise;
  int sunset;

  int updateTimestamp;

  LocationWeather(
      this.id,
      this.name,
      this.country,
      this.state,
      this.lat,
      this.lon,
      this.weather,
      this.weatherDescription,
      this.weatherIcon,
      this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.humidity,
      this.windSpeed,
      this.windDegrees,
      this.windGust,
      this.cloudsCoverage,
      this.sunrise,
      this.sunset,
      this.updateTimestamp);

  static LocationWeather fromMap(Map<String, Object?> map) {
    return LocationWeather(
        map[columnId] as int,
        map[columnName] as String,
        map[columnCountry] as String,
        map[columnState] as String,
        map[columnLatitude] as double,
        map[columnLongitude] as double,
        map[columnWeather] as String,
        map[columnWeatherDescription] as String,
        map[columnWeatherIcon] as String,
        map[columnTemp] as double,
        map[columnFeelsLike] as double,
        map[columnTempMin] as double,
        map[columnTempMax] as double,
        map[columnHumidity] as int,
        map[columnWindSpeed] as double,
        map[columnWindDegrees] as int,
        map[columnWindGust] as double,
        map[columnCloudsCoverage] as int,
        map[columnSunrise] as int,
        map[columnSunset] as int,
        map[columnUpdateTimestamp] as int);
  }

  Map<String, Object?> toMap() {
    return <String, Object?>{
      columnId: id,
      columnName: name,
      columnCountry: country,
      columnState: state,
      columnLatitude: lat,
      columnLongitude: lon,
      columnWeather: weather,
      columnWeatherDescription: weatherDescription,
      columnWeatherIcon: weatherIcon,
      columnTemp: temp,
      columnFeelsLike: feelsLike,
      columnTempMin: tempMin,
      columnTempMax: tempMax,
      columnHumidity: humidity,
      columnWindSpeed: windSpeed,
      columnWindDegrees: windDegrees,
      columnWindGust: windGust,
      columnCloudsCoverage: cloudsCoverage,
      columnSunrise: sunrise,
      columnSunset: sunset,
      columnUpdateTimestamp: updateTimestamp
    };
  }

  String getName() {
    return "$name, $country, $state";
  }

  String getIconUrl() {
    return weatherIcon.asIconUrl();
  }

  bool isExpired() {
    var now = DateTime.now().millisecondsSinceEpoch;
    return (updateTimestamp < now - validityTime);
  }
}

class LocationWeatherProvider {
  Database db;

  LocationWeatherProvider(this.db);

  Future<void> delete(LocationWeather entity) async {
    await db.delete(tableName, where: '$columnId = ?', whereArgs: [entity.id]);
  }

  Future<void> insert(LocationWeather entity) async {
    await db.insert(tableName, entity.toMap());
  }

  Future<int> update(LocationWeather entity) async {
    return await db.update(tableName, entity.toMap(),
        where: '$columnId = ?', whereArgs: [entity.id]);
  }

  Future<List<LocationWeather>> getAll() async {
    var res = await db.query(tableName);
    return res.isNotEmpty
        ? res.map((location) => LocationWeather.fromMap(location)).toList()
        : [];
  }

  Future<LocationWeather?> get(int id) async {
    var res = await db.query(tableName, where: '$columnId = ?', whereArgs: [id]);
    return res.isNotEmpty? LocationWeather.fromMap(res.single) : null;
  }

  Future<List<LocationWeather>> getLocationsToUpdate() async {
    var now = DateTime.now().millisecondsSinceEpoch;
    //update should be once in five minutes or so
    var minValidTime = now - validityTime;
    var res = await db.query(tableName,
        where: '$columnUpdateTimestamp < $minValidTime');
    return res.isNotEmpty
        ? res.map((location) => LocationWeather.fromMap(location)).toList()
        : [];
  }

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL,
      $columnCountry TEXT NOT NULL,
      $columnState TEXT NOT NULL,
      $columnLatitude REAL NOT NULL,
      $columnLongitude REAL NOT NULL,
      $columnWeather TEXT NOT NULL,
      $columnWeatherDescription TEXT NOT NULL,
      $columnWeatherIcon TEXT NOT NULL,
      $columnTemp REAL NOT NULL,
      $columnFeelsLike REAL NOT NULL,
      $columnTempMin REAL NOT NULL,
      $columnTempMax REAL NOT NULL,
      $columnHumidity INTEGER NOT NULL,
      $columnWindSpeed REAL NOT NULL,
      $columnWindDegrees INTEGER NOT NULL,
      $columnWindGust REAL NOT NULL,
      $columnCloudsCoverage INTEGER NOT NULL,
      $columnSunrise INTEGER NOT NULL,
      $columnSunset INTEGER NOT NULL,
      $columnUpdateTimestamp INTEGER NOT NULL
      )
      ''');
  }
}
