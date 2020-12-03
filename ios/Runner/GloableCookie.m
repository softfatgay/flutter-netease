//
//  GloableCookie.m
//  Runner
//
//  Created by dfg on 2020/12/2.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "GloableCookie.h"

@implementation GloableCookie
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    GloableCookie *instance = [[GloableCookie alloc] init];

  FlutterMethodChannel *channel =
      [FlutterMethodChannel methodChannelWithName:@"plugins.want.flutter.io.GloableCookie"
                                  binaryMessenger:[registrar messenger]];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  if ([[call method] isEqualToString:@"globalCookieValue"]) {
      [self globalCookieValue:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)globalCookieValue:(FlutterResult)result {
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    NSString *cookie = [standard valueForKey:@"FlutterUseCookie"];
    if (cookie.length > 0) {
        result(cookie);
    } else {
        result(@"");
    }
}
@end
