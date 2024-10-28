// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer' as devtools;
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluffychat/utils/showSnack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



final _firebaseMessaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin foregroundFcmPlugin = FlutterLocalNotificationsPlugin();
//LOCAL NOTIFICATION
const AndroidNotificationChannel androidFcmChannel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',

  importance: Importance.max,
);

const InitializationSettings foregroundFcmSettings = InitializationSettings(
  android: AndroidInitializationSettings('app_icon'),
  iOS: DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    defaultPresentSound: true,
    defaultPresentBadge: true,
    defaultPresentAlert: true,
  ),
);

// TODO this houses the methods on fcm;
Future<void> initAndroidForegroundFcm() async {
  await foregroundFcmPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidFcmChannel);
}

Future<void> enableIOSForeground() async {
  await _firebaseMessaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future<void> disableIOSForeground() async {
  await _firebaseMessaging.setForegroundNotificationPresentationOptions(
    alert: false,
    badge: false,
    sound: false,
  );
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  onBgNotification(
    message,
  );
}

Future<void> requestDeviceFcmPermissions() async {
  NotificationSettings settings = await _firebaseMessaging.requestPermission(
    alert: true,
    sound: true,
    badge: true,
    announcement: false,
    carPlay: true,
    criticalAlert: false,
    provisional: false,
  );
  final status = settings.authorizationStatus;
  if (status == AuthorizationStatus.authorized) {
    log("User granted permission");
  } else if (status == AuthorizationStatus.provisional) {
    log("User granted provisional permission");
  } else {
    log("User declined or has not accepted permission: $status");
  }
}

Future<void> checkPermissions() async {
  devtools.log("Check permission");
  var status = await FirebaseMessaging.instance.getNotificationSettings();
  if (status.authorizationStatus.name.toLowerCase() == "granted") {
    devtools.log("=> Permission Granted Successfully.");
  } else {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}

Future<void> handleInitialFcmMessage(
  BuildContext context,
) async {
  devtools.log("HandleInitialFCM");
  RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
  if (initialMessage != null) {
    await handleNotificationClick(
      initialMessage,
      context,
      initialMessage.data,
      true,
    );
  }
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    await onTapBgNotification(message, context, message.data);
  });
}

// HANDLING SHOW NOTIFICATIONS
Future<void> onBgNotification(RemoteMessage message) async {
  final msg = "Handling a background notification ${message.data}";
  final msg2 = "Handling a background notification title ${message.notification?.title}";

  log("data = $msg");
  log("notification = $msg2");

  //
  // final InitializationSettings initializationSettings =
  //     InitializationSettings(android: foregroundFcmSettings.android, iOS: null, macOS: null);
  //
  // await foregroundFcmPlugin.initialize(initializationSettings);
  // const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
  //   'mychannel',
  //   'channela',
  //   channelDescription: 'your channel description',
  //   importance: Importance.max,
  //   priority: Priority.high,
  //   ticker: 'ticker',
  //   styleInformation: MediaStyleInformation(
  //     htmlFormatContent: true,
  //     htmlFormatTitle: true,
  //   ),
  // );
  //
  // const NotificationDetails platformChannelSpecifics =
  //     NotificationDetails(android: androidNotificationDetails);
  // await foregroundFcmPlugin.show(
  //   0,
  //   "DummyTest",
  //   "Description",
  //   platformChannelSpecifics,
  //   payload: "My PayLoad",
  // );
}

//HANDLING TAPS

Future<void> onTapBgNotification(
    RemoteMessage message, BuildContext context, Object? object) async {
  await handleNotificationClick(message, context, object, false);
}

Future<void> handleNotificationClick(
  RemoteMessage message,
  BuildContext context,
  Object? object,
  bool isFromInitial,
) async {
  try {
    log("onTapBGNotification");





  } catch (e) {
    log('OnTap Bg notification ${e.toString()}');
  }

  ///TODO of background notification click
}

Future onTapFgNotification(RemoteMessage? message, BuildContext context) async {
  try {
    log("onTapFgNotification");
    if (message != null) {




    }
  } catch (e) {
    log('onTap Fg Notification ${e.toString()}');
  }

  ///TODO of notification on tap
}

void onFgNotification(BuildContext context) {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {


    try {
      RemoteNotification? notification = message.notification;
      String? title;
      String? body;
      log("-->Notification data--> ${message.data.toString()}");
      log("-->Notification --> ${message.notification?.title}");
      log("-->Notification --> ${message.notification?.body}");
      log("-->Notification --> ${message.notification}");
      log("-->Notification --> ${message}");

        title = message.data['content_body'];
        body = message.data['content_body'];

      if (Platform.isAndroid) {

        Util.showNotificationOnAndroid(message,title??"",context,);

        // showTopSnackBar(
        //   Overlay.of(context),
        //   CustomSnackBar.info(
        //     message: title??"No Data",
        //   ),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        //       margin:EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        //       duration:Duration(seconds: 6) ,
        //       behavior: SnackBarBehavior.floating,
        //       content:  Text('${title??"Title"} '),
        //       action: SnackBarAction(
        //         label:  body.toString(),
        //         onPressed: () {
        //           // Some code to undo the change.
        //         },
        //       ),
        //     )
        // );
        //
        // if (notification != null) {
        //
        //
        //   // Util.showNotificationOnAndroid(
        //   //   message,
        //   //   title.toString(),
        //   //   body.toString(),
        //   //   context,
        //   //   payload: json.encode(message.data),
        //   // );
        //
        //   // BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        //   //   message.notification!.body.toString(),
        //   //   htmlFormatBigText: true,
        //   //   contentTitle: message.notification!.title.toString(),
        //   //   htmlFormatContentTitle: true,
        //   // );
        //   // AndroidNotificationDetails androidPlatformChannelSpecifies =
        //   //     AndroidNotificationDetails(
        //   //   "aizazHasUniqueId!%",
        //   //   "aizazChannelName4324",
        //   //   importance: Importance.high,
        //   //   styleInformation: bigTextStyleInformation,
        //   //   priority: Priority.high,
        //   //   playSound: true,
        //   //   // sound: const RawResourceAndroidNotificationSound('riseup'),
        //   //   color: const Color.fromARGB(255, 0, 77, 139),
        //   // );
        //   //
        //   // DarwinNotificationDetails iosPlatformChannelSpecifies =
        //   //     const DarwinNotificationDetails();
        //   // NotificationDetails platformChannelSpecifies = NotificationDetails(
        //   //   android: androidPlatformChannelSpecifies,
        //   //   iOS: iosPlatformChannelSpecifies,
        //   // );
        //   // await foregroundFcmPlugin.show(
        //   //   0,
        //   //   message.notification?.title,
        //   //   message.notification?.body,
        //   //   platformChannelSpecifies,
        //   //   payload: message.data["body"],
        //   // );
        // }else{
        //   devtools.log("notification");
        // }
      }
    } catch (e) {
      log("Caught onFg notification (match) error - $e");
    }
  });
}
