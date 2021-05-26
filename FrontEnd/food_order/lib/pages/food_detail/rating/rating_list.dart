import 'package:flutter/material.dart';
import 'package:food_delivery/pages/food_detail/rating/user_details_with_image.dart';
import 'package:food_delivery/view_models/ratings/RatingVM.dart';

class CommentsList extends StatelessWidget {
  final List<RatingVM> _listRatingVM;
  CommentsList(this._listRatingVM);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _listRatingVM.length,
      itemBuilder: (BuildContext context, int index) {
        //foodVM.ratin
        return _SingleComment(_listRatingVM[index]);
      },
    );
  }
}

class _SingleComment extends StatelessWidget {
  final RatingVM _ratingVM;
  _SingleComment(this._ratingVM);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserDetailsWithFollow(_ratingVM.userFullName,
              _ratingVM.lastCreatedTime, _ratingVM.star),
          Text(
            _ratingVM.comment,
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
