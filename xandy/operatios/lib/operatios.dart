
import 'dart:async';

import 'package:flutter/services.dart';

class Operatios {
  static const MethodChannel _channel = MethodChannel('operatios');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
