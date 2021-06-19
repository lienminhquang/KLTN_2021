import 'package:json_annotation/json_annotation.dart';

part 'SendMessageRequest.g.dart';

@JsonSerializable()
class SendMessageRequest {
  String sender;
  String message;
  SendMessageRequest(this.sender, this.message);

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SendMessageRequestToJson(this);
}
