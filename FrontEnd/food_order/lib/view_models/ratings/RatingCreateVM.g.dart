// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RatingCreateVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingCreateVM _$RatingCreateVMFromJson(Map<String, dynamic> json) {
  return RatingCreateVM(
    json['orderID'] as int,
    json['foodID'] as int,
    json['star'] as int,
    json['comment'] as String,
  );
}

Map<String, dynamic> _$RatingCreateVMToJson(RatingCreateVM instance) =>
    <String, dynamic>{
      'orderID': instance.orderID,
      'foodID': instance.foodID,
      'star': instance.star,
      'comment': instance.comment,
    };
