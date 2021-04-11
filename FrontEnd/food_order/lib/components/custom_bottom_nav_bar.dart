import 'package:flutter/material.dart';
import 'package:food_delivery/enums.dart';
import 'package:food_delivery/pages/favorite/Favorite.dart';
import 'package:food_delivery/pages/home/Home.dart';
import 'package:food_delivery/pages/nofication/Nofication.dart';
import 'package:food_delivery/pages/oders/Orders.dart';
import 'package:food_delivery/pages/profile/Profile.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);
  final Menustate selectedMenu;
  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home_outlined),
            onPressed: () => Navigator.pushNamed(context, HomeScreen.routeName),
            color:
                Menustate.home == selectedMenu ? Colors.red : inActiveIconColor,
          ),
          IconButton(
              icon: Icon(Icons.menu),
              onPressed: () =>
                  Navigator.pushNamed(context, OderScreen.routeName),
              color: Menustate.oders == selectedMenu
                  ? Colors.red
                  : inActiveIconColor),
          IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () =>
                  Navigator.pushNamed(context, FavoriteScreen.routeName),
              color: Menustate.favorite == selectedMenu
                  ? Colors.red
                  : inActiveIconColor),
          IconButton(
              icon: Icon(Icons.notifications_active_outlined),
              onPressed: () =>
                  Navigator.pushNamed(context, NoficationScreen.routeName),
              color: Menustate.notification == selectedMenu
                  ? Colors.red
                  : inActiveIconColor),
          IconButton(
              icon: Icon(Icons.person_outline_outlined),
              onPressed: () =>
                  Navigator.pushNamed(context, ProfileScreen.routeName),
              color: Menustate.profile == selectedMenu
                  ? Colors.red
                  : inActiveIconColor)
        ],
      ),
    );
  }
}
