import 'package:crypto_app/screens/home/home.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      title: const Text(
        "Crypto Track",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
      ),
      durationInSeconds: 5,
      logo: Image.asset("assets/logo.png"),
      navigator: const Home(),
    );
  }
}
