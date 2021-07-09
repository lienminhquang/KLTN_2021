// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PromotionVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionVM _$PromotionVMFromJson(Map<String, dynamic> json) {
  return PromotionVM()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..code = json['code'] as String
    ..desciption = json['desciption'] as String?
    ..startDate = DateTime.parse(json['startDate'] as String)
    ..endDate = DateTime.parse(json['endDate'] as String)
    ..useTimes = json['useTimes'] as int?
    ..percent = (json['percent'] as num).toDouble()
    ..enabled = json['enabled'] as bool
    ..max = (json['max'] as num?)?.toDouble()
    ..minPrice = (json['minPrice'] as num?)?.toDouble()
    ..isGlobal = json['isGlobal'] as bool
    ..timeUsedByCurrentUser = json['timeUsedByCurrentUser'] as int
    ..imagePath = json['imagePath'] as String;
}

Map<String, dynamic> _$PromotionVMToJson(PromotionVM instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'desciption': instance.desciption,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'useTimes': instance.useTimes,
      'percent': instance.percent,
      'enabled': instance.enabled,
      'max': instance.max,
      'minPrice': instance.minPrice,
      'isGlobal': instance.isGlobal,
      'timeUsedByCurrentUser': instance.timeUsedByCurrentUser,
      'imagePath': instance.imagePath,
    };
