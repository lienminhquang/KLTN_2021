// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RatingVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingVM _$RatingVMFromJson(Map<String, dynamic> json) {
  return RatingVM()
    ..id = json['id'] as int
    ..appUserID = json['appUserID'] as String
    ..foodID = json['foodID'] as int
    ..star = json['star'] as int
    ..comment = json['comment'] as String
    ..userFullName = json['userFullName'] as String
    ..timeCreate = DateTime.parse(json['timeCreate'] as String);
}

Map<String, dynamic> _$RatingVMToJson(RatingVM instance) => <String, dynamic>{
      'id': instance.id,
      'appUserID': instance.appUserID,
      'foodID': instance.foodID,
      'star': instance.star,
      'comment': instance.comment,
      'userFullName': instance.userFullName,
      'timeCreate': instance.timeCreate.toIso8601String(),
    };
