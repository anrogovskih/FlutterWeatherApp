import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

import '../database/repositories/location_weather_list.dart';
import '../network/dto/geocoding_result_entity.dart';
import '../network/network.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _networkRepository = NetworkRepository();
  final _locationsWeatherRepository = LocationWeatherRepository();
  final _biggerFont = const TextStyle(fontSize: 18);
  final _cities = <GeocodingResultEntity>[];
  late SearchBar searchBar;

  _SearchScreenState() {
    searchBar = SearchBar(
        inBar: false,
        closeOnSubmit: false,
        clearOnSubmit: false,
        setState: setState,
        onSubmitted: _search,
        buildDefaultAppBar: buildAppBar);
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: const Text('Search locations'),
        actions: [searchBar.getSearchAction(context)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      body: ListView.builder(
          itemCount: _cities.length * 2,
          padding: const EdgeInsets.all(16.0),
          itemBuilder: _buildItem),
    );
  }

  Widget _buildItem(BuildContext context, int i) {
    if (i.isOdd) return const Divider();
    final index = i ~/ 2;

    return ListTile(
      title: _title(index),
      onTap: () {
        _selectItem(_cities[index]);
      },
    );
  }

  Text _title(int index) {
    var city = _cities[index];
    return Text(
      "${city.name}, ${city.country}, ${city.state}",
      style: _biggerFont,
    );
  }

  void _search(String query) async {
    var searchResults = await _networkRepository.search(query);
    setState(() {
      _cities.clear();
      _cities.addAll(searchResults.results);
    });
  }

  void _selectItem(GeocodingResultEntity item) async {
    var weather =
        await _networkRepository.getCurrentWeather(item.lat, item.lon);
    await _locationsWeatherRepository.save(item, weather);

    if (!mounted) return;
    Navigator.of(context).popUntil((r) => r.isFirst);
  }
}
