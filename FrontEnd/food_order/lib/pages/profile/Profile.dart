import 'package:flutter/material.dart';
import 'package:food_delivery/components/custom_bottom_nav_bar.dart';
import 'package:food_delivery/enums.dart';

import 'body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: Body(),
        bottomNavigationBar: CustomBottomNavBar(
          selectedMenu: Menustate.profile,
        ));
  }
}
