import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class NoConnection extends StatelessWidget {
  final Future<void> Function() _refresh;
  const NoConnection(this._refresh);

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      color: Colors.white,
      backgroundColor: Colors.black,
      height: MediaQuery.of(context).size.height / 12,
      showChildOpacityTransition: false,
      onRefresh: _refresh,
      child: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
          ),
          Center(
            child: Image.asset(
              "assets/logo.png",
              scale: 2,
            ),
          ),
          const Center(
            child: Text(
              "Verifiez votre Connexion",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
