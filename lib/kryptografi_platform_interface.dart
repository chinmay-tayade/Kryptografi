import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'kryptografi_method_channel.dart';

abstract class KryptografiPlatform extends PlatformInterface {
  /// Constructs a KryptografiPlatform.
  KryptografiPlatform() : super(token: _token);

  static final Object _token = Object();

  static KryptografiPlatform _instance = MethodChannelKryptografi();

  /// The default instance of [KryptografiPlatform] to use.
  ///
  /// Defaults to [MethodChannelKryptografi].
  static KryptografiPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [KryptografiPlatform] when
  /// they register themselves.
  static set instance(KryptografiPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
