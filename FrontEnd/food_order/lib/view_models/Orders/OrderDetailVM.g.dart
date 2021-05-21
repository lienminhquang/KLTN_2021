// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderDetailVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailVM _$OrderDetailVMFromJson(Map<String, dynamic> json) {
  return OrderDetailVM()
    ..orderID = json['orderID'] as int
    ..foodID = json['foodID'] as int
    ..amount = json['amount'] as int
    ..price = (json['price'] as num).toDouble()
    ..orderVM = json['orderVM'] == null
        ? null
        : OrderVM.fromJson(json['orderVM'] as Map<String, dynamic>)
    ..foodVM = json['foodVM'] == null
        ? null
        : FoodVM.fromJson(json['foodVM'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OrderDetailVMToJson(OrderDetailVM instance) =>
    <String, dynamic>{
      'orderID': instance.orderID,
      'foodID': instance.foodID,
      'amount': instance.amount,
      'price': instance.price,
      'orderVM': instance.orderVM?.toJson(),
      'foodVM': instance.foodVM?.toJson(),
    };
