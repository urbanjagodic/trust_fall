import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class TrustFall {
  static const MethodChannel _channel = const MethodChannel('trust_fall');

  //Checks whether device JailBroken on iOS/Android?
  static Future<bool> get isJailBroken async {
    final bool isJailBroken = await _channel.invokeMethod('isJailBroken');
    return isJailBroken;
  }

  // Checks whether device is real or emulator
  static Future<bool> get isRealDevice async {
    final bool isRealDevice = await _channel.invokeMethod('isRealDevice');
    return isRealDevice;
  }

  // (ANDROID ONLY) Check if application is running on external storage
  static Future<bool> get isOnExternalStorage async {
    final bool isOnExternalStorage =
        await _channel.invokeMethod('isOnExternalStorage');
    return isOnExternalStorage;
  }

  // Check if device violates any of the above
  static Future<bool> get isTrustFall async {
    final bool isJailBroken = await _channel.invokeMethod('isJailBroken');
    final bool isRealDevice = await _channel.invokeMethod('isRealDevice');
    if (Platform.isAndroid) {
      final bool isOnExternalStorage =
          await _channel.invokeMethod('isOnExternalStorage');
      return isJailBroken ||
          !isRealDevice ||
          isOnExternalStorage;
    } else {
      return isJailBroken || !isRealDevice;
    }
  }
}
