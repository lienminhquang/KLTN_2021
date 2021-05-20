import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery/configs/DevHttpsOveride.dart';
import 'package:food_delivery/models/AppModel.dart';
import 'package:food_delivery/models/CartModel.dart';
import 'package:food_delivery/models/CategoryModel.dart';
import 'package:food_delivery/models/FoodDetailModel.dart';
import 'package:food_delivery/pages/cart/cart_screen.dart';
import 'package:food_delivery/pages/favorite/Favorite.dart';
import 'package:food_delivery/pages/home/Home.dart';
import 'package:food_delivery/pages/login_signup/Login.dart';
import 'package:food_delivery/pages/nofication/Nofication.dart';
import 'package:food_delivery/pages/oders/Orders.dart';
import 'package:food_delivery/pages/presentation/themes.dart';
import 'package:food_delivery/pages/profile/Profile.dart';

import 'package:provider/provider.dart';

void main() {
  //acept bad certificate request
  HttpOverrides.global = new DevHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryModel()),
        ChangeNotifierProvider(create: (context) => FoodDetailModel()),
        ChangeNotifierProvider(create: (context) => AppModel()),
        ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      child: MaterialApp(
        title: 'Food Delivery',
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        // ),
        theme: AppTheme.lightTheme,
        home: MotherBoard(),
      ),
    );
  }
}

class MotherBoard extends StatefulWidget {
  @override
  _MotherBoardState createState() => _MotherBoardState();
}

class _MotherBoardState extends State<MotherBoard> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    OderScreen(),
    CartScreen(),
    NoficationScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    bool isIsSignedIn =
        context.select<AppModel, bool>((value) => value.isSignedIn);
    if (!isIsSignedIn) {
      return LoginPage();
    }

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            new BottomNavigationBarItem(
                backgroundColor: Colors.black87,
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: "Home"),
            new BottomNavigationBarItem(
                backgroundColor: Colors.black87,
                icon: Icon(Icons.menu),
                label: "Order"),
            new BottomNavigationBarItem(
                backgroundColor: Colors.black87,
                icon: Icon(Icons.shopping_cart),
                label: "Cart"),
            new BottomNavigationBarItem(
                backgroundColor: Colors.black87,
                icon: Icon(Icons.notifications_active_outlined),
                label: "Notification"),
            new BottomNavigationBarItem(
                backgroundColor: Colors.black87,
                icon: Icon(Icons.person_outline_outlined),
                label: "Profile")
          ],
          onTap: (int index) {
            onTabTapped(index, context);
          }),
    );
  }

  void onTabTapped(int index, BuildContext context) {
    setState(() {
      _currentIndex = index;
      switch (_currentIndex) {
        case 2:
          context.read<CartModel>().fetchAll();
          break;
        default:
      }
    });
  }
}
