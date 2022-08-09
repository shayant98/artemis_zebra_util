// import 'package:flutter_test/flutter_test.dart';
// import 'package:artemis_zebra/artemis_zebra.dart';
// import 'package:artemis_zebra/artemis_zebra_platform_interface.dart';
// import 'package:artemis_zebra/artemis_zebra_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockArtemisZebraPlatform
//     with MockPlatformInterfaceMixin
//     implements ArtemisZebraPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final ArtemisZebraPlatform initialPlatform = ArtemisZebraPlatform.instance;
//
//   test('$MethodChannelArtemisZebra is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelArtemisZebra>());
//   });
//
//   test('getPlatformVersion', () async {
//     ArtemisZebra artemisZebraPlugin = ArtemisZebra();
//     MockArtemisZebraPlatform fakePlatform = MockArtemisZebraPlatform();
//     ArtemisZebraPlatform.instance = fakePlatform;
//
//     expect(await artemisZebraPlugin.getPlatformVersion(), '42');
//   });
// }
