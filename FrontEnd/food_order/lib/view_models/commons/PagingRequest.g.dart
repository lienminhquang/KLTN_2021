// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PagingRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagingRequest _$PagingRequestFromJson(Map<String, dynamic> json) {
  return PagingRequest()
    ..SortOrder = json['SortOrder'] as String?
    ..SearchString = json['SearchString'] as String?
    ..PageNumber = json['PageNumber'] as int?;
}

Map<String, dynamic> _$PagingRequestToJson(PagingRequest instance) =>
    <String, dynamic>{
      'SortOrder': instance.SortOrder,
      'SearchString': instance.SearchString,
      'PageNumber': instance.PageNumber,
    };
