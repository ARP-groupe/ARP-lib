import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'arp_lib_method_channel.dart';

abstract class ArpLibPlatform extends PlatformInterface {
  /// Constructs a ArpLibPlatform.
  ArpLibPlatform() : super(token: _token);

  static final Object _token = Object();

  static ArpLibPlatform _instance = MethodChannelArpLib();

  /// The default instance of [ArpLibPlatform] to use.
  ///
  /// Defaults to [MethodChannelArpLib].
  static ArpLibPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ArpLibPlatform] when
  /// they register themselves.
  static set instance(ArpLibPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
