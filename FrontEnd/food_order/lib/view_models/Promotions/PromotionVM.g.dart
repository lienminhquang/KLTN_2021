// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PromotionVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionVM _$PromotionVMFromJson(Map<String, dynamic> json) {
  return PromotionVM()
    ..iD = json['iD'] as int
    ..name = json['name'] as String
    ..code = json['code'] as String
    ..desciption = json['desciption'] as String?
    ..createdDate = DateTime.parse(json['createdDate'] as String)
    ..startDate = DateTime.parse(json['startDate'] as String)
    ..endDate = DateTime.parse(json['endDate'] as String)
    ..amount = json['amount'] as int?
    ..percent = (json['percent'] as num).toDouble()
    ..enabled = json['enabled'] as bool
    ..max = json['max'] as int?
    ..minPrice = json['minPrice'] as int?;
}

Map<String, dynamic> _$PromotionVMToJson(PromotionVM instance) =>
    <String, dynamic>{
      'iD': instance.iD,
      'name': instance.name,
      'code': instance.code,
      'desciption': instance.desciption,
      'createdDate': instance.createdDate.toIso8601String(),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'amount': instance.amount,
      'percent': instance.percent,
      'enabled': instance.enabled,
      'max': instance.max,
      'minPrice': instance.minPrice,
    };
