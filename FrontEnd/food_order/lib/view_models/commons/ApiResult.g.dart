// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResult<T> _$ApiResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return ApiResult<T>(
    _$nullableGenericFromJson(json['payLoad'], fromJsonT),
    json['isSuccessed'] as bool?,
    json['errorMessage'] as String?,
  );
}

Map<String, dynamic> _$ApiResultToJson<T>(
  ApiResult<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'payLoad': _$nullableGenericToJson(instance.payLoad, toJsonT),
      'isSuccessed': instance.isSuccessed,
      'errorMessage': instance.errorMessage,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
