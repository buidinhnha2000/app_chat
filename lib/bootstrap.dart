import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/app.dart';
import 'firebase_option.dart';

const String authDioInstance = 'auth_dio';
const String noAuthDioInstance = 'no_auth_dio';

Future<void> bootstrap() async{
  FlutterError.onError = (FlutterErrorDetails details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  EquatableConfig.stringify = true;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}
