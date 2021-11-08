import 'package:app_modular/app/app_module.dart';
import 'package:app_modular/app/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'dart:developer' as developer;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Modular.to.addListener(() {
    developer.log('PATH: ${Modular.to.path}', name: 'NAVIGATION');
  });
  Future.delayed(Duration(seconds: 2))
      .then((value) => Modular.to.navigate('/auth/'));
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
