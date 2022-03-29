import 'dart:async';

import 'package:flutter/services.dart';

class DoTouch {
  static const MethodChannel _channel = MethodChannel('do_touch');

  static Future<bool?> get getPermission async {
    final bool? status = await _channel.invokeMethod("getPermission");

    if (status != null) {
      return status;
    }
  }

  static Future<bool?> get getLockPermission async {
    final bool? status = await _channel.invokeMethod("getLockPermission");

    if (status != null) {
      return status;
    }
  }

  static Future<bool?> get isDeviceLocked async {
    bool? status;
    await _channel.invokeMethod("isDeviceLocked").then((value) {
      status = value;
    });

    if (status != null) {
      return status;
    }
  }

  static Future<bool?> get isAccessibilityGranted async {
    bool? status;
    await _channel.invokeMethod("isAccessibilityGranted").then((value) {
      status = value;
    });

    if (status != null) {
      return status;
    }
  }

  static Future<bool?> get screenOn async {
    bool? status;
    await _channel.invokeMethod("screenOn").then((value) {
      status = value;
    });

    if (status != null) {
      return status;
    }
  }

  static Future<bool?> touchPoint(
      {required double x, required double y, canSwipe = false}) async {
    final bool? status = await _channel.invokeMethod(
      "touchPoint",
      {"x": x, "y": y, "canSwipe": canSwipe},
    );

    if (status != null) {
      return status;
    }
  }
}
