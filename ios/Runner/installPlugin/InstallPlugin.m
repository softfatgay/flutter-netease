#import "InstallPlugin.h"
#import "Runner-Swift.h"

@implementation InstallPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftInstallPlugin registerWithRegistrar:registrar];
}
@end
