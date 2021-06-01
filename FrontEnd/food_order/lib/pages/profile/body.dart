import 'package:flutter/material.dart';
import 'package:food_delivery/pages/adress/Address.dart';
import 'change_password.dart';
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
          icon: Icon(Icons.person),
          text: 'Hoàng Phong Sang',
          press: () {},
        ),
        ProfileMenu(
          icon: Icon(Icons.location_on_outlined),
          text: 'Địa chỉ',
          press: () {
            //context.read<AddressBloc>().fetchAll();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddressScreen(
                          addressScreenCallBack: null,
                        )));
          },
        ),
        ProfileMenu(
          icon: Icon(Icons.lock_outline_rounded),
          text: 'Đổi mật khẩu',
          press: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangePasswordScreen()));
          },
        ),
        ProfileMenu(
          icon: Icon(Icons.phone),
          text: '0392131844',
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
