import 'dart:async';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

var notificationIDRandom =
    Random(); // keep this somewhere in a static variable. Just make sure to initialize only once.
String? deviceToken = "";

class FCMServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> configureFCM() async {
    var initializationSettingAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingAndroid);

    await Firebase.initializeApp();
    deviceToken = await FirebaseMessaging.instance.getToken();
    if (deviceToken != null) {
      print("FCM Token: " + deviceToken.toString());
    }
    if (deviceToken == null) {
      print("FCM Failed to get device token, PN will not work!");
      return;
    }

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var initResult = await flutterLocalNotificationsPlugin
        .initialize(initializationSettings);
    print("Init Local Notification Pluging: " + initResult.toString());

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');

        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification!.android;

        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
        if (notification != null && android != null) {
          int id1 = notificationIDRandom.nextInt(pow(2, 31).toInt() - 1);

          flutterLocalNotificationsPlugin.show(
              id1,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  icon: android.smallIcon,
                  // other properties...
                ),
              ));
        }
      }
    });
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
