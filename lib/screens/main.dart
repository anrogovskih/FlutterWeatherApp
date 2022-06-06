import 'package:flutter/material.dart';
import 'package:flutter_weather_app/screens/details.dart';
import 'package:flutter_weather_app/screens/search.dart';
import '../database/repositories/location_weather_list.dart';
import '../database/tables/location_weather.dart';
import 'package:flutter_weather_app/ui_kit.dart';

import 'forecast/forecast.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  static const appName = 'Weather App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        primarySwatch: Colors.red,
      ),
      home: const BookmarkedCities(),
      routes: {
        '/search': (BuildContext context) => const SearchScreen(),
        '/details': (BuildContext context) => const WeatherDetailsScreen(),
        '/forecast': (BuildContext context) => const ForecastScreen(),
      },
    );
  }
}

class BookmarkedCities extends StatefulWidget {
  const BookmarkedCities({Key? key}) : super(key: key);

  @override
  State<BookmarkedCities> createState() => _BookmarkedCitiesState();
}

class _BookmarkedCitiesState extends State<BookmarkedCities>
    with WidgetsBindingObserver {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _locationsWeatherRepository = LocationWeatherRepository();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _locationsWeatherRepository.update();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _locationsWeatherRepository.update();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite locations'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addLocation,
        tooltip: 'Add location',
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<List<LocationWeather>>(
      stream: _locationsWeatherRepository.stream,
      builder: _streamBuilder,
    );
  }

  Widget _streamBuilder(BuildContext context, AsyncSnapshot<List<LocationWeather>> snapshot) {
    var data = snapshot.data;
    if (data == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (data.isEmpty) {
      return Center(
        child: Text('No locations were added to favourites', style: _biggerFont),
      );
    } else {
      return ListView.builder(
          itemCount: data.length * 2,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          itemBuilder: (BuildContext context, int index) {
            return _buildItem(index, data);
          });
    }
  }

  void _addLocation() {
    Navigator.of(context).pushNamed('/search');
  }

  Widget _buildItem(int i, List<LocationWeather> locations) {
    if (i.isOdd) return const Divider();
    final index = i ~/ 2;

    var location = locations[index];
    return ListTile(
      title: _title(location),
      leading: temperature(location.temp, 50, 18),
      trailing: weatherIcon(location.getIconUrl(), 50),
      onLongPress: () => _showModalRemoveLocation(location),
      onTap: () => _showWeatherDetails(location),
    );
  }

  void _showModalRemoveLocation(LocationWeather location) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Delete ${location.name} from favourite?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => _delete(location),
                  child: const Text('Delete'),
                ),
              ],
            ));
  }

  void _delete(LocationWeather location) {
    _locationsWeatherRepository.delete(location);
    Navigator.pop(context, 'Delete');
  }

  void _showWeatherDetails(LocationWeather location) {
    Navigator.of(context).pushNamed('/details',
        arguments: WeatherDetailsScreenArguments(location.name, location.id));
  }

  Text _title(LocationWeather location) {
    return Text(
      location.getName(),
      style: _biggerFont,
    );
  }
}
