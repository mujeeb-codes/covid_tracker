import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:covid_tracker/world_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  )..repeat();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WorldState()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            child: Center(
              child: Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/virusl.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2.0 * pi,
                child: child,
              );
            },
          ),
          SizedBox(height: 60),
          Center(
            child: Text(
              "Covid-19\nApp Tracker",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "DMSerifText",
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
