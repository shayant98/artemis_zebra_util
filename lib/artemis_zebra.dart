import 'ZebraPrinter.dart';
import 'artemis_zebra_platform_interface.dart';

class ArtemisZebra {
  Future<String?> getPlatformVersion() {
    return ArtemisZebraPlatform.instance.getPlatformVersion();
  }

  Future<ZebraPrinter> getInstance(
    void Function(String name, String ipAddress, bool isWifi)? onPrinterFound,
    void Function() onPrinterDiscoveryDone,
    void Function(int errorCode, String errorText)? onDiscoveryError,
    void Function(String status, String color)? onChangePrinterStatus,
    void Function() onPermissionDenied,
  ) async {
    String? id = await ArtemisZebraPlatform.instance.getInstance();
    ZebraPrinter printer = ZebraPrinter(
      id!,
      onPrinterFound,
      onPrinterDiscoveryDone,
      onDiscoveryError,
      onChangePrinterStatus,
      onPermissionDenied: onPermissionDenied,
    );
    return printer;
  }
}
