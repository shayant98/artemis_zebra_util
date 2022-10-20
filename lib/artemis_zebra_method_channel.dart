import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'artemis_zebra_platform_interface.dart';
import 'zebra_printer.dart';


/// An implementation of [ArtemisZebraUtilPlatform] that uses method channels.
class MethodChannelArtemisZebraUtil extends ArtemisZebraUtilPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('artemis_zebra');

  @override
  Future<void> setMethodCallHandler({required Future<dynamic> Function(MethodCall call)? handler}) async{
    methodChannel.setMethodCallHandler(handler);
    // final result = await methodChannel.invokeMethod<String>('discoverPrinters');
    // return result;
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> discoverPrinters() async {
    final result = await methodChannel.invokeMethod<String>('discoverPrinters');
    return result;
  }



  @override
  Future<ZebraPrinter> getZebraPrinterInstance({String? label,required void Function(ZebraPrinter) notifier}) async{
    String id = await methodChannel.invokeMethod("getInstance");
    ZebraPrinter printer = ZebraPrinter(id,label:label,notifierFunction: notifier);
    return printer;
  }


}
