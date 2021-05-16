import 'package:json_annotation/json_annotation.dart';

part 'PagingRequest.g.dart';

@JsonSerializable()
class PagingRequest {
  PagingRequest();

  String? SortOrder;
  String? SearchString;
  int? PageNumber;

  factory PagingRequest.fromJson(Map<String, dynamic> json) =>
      _$PagingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PagingRequestToJson(this);
}
