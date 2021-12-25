import 'package:flutter/material.dart';

final DateTime yesterday = DateTime(DateTime.now().year, DateTime.now().month,
    DateTime.now().day, DateTime.now().hour - 24);
final DateTime weekAgo =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 7);

final DateTime monthAgo =
    DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);

final DateTime threeMonthsAgo =
    DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);

final DateTime sixMonthsAgo =
    DateTime(DateTime.now().year, DateTime.now().month - 6, DateTime.now().day);

final DateTime yearAgo = DateTime(
    DateTime.now().year, DateTime.now().month, DateTime.now().day - 365);

final DateTime threeYearAgo = DateTime(
    DateTime.now().year, DateTime.now().month, DateTime.now().day - 1095);

final DateTime nowInHour = DateTime.now();

final DateTime inFiveHours = nowInHour.add(Duration(hours: 5));

final DateTime inTenHours = nowInHour.add(Duration(hours: 10));

final DateTime inFifteenHours = nowInHour.add(Duration(hours: 15));

final DateTime inTwentyHours = nowInHour.add(Duration(hours: 20));

final DateTime inTwentyfiveHours = nowInHour.add(Duration(hours: 24));

const TextStyle articleStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20);

const TextStyle greenText =
    TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold);

const TextStyle redText =
    TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold);

const TextStyle coinText = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];
