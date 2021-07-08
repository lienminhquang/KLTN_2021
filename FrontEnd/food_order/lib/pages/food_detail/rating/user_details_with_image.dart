import 'package:flutter/material.dart';
import 'package:food_delivery/pages/commons/StarRating.dart';
import 'package:food_delivery/pages/food_detail/rating/user_details.dart';

class UserDetailsWithFollowKeys {
  static final ValueKey userDetails = ValueKey("UserDetails");
  static final ValueKey follow = ValueKey("follow");
}

class UserDetailsWithFollow extends StatelessWidget {
  final String _userFullName;
  final DateTime _dateCreated;
  final int _star;
  UserDetailsWithFollow(this._userFullName, this._dateCreated, this._star);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: UserDetails(this._userFullName, this._dateCreated),
        ),
        Expanded(
          flex: 1,
          child: Container(
            key: UserDetailsWithFollowKeys.follow,
            alignment: Alignment.centerRight,
            child: StarRating(
              rating: _star.toDouble(),
            ),
          ),
        ),
      ],
    );
  }
}
