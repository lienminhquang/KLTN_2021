import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeLoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeLoadingScreenState();
  }
}

class _HomeLoadingScreenState extends State<HomeLoadingScreen>
    with SingleTickerProviderStateMixin {
  // Define the various properties with default values. Update these properties
  // when the user taps a FloatingActionButton.
  final double _width = 50;
  final double _height = 50;
  final Color _color = Colors.green;
  final BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 30),
        lowerBound: 0,
        upperBound: 100)
      ..repeat();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) {
              //print(animationController.value);
              var angle = sin(animationController.value) * 0.3;
              return Transform(
                transform: new Matrix4.rotationZ(angle),
                alignment: Alignment.center,
                child: Image.asset(
                  'images/logo_without_name.png',
                ),
              );
            },
          ),
          Image.asset(
            'images/logo_name.png',
          ),
        ],
      )),
    );
  }
}
