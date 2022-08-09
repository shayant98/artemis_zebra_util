#include "include/artemis_zebra/artemis_zebra_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "artemis_zebra_plugin.h"

void ArtemisZebraPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  artemis_zebra::ArtemisZebraPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
