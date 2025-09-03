import 'package:flutter/material.dart';
import "package:covid_tracker/splash_screen.dart";

main() {
  runApp(Myapi());
}

class Myapi extends StatefulWidget {
  const Myapi({super.key});

  @override
  State<Myapi> createState() => _MyapiState();
}

class _MyapiState extends State<Myapi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const SplashScreen());
  }
}
