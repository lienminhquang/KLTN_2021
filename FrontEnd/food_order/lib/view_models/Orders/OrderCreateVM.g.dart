// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderCreateVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCreateVM _$OrderCreateVMFromJson(Map<String, dynamic> json) {
  return OrderCreateVM()
    ..appUserID = json['appUserID'] as String
    ..isPaid = json['isPaid'] as bool
    ..datePaid = json['datePaid'] == null
        ? null
        : DateTime.parse(json['datePaid'] as String)
    ..orderStatusID = json['orderStatusID'] as int
    ..promotionID = json['promotionID'] as int?
    ..promotionAmount = (json['promotionAmount'] as num?)?.toDouble()
    ..addressString = json['addressString'] as String
    ..addressName = json['addressName'] as String;
}

Map<String, dynamic> _$OrderCreateVMToJson(OrderCreateVM instance) =>
    <String, dynamic>{
      'appUserID': instance.appUserID,
      'isPaid': instance.isPaid,
      'datePaid': instance.datePaid?.toIso8601String(),
      'orderStatusID': instance.orderStatusID,
      'promotionID': instance.promotionID,
      'promotionAmount': instance.promotionAmount,
      'addressString': instance.addressString,
      'addressName': instance.addressName,
    };
