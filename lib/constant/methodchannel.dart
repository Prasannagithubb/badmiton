// mobile_network_info.dart
import 'package:flutter/services.dart';

class MobileNetworkInfo {
  static const platform = MethodChannel('your_channel_name');

  Future<String?> getMobileNetworkName() async {
    try {
      return await platform.invokeMethod('getMobileNetworkName');
    } on PlatformException {
      return null;
    }
  }
}
