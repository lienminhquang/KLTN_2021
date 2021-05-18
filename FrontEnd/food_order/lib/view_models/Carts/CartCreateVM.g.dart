// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CartCreateVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartCreateVM _$CartCreateVMFromJson(Map<String, dynamic> json) {
  return CartCreateVM()
    ..appUserId = json['appUserId'] as String
    ..foodID = json['foodID'] as int
    ..quantity = json['quantity'] as int;
}

Map<String, dynamic> _$CartCreateVMToJson(CartCreateVM instance) =>
    <String, dynamic>{
      'appUserId': instance.appUserId,
      'foodID': instance.foodID,
      'quantity': instance.quantity,
    };
