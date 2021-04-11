import 'package:flutter/material.dart';
import 'package:food_delivery/components/custom_bottom_nav_bar.dart';

import '../../enums.dart';
import 'body.dart';

class OderScreen extends StatelessWidget {
  static String routeName = "/oders";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: Menustate.oders),
    );
  }
}
