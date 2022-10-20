import Flutter
import UIKit

public class SwiftArtemisZebraPlugin: NSObject, FlutterPlugin {
    
    var printers = [Printer]()
    var binaryMessenger: FlutterBinaryMessenger?
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "artemis_zebra", binaryMessenger: registrar.messenger())
        let instance = SwiftArtemisZebraPlugin()
        instance.binaryMessenger = registrar.messenger()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getInstance":
            getInstance(result: result);
            break
        default:
            result("Unimplemented Method")
        }
    }
    
    public func getInstance( result: @escaping FlutterResult){
        let printer = Printer.getInstance(binaryMessenger: self.binaryMessenger!)
        printers.append(printer)
        result(printer.toString())
    }
    
    

}


