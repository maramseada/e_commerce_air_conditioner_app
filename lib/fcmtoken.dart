// import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'custom_notification_channel_id',
//   'Notification',
//   description: 'notifications from Your App Name.',
//   importance: Importance.high,
// );
//
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }
//
// void setupFcm() {
//   var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
//   var initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//   );
//   //When the app is in the background, but not terminated.
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     RemoteNotification? notification = message.notification;
//     if (notification != null) {
//       print("message ${message.messageId}");
//     }
//   },
//     cancelOnError: false,
//     onDone: () {},
//   );
//
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//     if (notification != null && android != null) {
//       flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//             channelDescription: channel.description,
//             icon: 'custom_notification_icon',
//             importance: Importance.max,
//             priority: Priority.high,
//           ),
//         ),
//         payload: json.encode(message.data),
//       );
//     }
//   });
//
// }
//
// Future<void> deleteFcmToken() async {
//   return await FirebaseMessaging.instance.deleteToken();
// }
//
// Future<String> getFcmToken() async {
//   String? token = await FirebaseMessaging.instance.getToken();
//   return Future.value(token);
// }