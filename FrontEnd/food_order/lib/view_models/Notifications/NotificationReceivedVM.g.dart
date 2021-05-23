// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationReceivedVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationReceivedVM _$NotificationReceivedVMFromJson(
    Map<String, dynamic> json) {
  return NotificationReceivedVM()
    ..notificationID = json['notificationID'] as int
    ..receiverID = json['receiverID'] as String;
}

Map<String, dynamic> _$NotificationReceivedVMToJson(
        NotificationReceivedVM instance) =>
    <String, dynamic>{
      'notificationID': instance.notificationID,
      'receiverID': instance.receiverID,
    };
