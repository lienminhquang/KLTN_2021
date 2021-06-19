// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageData _$MessageDataFromJson(Map<String, dynamic> json) {
  return MessageData(
    json['text'] as String?,
    json['attachment'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$MessageDataToJson(MessageData instance) =>
    <String, dynamic>{
      'text': instance.text,
      'attachment': instance.attachment,
    };
