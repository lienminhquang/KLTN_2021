import 'package:json_annotation/json_annotation.dart';

part 'PaginatedList.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class PaginatedList<T> {
  PaginatedList();

  int? pageIndex;
  int? totalPage;
  List<T>? items;

  factory PaginatedList.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PaginatedListFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$PaginatedListToJson(this, toJsonT);
}
