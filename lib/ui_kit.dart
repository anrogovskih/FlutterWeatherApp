import 'package:flutter/material.dart';

import 'database/tables/location_weather.dart';

Widget temperature(double temp, double size, double fontSize) {
  var textColor = temp > 0 ? Colors.amber : Colors.blueAccent;
  var text = temperatureString(temp);
  return Container(
    height: size,
    width: size,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: textColor,
        borderRadius: BorderRadius.all(Radius.elliptical(size, size))),
    child: Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
    ),
  );
}

Widget weatherIcon(String iconUrl, double size) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.black12,
        border: Border.all(color: Colors.black26, width: 0.0),
        borderRadius: BorderRadius.all(Radius.elliptical(size, size))),
    child: Image.network(iconUrl, width: size, height: size,),
  );
}

String temperatureString(double temp) {
  var tempInt = temp.abs().toInt();
  return temp > 0 ? '+$tempInt' : '-$tempInt';
}

Widget iconWithText(IconData iconData, String text, double textSpaceStart, double fontSize, double iconSize) {
  return Row(
    children: [
      secondaryIcon(iconData, iconSize),
      Container(
        padding: EdgeInsets.only(left: textSpaceStart),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize),
        ),
      )
    ],
  );
}

Widget secondaryIcon(IconData iconData, double size) {
  return Icon(iconData, color: Colors.blue, size: size);
}