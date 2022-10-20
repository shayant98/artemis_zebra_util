//
//  Printer.swift
//  Runner
//
//  Created by faranegar on 6/21/20.
//

import Foundation


class Printer{
    
    var connection : ZebraPrinterConnection?
    var channel : FlutterMethodChannel?
    var selectedIPAddress: String? = nil
    var selectedMacAddress: String? = nil
    var isZebraPrinter :Bool = true
    var wifiManager: POSWIFIManager?
    var isConnecting :Bool = false
    
    static func getInstance(binaryMessenger : FlutterBinaryMessenger) -> Printer {
        let printer = Printer()
        printer.setMethodChannel(binaryMessenger: binaryMessenger)
        return printer
    }
    
    func setMethodChannel(binaryMessenger : FlutterBinaryMessenger) {
        self.channel = FlutterMethodChannel(name: "ZebraPrinterInstance" + toString(), binaryMessenger: binaryMessenger)
        self.channel?.setMethodCallHandler({(call,  result) in
            let args = call.arguments
            let myArgs = args as? [String: Any]
            switch call.method {
            case "discoverPrinters":
                self.discoverPrinters(result: result);
                break
                
            case "connectToPrinter":
                let address = (myArgs?["address"] as! String)
                self.connectToPrinter(address: address,result: result);
                break
                
            case "printData":
                let data = (myArgs?["data"] as! NSString)
                self.printData(data: data ,result: result);
                break
                
            case "disconnectPrinter":
                self.disconnect(result: result)
                break
                
            case "isPrinterConnected":
                self.isPrinterConnect(result: result)
                break
            default:
                result("Unimplemented Method")
            }
        })
    }
    
    //Send dummy to get user permission for local network
    func dummyConnect(){
        let connection = TcpPrinterConnection(address: "0.0.0.0", andWithPort: 9100)
        connection?.open()
        connection?.close()
    }
    
    func discoverPrinters(result: @escaping FlutterResult){
        dummyConnect()
        let manager = EAAccessoryManager.shared()
        let devices = manager.connectedAccessories
        for d in devices {
            print("Message from ios: orinter found")
            let data: [String: Any] = [
                "name": d.name,
                "address": d.serialNumber,
                "type": 1
            ]
            self.channel?.invokeMethod("printerFound", arguments: data)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            result("Discovery Done Devices Found: "+String(devices.count))
        }
    }
    
    

    
    func connectToGenericPrinter(address: String,result: @escaping FlutterResult) {
        self.isZebraPrinter = false
        if self.wifiManager != nil{
            self.wifiManager?.posDisConnect()
        }
        self.wifiManager = POSWIFIManager()
        self.wifiManager?.posConnect(withHost: address, port: 9100, completion: { (r) in
            if r == true {
                result(true)
            } else {
                result(false)
            }
        })
    }
    
    func connectToPrinter(address: String,result: @escaping FlutterResult){
        if(self.isConnecting == false) {
            self.isConnecting = true
            self.isZebraPrinter = true
            selectedIPAddress = nil
            if(self.connection != nil){
                self.connection?.close()
            }
            if(!address.contains(".")){
                self.connection = MfiBtPrinterConnection(serialNumber: address)
            }else {
                self.connection = TcpPrinterConnection(address: address, andWithPort: 9100)
            }
            Thread.sleep(forTimeInterval: 1)
            let isOpen = self.connection?.open()
            self.isConnecting = false
            if isOpen == true {
                Thread.sleep(forTimeInterval: 1)
                self.selectedIPAddress = address
                result(true)
            } else {
                result(false)
            }
        }
    }
    
    func isPrinterConnect(result: @escaping FlutterResult){
        if self.isZebraPrinter == true {
            if self.connection?.isConnected() == true {
                result(true)
            }
            else {
                result(false)
            }
        } else {
            if(self.wifiManager?.connectOK == true){
                result(true)
            } else {
                result(false)
            }
        }
    }
    
    
    func disconnect(result: FlutterResult?) {
        if self.isZebraPrinter == true {
            if self.connection != nil {
                self.connection?.close()
            }
            self.channel?.invokeMethod("connectionLost",arguments: nil);
            result?(true)
        } else {
            if self.wifiManager != nil{
                self.wifiManager?.posDisConnect()
            }
            self.channel?.invokeMethod("connectionLost",arguments: nil);
            result?(true)
        }
    }
    
    func printData(data: NSString, result: @escaping FlutterResult) {
        DispatchQueue.global(qos: .utility).async {
            let dataBytes = Data(bytes: data.utf8String!, count: data.length)
            if self.isZebraPrinter == true {
                var error: NSError?
                let r = self.connection?.write(dataBytes, error: &error)
                if r == -1, let error = error {
                    print(error)
                    result(false)
                    self.disconnect(result: nil)
                    
                    return
                }
            } else {
                self.wifiManager?.posWriteCommand(with: dataBytes, withResponse: { (result) in
                    
                })
            }
            sleep(1)
            DispatchQueue.main.async {
                result(true)
            }
        }
    }
    
    
    func toString() -> String{
        return String(UInt(bitPattern: ObjectIdentifier(self)))
    }
}
