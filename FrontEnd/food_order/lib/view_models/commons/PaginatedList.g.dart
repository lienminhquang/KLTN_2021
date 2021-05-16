// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PaginatedList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedList<T> _$PaginatedListFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return PaginatedList<T>()
    ..pageIndex = json['pageIndex'] as int?
    ..totalPage = json['totalPage'] as int?
    ..items = (json['items'] as List<dynamic>?)?.map(fromJsonT).toList();
}

Map<String, dynamic> _$PaginatedListToJson<T>(
  PaginatedList<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'totalPage': instance.totalPage,
      'items': instance.items?.map(toJsonT).toList(),
    };
