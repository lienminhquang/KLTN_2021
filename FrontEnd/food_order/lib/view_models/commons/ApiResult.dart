import 'package:json_annotation/json_annotation.dart';

part 'ApiResult.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class ApiResult<T> {
  T? payLoad;
  bool? isSuccessed;
  String? errorMessage;

  ApiResult(this.payLoad, this.isSuccessed, this.errorMessage);
  ApiResult.failedApiResult(this.errorMessage) {
    payLoad = null;
    isSuccessed = false;
  }
  ApiResult.succesedApiResult(this.payLoad) {
    errorMessage = null;
    isSuccessed = true;
  }

  // ApiResult.fromJson(Map<String, dynamic> json, Function create) {
  //   payLoad = create(json['payLoad']);
  //   isSuccessed = json['isSuccessed'] as bool?;
  //   errorMessage = json['errorMessage'];
  // }

  factory ApiResult.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiResultFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$ApiResultToJson(this, toJsonT);
}
