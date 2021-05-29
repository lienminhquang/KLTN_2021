// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SaleCampaignVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleCampaignVM _$SaleCampaignVMFromJson(Map<String, dynamic> json) {
  return SaleCampaignVM()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..desciption = json['desciption'] as String
    ..startDate = DateTime.parse(json['startDate'] as String)
    ..endDate = DateTime.parse(json['endDate'] as String)
    ..percent = (json['percent'] as num).toDouble()
    ..enabled = json['enabled'] as bool
    ..priority = json['priority'] as int
    ..foodVMs = (json['foodVMs'] as List<dynamic>?)
        ?.map((e) => FoodVM.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$SaleCampaignVMToJson(SaleCampaignVM instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desciption': instance.desciption,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'percent': instance.percent,
      'enabled': instance.enabled,
      'priority': instance.priority,
      'foodVMs': instance.foodVMs,
    };
