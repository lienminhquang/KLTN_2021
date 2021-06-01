import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Cart/CartBloc.dart';
import 'package:food_delivery/bloc/Cart/CartEvent.dart';
import 'package:food_delivery/bloc/Address/AddressBloc.dart';
import 'package:food_delivery/bloc/Address/AddressEvent.dart';
import 'package:food_delivery/bloc/Category/CategoryBloc.dart';
import 'package:food_delivery/bloc/FoodDetail/FoodDetailBloc.dart';
import 'package:food_delivery/bloc/Home/HomeBloc.dart';
import 'package:food_delivery/bloc/Home/HomeEvent.dart';
import 'package:food_delivery/bloc/Login/LoginBloc.dart';
import 'package:food_delivery/bloc/Login/LoginEvent.dart';
import 'package:food_delivery/bloc/OrderDetails/OrderDetailsBloc.dart';
import 'package:food_delivery/bloc/OrderHistory/OrderHistoryBloc.dart';
import 'package:food_delivery/bloc/OrderHistory/OrderHistoryEvent.dart';
import 'package:food_delivery/bloc/Promotions/PromotionBloc.dart';
import 'package:food_delivery/bloc/Promotions/PromotionEvent.dart';
import 'package:food_delivery/bloc/Search/SearchBloc.dart';
import 'package:food_delivery/configs/DevHttpsOveride.dart';
import 'package:food_delivery/pages/login_signup/Login.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';

void main() {
  //acept bad certificate request
  HttpOverrides.global = new DevHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddressBloc>(
            create: (_) => AddressBloc()..add(AddressStarted())),
        BlocProvider<CartBloc>(
            create: (_) => CartBloc()..add(CartStartedEvent())),
        BlocProvider<CategoryBloc>(create: (_) => CategoryBloc()),
        BlocProvider<FoodDetailBloc>(
            create: (_) =>
                FoodDetailBloc()), // no need to and started event here??
        BlocProvider<HomeBloc>(
            create: (_) => HomeBloc()..add(HomeStartedEvent())),
        BlocProvider<OrderHistoryBloc>(
            create: (_) => OrderHistoryBloc()..add(OrderHistoryStartedEvent())),
        BlocProvider<LoginBloc>(
            create: (_) => LoginBloc()..add(LoginStartedEvent())),
        BlocProvider<SearchBloc>(create: (_) => SearchBloc()),
        BlocProvider<PromotionBloc>(
            create: (_) => PromotionBloc()..add(PromotionStartedEvent())),
        BlocProvider<OrderDetailsBloc>(create: (_) => OrderDetailsBloc()),
      ],
      child: MaterialApp(
        title: 'Food Delivery',
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        // ),
        theme: AppTheme.lightTheme,
        home: LoginPage(),
      ),
    );
  }
}
