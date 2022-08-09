#ifndef FLUTTER_PLUGIN_ARTEMIS_ZEBRA_PLUGIN_H_
#define FLUTTER_PLUGIN_ARTEMIS_ZEBRA_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace artemis_zebra {

class ArtemisZebraPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  ArtemisZebraPlugin();

  virtual ~ArtemisZebraPlugin();

  // Disallow copy and assign.
  ArtemisZebraPlugin(const ArtemisZebraPlugin&) = delete;
  ArtemisZebraPlugin& operator=(const ArtemisZebraPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace artemis_zebra

#endif  // FLUTTER_PLUGIN_ARTEMIS_ZEBRA_PLUGIN_H_
