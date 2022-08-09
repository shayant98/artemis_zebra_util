import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'artemis_zebra_method_channel.dart';

abstract class ArtemisZebraPlatform extends PlatformInterface {
  /// Constructs a ArtemisZebraPlatform.
  ArtemisZebraPlatform() : super(token: _token);

  static final Object _token = Object();

  static ArtemisZebraPlatform _instance = MethodChannelArtemisZebra();

  /// The default instance of [ArtemisZebraPlatform] to use.
  ///
  /// Defaults to [MethodChannelArtemisZebra].
  static ArtemisZebraPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ArtemisZebraPlatform] when
  /// they register themselves.
  static set instance(ArtemisZebraPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getInstance() {
    throw UnimplementedError('getInstance() has not been implemented.');
  }
}
