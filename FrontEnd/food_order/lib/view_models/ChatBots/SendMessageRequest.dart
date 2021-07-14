import 'package:json_annotation/json_annotation.dart';

part 'SendMessageRequest.g.dart';

@JsonSerializable()
class SendMessageRequest {
  String session_id;
  String message;
  SendMessageRequest(this.session_id, this.message);

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SendMessageRequestToJson(this);
}
