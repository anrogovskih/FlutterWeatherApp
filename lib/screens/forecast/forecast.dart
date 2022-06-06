import 'package:flutter/material.dart';
import 'package:flutter_weather_app/database/repositories/forecast_repository.dart';
import 'package:flutter_weather_app/ui_kit.dart';

import 'forecast_items.dart';
import 'package:intl/intl.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class ForecastScreenArguments {
  final String title;
  final int locationId;

  ForecastScreenArguments(this.title, this.locationId);
}

class _ForecastScreenState extends State<ForecastScreen> {
  late ForecastRepository _repository;
  final TextStyle _primaryTextStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  final TextStyle _secondaryTextStyle =
      const TextStyle(fontSize: 14, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ForecastScreenArguments;
    _repository = ForecastRepository(args.locationId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Forecast for ${args.title}'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return StreamBuilder<List<ForecastItem>>(
      stream: _repository.stream,
      builder: _streamBuilder,
    );
  }

  Widget _streamBuilder(
      BuildContext context, AsyncSnapshot<List<ForecastItem>> snapshot) {
    var data = snapshot.data;
    if (data == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (data.isEmpty) {
      return const Center(
        child: Text('No forecast is available', style: TextStyle(fontSize: 18)),
      );
    } else {
      return ListView.builder(
          itemCount: data.length * 2,
          itemBuilder: (BuildContext context, int index) {
            return _buildItem(index, data);
          });
    }
  }

  Widget _buildItem(int i, List<ForecastItem> forecastItems) {
    if (i.isOdd) {
      return const Divider(
        height: 1,
      );
    }
    final index = i ~/ 2;

    var forecast = forecastItems[index];
    switch (forecast.runtimeType) {
      case ForecastForDay:
        return _buildForecastForDay(forecast as ForecastForDay);
      case ForecastForTime:
        return _buildForecastForTime(forecast as ForecastForTime);
      default:
        return Container();
    }
  }

  Widget _buildForecastForDay(ForecastForDay item) {
    return GestureDetector(
      onTap: () => {_repository.showDetailsForDay(item)},
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_date(item), _forecastForDay(item)],
        ),
      ),
    );
  }

  Widget _date(ForecastForDay item) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(item.timestamp);
    var date = DateFormat.MMMMd().format(dateTime);
    var weekday = DateFormat('EEEE').format(dateTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(date, style: _secondaryTextStyle),
        Text(weekday, style: _primaryTextStyle)
      ],
    );
  }

  Widget _forecastForDay(ForecastForDay item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _description(item),
        Container(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(temperatureString(item.getMaxTemp().toDouble()),
                    style: _primaryTextStyle),
                Text(
                  temperatureString(item.getMinTemp().toDouble()),
                  style: _secondaryTextStyle,
                )
              ],
            )),
      ],
    );
  }

  Widget _buildForecastForTime(ForecastForTime item) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: const Color(0xffFFF5E5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _time(item),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 16),
                child: _description(item),
              ),
              _details(item),
              _temperature(item)
            ],
          )
        ],
      ),
    );
  }

  Widget _time(ForecastForTime item) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(item.forecast.dt*1000);
    return Text(DateFormat.Hm().format(dateTime), style: _primaryTextStyle,);
  }

  Widget _description(ForecastItem item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 8),
          constraints: BoxConstraints.loose(const Size.fromWidth(100)),
          child: Text(
            item.getDescription(),
            textAlign: TextAlign.end,
          ),
        ),
        weatherIcon(item.getIconUrl(), 40),
      ],
    );
  }

  Widget _details(ForecastForTime item) {
    double iconSize = 18;
    double fontSize = 12;
    double textSpaceStart = 4;
    var humidity = item.forecast.main.humidity;
    var wind = item.forecast.wind.speed.toInt();
    var clouds = item.forecast.clouds.all;
    return Container(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          iconWithText(
              Icons.water_drop, '$humidity%', textSpaceStart, fontSize, iconSize),
          iconWithText(Icons.air, '$wind m/s', textSpaceStart, fontSize, iconSize),
          iconWithText(Icons.cloud, '$clouds%', textSpaceStart, fontSize, iconSize),
        ],
      ),
    );
  }

  Widget _temperature(ForecastForTime item) {
    return temperature(item.forecast.main.temp, 50, 18);
  }
}
