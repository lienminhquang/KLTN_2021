// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PagingRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagingRequest _$PagingRequestFromJson(Map<String, dynamic> json) {
  return PagingRequest(
    searchString: json['searchString'] as String?,
    sortOrder: json['sortOrder'] as String?,
    pageNumber: json['pageNumber'] as int?,
  );
}

Map<String, dynamic> _$PagingRequestToJson(PagingRequest instance) =>
    <String, dynamic>{
      'sortOrder': instance.sortOrder,
      'searchString': instance.searchString,
      'pageNumber': instance.pageNumber,
    };
