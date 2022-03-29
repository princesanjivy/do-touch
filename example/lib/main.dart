import 'dart:async';
import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:do_touch/do_touch.dart';
import 'package:do_touch_example/home.dart';
import 'package:flutter/material.dart';

void printHello() async {
  AndroidIntent intent = const AndroidIntent(
    action: "action_view",
    data: "https://meet.google.com/jah-mqmt-akf",
    // arguments: {'authAccount': "sanjivy.android@gmail.com"},
  );
  await intent.launch();

  Future.delayed(const Duration(seconds: 2), () async {
    await DoTouch.touchPoint(x: 514, y: 556);
  });

  Future.delayed(const Duration(seconds: 8), () async {
    bool result = await DoTouch.touchPoint(x: 440, y: 1200) ?? false;

    bool result1 = await DoTouch.touchPoint(x: 707.64, y: 1200) ?? false;

    print(result);
    print(result1);

    // Future.delayed(const Duration(seconds: 15), () async {
    //   await DoTouch.touchPoint(x: 540, y: 2333);
    // });
  });

  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}
