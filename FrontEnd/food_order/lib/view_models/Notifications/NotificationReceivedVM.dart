import 'package:json_annotation/json_annotation.dart';
part 'NotificationReceivedVM.g.dart';

enum NotificationType {
  Message,
  OrderDelivered,
}

@JsonSerializable(explicitToJson: true)
class NotificationReceivedVM {
  NotificationReceivedVM();
  late int notificationID;
  late String receiverID;

  factory NotificationReceivedVM.fromJson(Map<String, dynamic> json) =>
      _$NotificationReceivedVMFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationReceivedVMToJson(this);
}
