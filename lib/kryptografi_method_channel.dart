import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'kryptografi_platform_interface.dart';

/// An implementation of [KryptografiPlatform] that uses method channels.
class MethodChannelKryptografi extends KryptografiPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('kryptografi');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
