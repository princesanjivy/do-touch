import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:do_touch/do_touch.dart';
import 'package:do_touch_example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'get_position.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      // platformVersion =
      // await DoTouch.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(
        children: [
          Center(
            child: Text('Running on: $_platformVersion\n'),
          ),
          ElevatedButton(
            onPressed: () async {
              bool check = await DoTouch.isAccessibilityGranted ?? false;
              print(check);
            },
            child: Text("check enabled!"),
          ),
          ElevatedButton(
            onPressed: () async {
              const int helloAlarmID = 0;
              await AndroidAlarmManager.oneShot(
                  const Duration(seconds: 10), helloAlarmID, printHello);
            },
            child: const Text("One Shot"),
          ),
          ElevatedButton(
            onPressed: () async {
              bool check = await DoTouch.getPermission ?? false;
              print(check);
            },
            child: const Text("Get Permission"),
          ),
          ElevatedButton(
            onPressed: () async {
              Future.delayed(Duration(seconds: 10), () async {
                if (await DoTouch.isDeviceLocked ?? false) {
                  await DoTouch.touchPoint(x: 540, y: 1900, canSwipe: true);
                  // printHello();
                }
              });
            },
            child: const Text("Unlock"),
          ),
          ElevatedButton(
            onPressed: () async {
              // AndroidIntent intent = const AndroidIntent(
              //   action: 'action_view',
              //   data: 'https://play.google.com/store/apps/details?'
              //       'id=com.princeappstudio.sharestapp',
              //   arguments: {'authAccount': "sanjivy.android@gmail.com"},
              // );
              // await intent.launch().whenComplete(() {
              //   print("COMPLETED!");
              // });

              await launch("https://meet.google.com/jah-mqmt-akf");

              Future.delayed(const Duration(seconds: 2), () async {
                await DoTouch.touchPoint(x: 514, y: 556);
              });

              Future.delayed(const Duration(seconds: 8), () async {
                bool result =
                    await DoTouch.touchPoint(x: 440, y: 1200) ?? false;

                bool result1 =
                    await DoTouch.touchPoint(x: 707.64, y: 1200) ?? false;

                print(result);
                print(result1);

                // Future.delayed(const Duration(seconds: 15), () async {
                //   await DoTouch.touchPoint(x: 540, y: 2333);
                // });
              });
            },
            child: const Text("Do Touch"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GetPosition(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
