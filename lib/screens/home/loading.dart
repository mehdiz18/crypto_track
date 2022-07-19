import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: MediaQuery.of(context).size.height / 10,
      child: const LoadingIndicator(
        colors: [Colors.black],
        indicatorType: Indicator.pacman,
      ),
    ));
  }
}
