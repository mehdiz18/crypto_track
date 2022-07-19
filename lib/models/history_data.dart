import 'dart:ffi';

import 'package:crypto_app/services/api/coinapi/history.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoryData {
  double price;
  DateTime timeStamp;

  HistoryData(this.price, this.timeStamp);

  factory HistoryData.fromMap(Map<String, dynamic> map) {
    return HistoryData(double.parse(map["priceUsd"]),
        DateTime.fromMillisecondsSinceEpoch(map["time"]));
  }

  FlSpot toFlSpot() {
    return FlSpot(timeStamp.millisecondsSinceEpoch.toDouble(),
        double.parse(price.toStringAsFixed(3)));
  }

  @override
  String toString() {
    return '$price $timeStamp';
  }
}
