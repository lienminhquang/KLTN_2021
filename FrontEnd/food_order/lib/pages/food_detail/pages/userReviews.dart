import 'package:flutter/material.dart';
import 'package:food_delivery/pages/food_detail/rating/rating_list.dart';

class UserReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Padding(
        padding: const EdgeInsets.all(14.0),
        child: new Center(child: CommentsList()),
      ),
    );
  }
}
