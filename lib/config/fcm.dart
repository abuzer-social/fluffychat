import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';



class FCMNotifications  {
  ///function to get fcm device token
  ///for device registration
  Future<String?> getFCMDeviceToken() async {
    try {
      final deviceToken = await FirebaseMessaging.instance.getToken();
      log("device token: ${deviceToken.toString()}");
      return deviceToken;
    } catch (e) {
      log("exception in getting token: ${e.toString()}");
      return null;
    }
  }
}
