import 'package:flutter_weather_app/extensions.dart';

import '../../network/dto/forecast_response_entity.dart';
import '../../network/network.dart';
import '../../screens/forecast/forecast_items.dart';
import 'base_stream_repository.dart';

class ForecastRepository extends BaseStreamRepository<List<ForecastItem>> {
  int locationId;

  ForecastRepository(this.locationId) {
    _getForecast();
  }

  final _networkRepository = NetworkRepository();

  List<ForecastItem> data = <ForecastItem>[];

  void showDetailsForDay(ForecastForDay day) {
    if (day.isOpen) {
      day.isOpen = false;
      var start = data.indexOf(day) + 1;
      var end = start + day.forecast.length;
      data.removeRange(start, end);
      streamSink.add(data);
    }
    else {
      day.isOpen = true;
      var index = data.indexOf(day) + 1;
      data.insertAll(index, day.forecast);
      streamSink.add(data);
    }
  }

  void _getForecast() async {
    var forecast = await _networkRepository.getForecast(locationId);
    var startOfTheDay =
        DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
    var startOfTheNextDay = startOfTheDay.add(const Duration(days: 1));
    List<ForecastResponseList> forecastsForTheDay = <ForecastResponseList>[];
    List<ForecastForDay> forecastsByDays = <ForecastForDay>[];
    for (var i = 0; i < forecast.list.length; i++) {
      var forecastElement = forecast.list[i];
      var forecastTime =
          DateTime.fromMillisecondsSinceEpoch(forecastElement.dt * 1000);
      //if we are still building same day forecast
      if (startOfTheDay.isBefore(forecastTime) &&
          startOfTheNextDay.isAfter(forecastTime)) {
        forecastsForTheDay.add(forecastElement);
      }
      //if we should proceed to the next day
      else if (startOfTheNextDay.isBefore(forecastTime)) {
        forecastsByDays.add(ForecastForDay(forecastsForTheDay));
        forecastsForTheDay = <ForecastResponseList>[];
        startOfTheDay = startOfTheNextDay;
        startOfTheNextDay = startOfTheNextDay.add(const Duration(days: 1));
      }
    }
    data.addAll(forecastsByDays);
    streamSink.add(forecastsByDays);
  }
}
