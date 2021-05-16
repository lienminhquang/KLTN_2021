// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FoodVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodVM _$FoodVMFromJson(Map<String, dynamic> json) {
  return FoodVM(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    price: (json['price'] as num).toDouble(),
    count: json['count'] as int,
    imagePath: json['imagePath'] as String,
  );
}

Map<String, dynamic> _$FoodVMToJson(FoodVM instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'count': instance.count,
      'imagePath': instance.imagePath,
    };
