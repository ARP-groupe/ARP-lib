import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'arp_lib_platform_interface.dart';

/// An implementation of [ArpLibPlatform] that uses method channels.
class MethodChannelArpLib extends ArpLibPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('arp_lib');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
