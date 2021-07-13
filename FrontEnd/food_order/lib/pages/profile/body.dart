import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Home/HomeBloc.dart';
import 'package:food_delivery/bloc/Profile/ProfileBloc.dart';
import 'package:food_delivery/bloc/Profile/ProfileState.dart';
import 'package:food_delivery/pages/adress/Address.dart';
import 'package:food_delivery/pages/home/AppLoadingScreen.dart';
import 'package:food_delivery/pages/login_signup/Login.dart';
import 'package:food_delivery/pages/profile/ChangeName.dart';
import 'package:food_delivery/pages/profile/ChangePasswordScreen.dart';
import 'package:food_delivery/services/UserServices.dart';

import 'ProfileMenu.dart';
import 'ProfilePicture.dart';

class Body extends StatelessWidget {
  Widget _buildLoadeState(BuildContext context, ProfileLoadedState state) {
    String fullname = state.userVM.name;
    return Column(
      children: [
        ProfilePic(),
        //SizedBox(height: 20),
        ProfileMenu(
          icon: Icon(
            Icons.person,
            color: Theme.of(context).iconTheme.color,
          ),
          text: fullname,
          press: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChangeNameScreen(fullname)));
          },
        ),
        ProfileMenu(
          icon: Icon(Icons.location_on_outlined,
              color: Theme.of(context).iconTheme.color),
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
          icon: Icon(Icons.lock_outline_rounded,
              color: Theme.of(context).iconTheme.color),
          text: 'Đổi mật khẩu',
          press: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangePasswordScreen()));
          },
        ),
        ProfileMenu(
          icon: Icon(Icons.phone, color: Theme.of(context).iconTheme.color),
          text: state.userVM.username,
          press: () {},
        ),
        ProfileMenu(
          icon: Icon(Icons.logout, color: Theme.of(context).iconTheme.color),
          text: 'Đăng xuất',
          press: () async {
            UserServices userServices = UserServices();
            await userServices.logout();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
              return LoginPage();
            }), (Route<dynamic> route) => false);
          },
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return AppLoadingScreen();
  }

  Widget _buildErrorState(ProfileErrorState state) {
    return Container(
      child: Center(child: Text(state.error)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadedState) {
          return _buildLoadeState(context, state);
        }
        if (state is ProfileLoadingState) {
          return _buildLoadingState();
        }
        if (state is ProfileErrorState) {
          return _buildErrorState(state);
        }
        throw "Unknow state";
      },
    );
  }
}
