import 'package:json_annotation/json_annotation.dart';

part 'PagingRequest.g.dart';

@JsonSerializable()
class PagingRequest {
  PagingRequest(
      {this.searchString, this.sortOrder, this.pageNumber, this.pageSize});

  String? sortOrder;
  String? searchString;
  int? pageNumber;
  int? pageSize;

  factory PagingRequest.fromJson(Map<String, dynamic> json) =>
      _$PagingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PagingRequestToJson(this);
}
