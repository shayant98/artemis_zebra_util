
import 'dart:developer';

import 'package:flutter/services.dart';

import 'artemis_zebra_platform_interface.dart';
import 'zebra_printer.dart';

class ArtemisZebraUtil {

  ArtemisZebraUtil(){
    ArtemisZebraUtilPlatform.instance.setMethodCallHandler(handler: _methodCallHandler);
  }
  Future<String?> getPlatformVersion() {
    return ArtemisZebraUtilPlatform.instance.getPlatformVersion();
  }

  Future<String?> discoverPrinters() {
    return ArtemisZebraUtilPlatform.instance.discoverPrinters();
  }

  Future<String?> setMethodCallHandler() {
    return ArtemisZebraUtilPlatform.instance.discoverPrinters();
  }

  static Future<ZebraPrinter> getPrinterInstance({String? label,required void Function(ZebraPrinter) notifier}) async {
    return ArtemisZebraUtilPlatform.instance.getZebraPrinterInstance(label:label,notifier:notifier );
  }

  Future<dynamic> _methodCallHandler(MethodCall methodCall) async {


    if (methodCall.method == "printerFound") {
      log("printerFound");
      // String barcode = methodCall.arguments.toString();

    }else if(methodCall.method == "discoveryDone"){
      log("discoveryDone");
      String? ocrJson = await methodCall.arguments;
      if (ocrJson == null) return null;
      try {
        // OcrData ocrData = OcrData.fromJson(jsonDecode(ocrJson));
        // if (widget.onOcrRead == null) {
        //   log("Text ${ocrData.text} Detected but no onOcrRead is not  Implemented");
        // } else {
        //   widget.onOcrRead!(ocrData);
        // }
      } catch (e) {
        return null;
      }
    }

  }

}
