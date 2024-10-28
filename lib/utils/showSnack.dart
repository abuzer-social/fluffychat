

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snackbar_plus/flutter_snackbar_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Util{


  static void showNotificationOnAndroid(
      RemoteMessage message, String title,  BuildContext context,) {
    FlutterSnackBar.showTemplated(
      context,
      title: 'Notification',
      message: title,
      // leading: Icon(
      //   Icons.info,
      //   size: 32,
      //   color: Colors.green[700],
      // ),
      style: FlutterSnackBarStyle(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        radius: BorderRadius.circular(6),
        backgroundColor: Colors.white,
        shadow: BoxShadow(
          color: Colors.black.withOpacity(0.55),
          blurRadius: 32,
          offset: const Offset(0, 12),
          blurStyle: BlurStyle.normal,
          spreadRadius: -10,
        ),
        leadingSpace: 22,
        trailingSpace: 12,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        titleStyle: const TextStyle(fontSize: 20, color: Colors.black),
        messageStyle: TextStyle(fontSize: 16, color: Colors.black),
        titleAlignment: TextAlign.start,
        messageAlignment: TextAlign.start,),
      configuration: const FlutterSnackBarConfiguration(
        location: FlutterSnackBarLocation.top,
        distance: 35,
        animationCurve: Curves.ease,
        animationDuration: Duration(milliseconds: 300),
        showDuration: Duration(seconds: 2),
        persistent: false,
        dismissible: true,
        dismissDirection: DismissDirection.up,
        showLoadingBar: false,
      ),
    );
  }


  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP, // Position at bottom
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }
}