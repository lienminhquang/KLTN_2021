import 'package:flutter/material.dart';
import 'package:food_delivery/components/custom_bottom_nav_bar.dart';

import '../../enums.dart';
import 'body.dart';

class FavoriteScreen extends StatelessWidget {
  static String routeName = "/favorite";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: Menustate.favorite),
    );
  }
}
