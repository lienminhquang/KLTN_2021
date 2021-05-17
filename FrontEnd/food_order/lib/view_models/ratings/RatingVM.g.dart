// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RatingVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingVM _$RatingVMFromJson(Map<String, dynamic> json) {
  return RatingVM()
    ..appUserID = json['appUserID'] as String
    ..foodID = json['foodID'] as int
    ..star = json['star'] as int
    ..comment = json['comment'] as String
    ..lastCreatedTime = DateTime.parse(json['lastCreatedTime'] as String)
    ..userFullName = json['userFullName'] as String;
}

Map<String, dynamic> _$RatingVMToJson(RatingVM instance) => <String, dynamic>{
      'appUserID': instance.appUserID,
      'foodID': instance.foodID,
      'star': instance.star,
      'comment': instance.comment,
      'lastCreatedTime': instance.lastCreatedTime.toIso8601String(),
      'userFullName': instance.userFullName,
    };
