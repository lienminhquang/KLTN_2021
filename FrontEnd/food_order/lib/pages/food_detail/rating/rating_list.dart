import 'package:flutter/material.dart';
import 'package:food_delivery/models/FoodDetailModel.dart';
import 'package:food_delivery/pages/food_detail/rating/user_details_with_image.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'package:food_delivery/view_models/ratings/RatingVM.dart';
import 'package:provider/provider.dart';

class CommentsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ratingList = context
        .select<FoodDetailModel, List<RatingVM>>((value) => value.ratingVMs);
    return ListView.builder(
      itemCount: ratingList.length,
      itemBuilder: (BuildContext context, int index) {
        //foodVM.ratin
        return _SingleComment(index);
      },
    );
  }
}

class _SingleComment extends StatelessWidget {
  final int _id;
  _SingleComment(this._id);
  @override
  Widget build(BuildContext context) {
    var ratings = context.read<FoodDetailModel>().ratingVMs;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserDetailsWithFollow(ratings[_id].userFullName,
              ratings[_id].lastCreatedTime, ratings[_id].star),
          Text(
            ratings[_id].comment,
            textAlign: TextAlign.left,
          ),
          Divider(
            color: Colors.black45,
          ),
        ],
      ),
    );
  }
}
