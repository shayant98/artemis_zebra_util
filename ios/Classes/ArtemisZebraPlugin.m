#import "ArtemisZebraPlugin.h"
#if __has_include(<artemis_zebra/artemis_zebra-Swift.h>)
#import <artemis_zebra/artemis_zebra-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "artemis_zebra-Swift.h"
#endif

@implementation ArtemisZebraPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftArtemisZebraPlugin registerWithRegistrar:registrar];
}
@end
