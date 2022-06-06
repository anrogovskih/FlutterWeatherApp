import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/repositories/location_weather_details.dart';
import '../database/tables/location_weather.dart';
import 'package:flutter_weather_app/ui_kit.dart';

import 'forecast/forecast.dart';

class WeatherDetailsScreen extends StatefulWidget {
  const WeatherDetailsScreen({Key? key}) : super(key: key);

  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailsScreenState();
}

class WeatherDetailsScreenArguments {
  final String title;
  final int locationId;

  WeatherDetailsScreenArguments(this.title, this.locationId);
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  late LocationWeatherDetailsRepository _repository;
  late String _title;
  late int _locationId;
  final double _textSpaceTop = 8;
  final double _textSpaceStart = 8;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as WeatherDetailsScreenArguments;
    _title = args.title;
    _locationId = args.locationId;
    _repository = LocationWeatherDetailsRepository(args.locationId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather in ${args.title}'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return StreamBuilder<LocationWeather>(
      stream: _repository.stream,
      builder: _streamBuilder,
    );
  }

  Widget _streamBuilder(
      BuildContext context, AsyncSnapshot<LocationWeather> snapshot) {
    var data = snapshot.data;
    if (data != null) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: _weatherDetails(data),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _weatherDetails(LocationWeather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [_temperature(weather), _weatherDescription(weather)],
        ),
        Container(
          padding: const EdgeInsets.only(top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_humidity(weather), _clouds(weather)],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_wind(weather), _time(weather)],
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 24),
          child: ElevatedButton(
              onPressed: _showForecast,
              child: Text(
                'Show forecast'.toUpperCase(),
                style: const TextStyle(fontSize: 18),
              )),
        )
      ],
    );
  }

  Widget _temperature(LocationWeather weather) {
    var feelsLike = temperatureString(weather.feelsLike);
    var text = "Feels like $feelsLike";
    return Column(children: [
      temperature(weather.temp, 100, 32),
      Container(
        padding: EdgeInsets.only(top: _textSpaceTop),
        child: Text(text, style: const TextStyle(fontSize: 20)),
      )
    ]);
  }

  Widget _weatherDescription(LocationWeather weather) {
    return Column(
      children: [
        weatherIcon(weather.getIconUrl(), 100),
        Container(
          padding: EdgeInsets.only(top: _textSpaceTop),
          child: Text(weather.weatherDescription,
              style: const TextStyle(fontSize: 20)),
        )
      ],
    );
  }

  Widget _humidity(LocationWeather weather) {
    return _iconWithText(Icons.water_drop, '${weather.humidity}%');
  }

  Widget _wind(LocationWeather weather) {
    return _iconWithText(Icons.air, '${weather.windSpeed} m/s');
  }

  Widget _clouds(LocationWeather weather) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: _iconWithText(Icons.cloud, '${weather.cloudsCoverage}%'),
    );
  }

  Widget _time(LocationWeather weather) {
    var textStyle = const TextStyle(fontSize: 16);
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          _secondaryIcon(Icons.sunny),
          Container(
            padding: EdgeInsets.only(left: _textSpaceStart),
            child: Column(
              children: [
                Text(
                  'sunrise: ${formatAsTime(weather.sunrise)}',
                  style: textStyle,
                ),
                Text(
                  'sunset: ${formatAsTime(weather.sunset)}',
                  style: textStyle,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String formatAsTime(int timestampInSec) {
    return DateFormat.Hm()
        .format(DateTime.fromMillisecondsSinceEpoch(timestampInSec * 1000));
  }

  Widget _iconWithText(IconData iconData, String text) {
    return iconWithText(iconData, text, _textSpaceStart, 20, 50);
  }

  Widget _secondaryIcon(IconData iconData) {
    return secondaryIcon(iconData, 50);
  }

  void _showForecast() {
    Navigator.of(context).pushNamed('/forecast',
        arguments: ForecastScreenArguments(_title, _locationId));
  }
}
