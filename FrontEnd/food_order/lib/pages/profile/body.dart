import 'package:flutter/material.dart';
import 'package:food_delivery/pages/adress/Adress.dart';
import 'package:food_delivery/pages/promotion/Promotions.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePic(),
        SizedBox(height: 20),
        ProfileMenu(
          icon: Icon(Icons.confirmation_num_outlined),
          text: 'Mã khuyến mãi',
          press: () => Navigator.pushNamed(context, PromotionScreen.routeName),
        ),
        ProfileMenu(
          icon: Icon(Icons.location_on_outlined),
          text: 'Địa chỉ',
          press: () => Navigator.pushNamed(context, AdressScreen.routeName),
        ),
        ProfileMenu(
          icon: Icon(Icons.settings),
          text: 'Cài đặt',
          press: () {},
        ),
        ProfileMenu(
          icon: Icon(Icons.info_outline),
          text: 'Về chúng tôi',
          press: () {},
        ),
        ProfileMenu(
          icon: Icon(Icons.logout),
          text: 'Đăng xuất',
          press: () {},
        ),
      ],
    );
  }
}