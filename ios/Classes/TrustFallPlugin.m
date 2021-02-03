#import "TrustFallPlugin.h"
#import <DTTJailbreakDetection/DTTJailbreakDetection.h>

@implementation TrustFallPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"trust_fall"
            binaryMessenger:[registrar messenger]];
  TrustFallPlugin* instance = [[TrustFallPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if ([@"isJailBroken" isEqualToString:call.method]) {
    result([NSNumber numberWithBool:[self isJailBroken]]);
  }else if ([@"isRealDevice" isEqualToString:call.method]) {
    result([NSNumber numberWithBool:[self isRealDevice]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (BOOL)isJailBroken{
//    return [self checkPaths] || [self checkSchemes] || [self canViolateSandbox];
    return [DTTJailbreakDetection isJailbroken];
}

- (BOOL) isRealDevice{
    return !TARGET_OS_SIMULATOR;
}

@end
