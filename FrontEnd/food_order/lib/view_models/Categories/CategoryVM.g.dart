// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CategoryVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryVM _$CategoryVMFromJson(Map<String, dynamic> json) {
  return CategoryVM()
    ..id = json['id'] as int?
    ..name = json['name'] as String?
    ..description = json['description'] as String?;
}

Map<String, dynamic> _$CategoryVMToJson(CategoryVM instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
