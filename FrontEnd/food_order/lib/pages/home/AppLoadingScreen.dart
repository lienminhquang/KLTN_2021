import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppLoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppLoadingScreenState();
  }
}

class _AppLoadingScreenState extends State<AppLoadingScreen>
    with SingleTickerProviderStateMixin {
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
                  child: SizedBox(
                    width: 100,
                    height: 70,
                    child: Image.asset(
                      'images/logo_without_name.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: 100,
              height: 40,
              child: Image.asset(
                'images/logo_name.png',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
