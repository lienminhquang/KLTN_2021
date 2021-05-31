import 'package:food_delivery/pages/adress/AddAdressScreen.dart';
import 'package:food_delivery/pages/adress/Address.dart';
import 'package:food_delivery/pages/cart/cart_screen.dart';
import 'package:food_delivery/pages/categoty/Category.dart';
import 'package:food_delivery/pages/favorite/Favorite.dart';
import 'package:food_delivery/pages/food_detail/food_detail.dart';
import 'package:food_delivery/pages/home/Home.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/pages/login_signup/SignUp.dart';
import 'package:food_delivery/pages/nofication/Nofication.dart';
import 'package:food_delivery/pages/oders/Orders.dart';
import 'package:food_delivery/pages/profile/Profile.dart';
import 'package:food_delivery/pages/promotion/Promotions.dart';

final Map<String, WidgetBuilder> routes = {
  CartScreen.routeName: (context) => CartScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  OderScreen.routeName: (context) => OderScreen(),
  FavoriteScreen.routeName: (context) => FavoriteScreen(),
  NoficationScreen.routeName: (context) => NoficationScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  //PromotionScreen.routeName: (context) => PromotionScreen(),
  //AddressScreen.routeName: (context) => AddressScreen(),
  SignupPage.routeName: (context) => SignupPage(),
  AddAdressScreen.routeName: (context) => AddAdressScreen(),
  //FoodDetail.routeName: (context) => FoodDetail(),
};
