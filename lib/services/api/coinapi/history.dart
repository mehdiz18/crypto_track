import 'dart:convert';

import 'package:crypto_app/models/history_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

enum HistoryInterval { hour, day, mounth }

class History {
  final String _id;
  final HistoryInterval _interval;

  final Map<String, String> _header = {
    "Authorization": "Bearer 03ec6782-0f27-42df-a2cd-6b92c89f5d9e"
  };
  History(this._id, this._interval);

  Future<List<FlSpot>> _fetchHourly() async {
    try {
      print(_id.toLowerCase().replaceAll(" ", "-"));
      final result = await http.get(
          Uri.parse(
              "https://api.coincap.io/v2/assets/${_id.toLowerCase().replaceAll(" ", "-")}/history?interval=h1"),
          headers: _header);
      final fetchedJson = jsonDecode(result.body);
      List<dynamic> data = fetchedJson["data"];
      return data
          .map((e) => HistoryData.fromMap(e))
          .toList()
          .where((element) {
            return DateTime.now().difference(element.timeStamp) <=
                const Duration(hours: 24);
          })
          .toList()
          .map((e) {
            return e.toFlSpot();
          })
          .toList();
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  Future<List<FlSpot>> _fetchDaily() async {
    try {
      final result = await http.get(
          Uri.parse(
              "https://api.coincap.io/v2/assets/${_id.toLowerCase()}/history?interval=d1"),
          headers: _header);
      final fetchedJson = jsonDecode(result.body);
      List<dynamic> data = fetchedJson["data"];
      return data
          .map((e) => HistoryData.fromMap(e))
          .toList()
          .where((element) {
            return DateTime.now().difference(element.timeStamp) <=
                const Duration(days: 30);
          })
          .toList()
          .map((e) {
            return e.toFlSpot();
          })
          .toList();
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  Future<List<FlSpot>> _fetchMounthly() async {
    try {
      final result = await http.get(
          Uri.parse(
              "https://api.coincap.io/v2/assets/${_id.toLowerCase()}/history?interval=d1"),
          headers: _header);
      final fetchedJson = jsonDecode(result.body);
      List<dynamic> data = fetchedJson["data"];
      return data
          .map((e) => HistoryData.fromMap(e))
          .toList()
          .where((element) {
            return DateTime.now().difference(element.timeStamp) <=
                    const Duration(days: 365) &&
                element.timeStamp.day ==
                    DateTime(element.timeStamp.year, element.timeStamp.month)
                        .day;
          })
          .toList()
          .map((e) {
            return e.toFlSpot();
          })
          .toList();
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  Future<List<FlSpot>> fetchData() async {
    switch (_interval) {
      case HistoryInterval.hour:
        return await _fetchHourly();
      case HistoryInterval.day:
        return await _fetchDaily();
      default:
        return _fetchMounthly();
    }
  }
}
