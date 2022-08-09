import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'artemis_zebra_platform_interface.dart';

/// An implementation of [ArtemisZebraPlatform] that uses method channels.
class MethodChannelArtemisZebra extends ArtemisZebraPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('artemis_zebra');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> getInstance() async {
    final version = await methodChannel.invokeMethod<String>('getInstance');
    return version;
  }
}
