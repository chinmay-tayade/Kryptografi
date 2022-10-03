import 'package:flutter_test/flutter_test.dart';
import 'package:kryptografi/kryptografi.dart';
import 'package:kryptografi/kryptografi_platform_interface.dart';
import 'package:kryptografi/kryptografi_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockKryptografiPlatform 
    with MockPlatformInterfaceMixin
    implements KryptografiPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final KryptografiPlatform initialPlatform = KryptografiPlatform.instance;

  test('$MethodChannelKryptografi is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelKryptografi>());
  });

  test('getPlatformVersion', () async {
    Kryptografi kryptografiPlugin = Kryptografi();
    MockKryptografiPlatform fakePlatform = MockKryptografiPlatform();
    KryptografiPlatform.instance = fakePlatform;
  
    expect(await kryptografiPlugin.getPlatformVersion(), '42');
  });
}
