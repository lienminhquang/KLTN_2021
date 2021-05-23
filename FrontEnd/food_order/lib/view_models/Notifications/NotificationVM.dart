import 'package:json_annotation/json_annotation.dart';
part 'NotificationVM.g.dart';

enum NotificationType {
  Message,
  OrderDelivered,
}

@JsonSerializable(explicitToJson: true)
class NotificationVM {
  NotificationVM();
  late int id;
  late String userID;
  late String title;
  late String message;
  late DateTime timeCreated;
  late int type;
  late bool userReceived;

  factory NotificationVM.fromJson(Map<String, dynamic> json) =>
      _$NotificationVMFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationVMToJson(this);
}
