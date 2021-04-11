import 'package:food_delivery/pages/adress/Adress.dart';
import 'package:food_delivery/pages/cart/cart_screen.dart';
import 'package:food_delivery/pages/categoty/Category.dart';
import 'package:food_delivery/pages/favorite/Favorite.dart';
import 'package:food_delivery/pages/home/Home.dart';
import 'package:food_delivery/pages/login_signup/Login.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/pages/login_signup/SignUp.dart';
import 'package:food_delivery/pages/nofication/Nofication.dart';
import 'package:food_delivery/pages/oders/Orders.dart';
import 'package:food_delivery/pages/profile/Profile.dart';
import 'package:food_delivery/pages/promotion/Promotions.dart';

final Map<String, WidgetBuilder> routes = {
  LoginPage.routeName: (context) => LoginPage(),
  CartItemsPage.routeName: (context) => CartItemsPage(),
  HomeScreen.routeName: (context) => HomeScreen(),
  CategoryPage.routeName: (context) => CategoryPage(),
  OderScreen.routeName: (context) => OderScreen(),
  FavoriteScreen.routeName: (context) => FavoriteScreen(),
  NoficationScreen.routeName: (context) => NoficationScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  PromotionScreen.routeName: (context) => PromotionScreen(),
  AdressScreen.routeName: (context) => AdressScreen(),
  SignupPage.routeName: (context) => SignupPage()
};
