// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderVM _$OrderVMFromJson(Map<String, dynamic> json) {
  return OrderVM()
    ..id = json['id'] as int
    ..appUserID = json['appUserID'] as String
    ..createdDate = DateTime.parse(json['createdDate'] as String)
    ..isPaid = json['isPaid'] as bool
    ..datePaid = json['datePaid'] == null
        ? null
        : DateTime.parse(json['datePaid'] as String)
    ..orderStatusID = json['orderStatusID'] as int
    ..promotionID = json['promotionID'] as int?
    ..promotionAmount = (json['promotionAmount'] as num?)?.toDouble()
    ..addressString = json['addressString'] as String
    ..addressName = json['addressName'] as String
    ..orderDetailVMs = (json['orderDetailVMs'] as List<dynamic>)
        .map((e) => OrderDetailVM.fromJson(e as Map<String, dynamic>))
        .toList()
    ..orderStatusVM =
        OrderStatusVM.fromJson(json['orderStatusVM'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OrderVMToJson(OrderVM instance) => <String, dynamic>{
      'id': instance.id,
      'appUserID': instance.appUserID,
      'createdDate': instance.createdDate.toIso8601String(),
      'isPaid': instance.isPaid,
      'datePaid': instance.datePaid?.toIso8601String(),
      'orderStatusID': instance.orderStatusID,
      'promotionID': instance.promotionID,
      'promotionAmount': instance.promotionAmount,
      'addressString': instance.addressString,
      'addressName': instance.addressName,
      'orderDetailVMs': instance.orderDetailVMs.map((e) => e.toJson()).toList(),
      'orderStatusVM': instance.orderStatusVM.toJson(),
    };
