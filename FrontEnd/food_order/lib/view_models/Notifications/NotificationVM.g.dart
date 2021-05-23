// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationVM _$NotificationVMFromJson(Map<String, dynamic> json) {
  return NotificationVM()
    ..id = json['id'] as int
    ..userID = json['userID'] as String
    ..title = json['title'] as String
    ..message = json['message'] as String
    ..timeCreated = DateTime.parse(json['timeCreated'] as String)
    ..type = json['type'] as int
    ..userReceived = json['userReceived'] as bool;
}

Map<String, dynamic> _$NotificationVMToJson(NotificationVM instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'title': instance.title,
      'message': instance.message,
      'timeCreated': instance.timeCreated.toIso8601String(),
      'type': instance.type,
      'userReceived': instance.userReceived,
    };
