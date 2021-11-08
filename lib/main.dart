import 'package:app_modular/app/app_module.dart';
import 'package:app_modular/app/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'dart:developer' as developer;
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Modular.to.addListener(() {
    developer.log('PATH: ${Modular.to.path}', name: 'NAVIGATION');
  });
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  debugPrint(token);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  Future.delayed(Duration(seconds: 2))
      .then((value) => Modular.to.navigate('/auth/'));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
