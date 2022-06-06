
extension MyDateUtils on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}

extension StringUtils on String {
  String asIconUrl() {
    return "http://openweathermap.org/img/wn/$this@2x.png";
  }
}

extension MapWithIntKeyUtils<K> on Map<K, int> {
  int maxValue() {
    var maxCount = 0;
    forEach((key, value) {
      if (value > maxCount) {
        maxCount = value;
      }
    });
    return maxCount;
  }

  K? keyWithMaxValue() {
    var value = maxValue();
    for (var entry in entries){
      if (value == entry.value) {
        return entry.key;
      }
    }
    return null;
  }
}