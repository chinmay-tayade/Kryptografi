#import "KryptografiPlugin.h"
#if __has_include(<kryptografi/kryptografi-Swift.h>)
#import <kryptografi/kryptografi-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "kryptografi-Swift.h"
#endif

@implementation KryptografiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftKryptografiPlugin registerWithRegistrar:registrar];
}
@end
