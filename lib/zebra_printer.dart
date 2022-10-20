import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';

import 'zebra_printer_interface.dart';

class ZebraPrinter implements ArtemisZebraPrinterInterface {
  late MethodChannel channel;
  late String instanceID;
  late void Function(ZebraPrinter) notifier;
  ZebraPrinter(String id,{String? label, required void Function(ZebraPrinter) notifierFunction}) {
    channel = MethodChannel('ZebraPrinterInstance$id');
    log("ZebraPrinterInstanceCreated: $id  (${label??id})");
    instanceID =label==null? id:"$id ($label)";
    notifier = notifierFunction;
    channel.setMethodCallHandler(_printerMethodCallHandler);
  }

  PrinterStatus status = PrinterStatus.disconnected;
  List<FoundPrinter> foundPrinters = [];


  @override
  discoverPrinters()async{
    status = PrinterStatus.discoveringPrinter;
    notifier(this);
    String result = await channel.invokeMethod("discoverPrinters");
    status = PrinterStatus.disconnected;
    notifier(this);
    return result;
  }

  @override
  Future<bool> connectToPrinter(String address) async{
    status = PrinterStatus.connecting;
    notifier(this);
    final bool result = await channel.invokeMethod("connectToPrinter",{"address":address});
    if(result){
      status = PrinterStatus.ready;
      log("Zebra Instance $instanceID Connected to $address");
    }else{
      status = PrinterStatus.disconnected;
    }
    notifier(this);
    return result;
  }

  @override
  Future<bool> printData(String data)async {
    status = PrinterStatus.printing;
    notifier(this);
    final bool result = await channel.invokeMethod("printData",{"data":data});
    if(result){
      status = PrinterStatus.ready;
      log("Zebra Instance $instanceID Print Done");
    }else{
      status = PrinterStatus.disconnected;
    }
    notifier(this);
    return result;
  }

  @override
  Future<bool> disconnectPrinter()async {
    status = PrinterStatus.disconnecting;
    notifier(this);
    final bool result = await channel.invokeMethod("disconnectPrinter");
    status = PrinterStatus.disconnected;
    notifier(this);
    return result;
  }

  @override
  Future<bool> isPrinterConnected()async {
    final bool result = await channel.invokeMethod("isPrinterConnected");
    if(!result){
      status = PrinterStatus.disconnected;
      notifier(this);
    }
    return result;
  }


  Future<dynamic> _printerMethodCallHandler(MethodCall methodCall) async {

    if (methodCall.method == "printerFound") {
      log("printerFound");
      String? ocrJson = await methodCall.arguments;
      if (ocrJson == null) return null;
      try {
        FoundPrinter foundPrinter = FoundPrinter.fromJson(jsonDecode(ocrJson));
        foundPrinters.add(foundPrinter);
        notifier(this);
      } catch (e) {
        return null;
      }

    }else if(methodCall.method == "discoveryDone"){
      log("discoveryDone");
    }else if(methodCall.method == "connectionLost"){
      status = PrinterStatus.disconnected;
      notifier(this);
      log("printerDisconnected");
    }

  }


}