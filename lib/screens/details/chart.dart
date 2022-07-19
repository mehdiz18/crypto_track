import 'package:crypto_app/models/currency.dart';
import 'package:crypto_app/services/api/coinapi/history.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Chart extends StatefulWidget {
  final Currency _currency;
  const Chart(this._currency);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  final List<Color> _gradient = [
    const Color.fromARGB(192, 0, 189, 176),
    const Color.fromARGB(0, 255, 255, 255)
  ];
  HistoryInterval _interval = HistoryInterval.hour;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List<FlSpot>>(
          future: History(widget._currency.name, _interval).fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 4,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: const LoadingIndicator(
                    colors: [Colors.black],
                    indicatorType: Indicator.pacman,
                  ),
                ),
              );
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: _gradient),
                          show: true,
                        ),
                        spots: snapshot.data,
                        barWidth: 2,
                        color: const Color(0xFF00BDB0)),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    _interval = HistoryInterval.hour;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: _interval == HistoryInterval.hour
                        ? const Color(0xFF00BDB0)
                        : Colors.transparent,
                  ),
                  child: Text(
                    "1D",
                    style: TextStyle(
                        fontSize: 18,
                        color: _interval == HistoryInterval.hour
                            ? Colors.white
                            : Colors.grey),
                  ),
                )),
            const SizedBox(width: 20),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _interval = HistoryInterval.day;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: _interval == HistoryInterval.day
                        ? const Color(0xFF00BDB0)
                        : Colors.transparent,
                  ),
                  child: Text(
                    "1M",
                    style: TextStyle(
                        fontSize: 18,
                        color: _interval == HistoryInterval.day
                            ? Colors.white
                            : Colors.grey),
                  ),
                )),
            const SizedBox(width: 20),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _interval = HistoryInterval.mounth;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: _interval == HistoryInterval.mounth
                        ? const Color(0xFF00BDB0)
                        : Colors.transparent,
                  ),
                  child: Text(
                    "1Y",
                    style: TextStyle(
                        fontSize: 18,
                        color: _interval == HistoryInterval.mounth
                            ? Colors.white
                            : Colors.grey),
                  ),
                )),
          ],
        ),
      ],
    );
  }
}

//Todo: Ontapped data