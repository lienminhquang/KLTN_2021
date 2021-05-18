// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CartVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartVM _$CartVMFromJson(Map<String, dynamic> json) {
  return CartVM()
    ..appUserId = json['appUserId'] as String
    ..foodID = json['foodID'] as int
    ..quantity = json['quantity'] as int
    ..foodVM = FoodVM.fromJson(json['foodVM'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CartVMToJson(CartVM instance) => <String, dynamic>{
      'appUserId': instance.appUserId,
      'foodID': instance.foodID,
      'quantity': instance.quantity,
      'foodVM': instance.foodVM.toJson(),
    };
