import 'package:flutter_test/flutter_test.dart';
import 'package:arp_lib/arp_lib.dart';
import 'package:arp_lib/arp_lib_platform_interface.dart';
import 'package:arp_lib/arp_lib_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockArpLibPlatform
    with MockPlatformInterfaceMixin
    implements ArpLibPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ArpLibPlatform initialPlatform = ArpLibPlatform.instance;

  test('$MethodChannelArpLib is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelArpLib>());
  });

  test('getPlatformVersion', () async {
    ArpLib arpLibPlugin = ArpLib();
    MockArpLibPlatform fakePlatform = MockArpLibPlatform();
    ArpLibPlatform.instance = fakePlatform;

    expect(await arpLibPlugin.getPlatformVersion(), '42');
  });
}
