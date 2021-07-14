// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SendMessageRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessageRequest _$SendMessageRequestFromJson(Map<String, dynamic> json) {
  return SendMessageRequest(
    json['session_id'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$SendMessageRequestToJson(SendMessageRequest instance) =>
    <String, dynamic>{
      'session_id': instance.session_id,
      'message': instance.message,
    };
