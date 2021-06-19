import 'package:json_annotation/json_annotation.dart';

part 'MessageData.g.dart';

@JsonSerializable()
class MessageData {
  String? text;
  Map<String, dynamic>? attachment;

  MessageData(this.text, this.attachment);

  factory MessageData.fromJson(Map<String, dynamic> json) =>
      _$MessageDataFromJson(json);
  Map<String, dynamic> toJson() => _$MessageDataToJson(this);
}
