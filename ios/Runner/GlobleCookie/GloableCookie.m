//
//  GloableCookie.m
//  Runner
//
//  Created by dfg on 2020/12/2.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "GloableCookie.h"
#import "Aspects.h"
#import <webview_flutter_wkwebview/FLTWebViewFlutterPlugin.h>

NSString *COOKIESAVEKEY = @"FlutterUseCookie";

@implementation GloableCookie

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    GloableCookie *instance = [[GloableCookie alloc] init];
    [instance aspectMethod];
  FlutterMethodChannel *channel =
      [FlutterMethodChannel methodChannelWithName:@"plugins.want.flutter.io.GloableCookie"
                                  binaryMessenger:[registrar messenger]];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  if ([[call method] isEqualToString:@"globalCookieValue"]) {
      [self globalCookieValue:result];
  } else if ([[call method] isEqualToString:@"clearCookie"]) {
      [self clearGlobalCookieValue:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

#pragma mark - 私有
- (void)globalCookieValue:(FlutterResult)result {
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    NSString *cookie = [standard valueForKey:COOKIESAVEKEY];
    if (cookie.length > 0) {
        result(cookie);
    } else {
        result(@"");
    }
}

- (void)clearGlobalCookieValue:(FlutterResult)result {
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    [standard setValue:nil forKey:COOKIESAVEKEY];
    
    if (@available(iOS 9.0, *)) {
      NSSet<NSString *> *websiteDataTypes = [NSSet setWithObject:WKWebsiteDataTypeCookies];
      WKWebsiteDataStore *dataStore = [WKWebsiteDataStore defaultDataStore];

      void (^deleteAndNotify)(NSArray<WKWebsiteDataRecord *> *) =
          ^(NSArray<WKWebsiteDataRecord *> *cookies) {
            BOOL hasCookies = cookies.count > 0;
            [dataStore removeDataOfTypes:websiteDataTypes
                          forDataRecords:cookies
                       completionHandler:^{
                         result(@(hasCookies));
                       }];
          };

      [dataStore fetchDataRecordsOfTypes:websiteDataTypes completionHandler:deleteAndNotify];
    } else {
      // support for iOS8 tracked in https://github.com/flutter/flutter/issues/27624.
      NSLog(@"Clearing cookies is not supported for Flutter WebViews prior to iOS 9.");
    }
    
    result(@(YES));
}

- (void)aspectMethod {
    void (^webViewOnpageFinish)(id<AspectInfo> aspectInfo) = ^(id<AspectInfo> aspectInfo){
        WKWebView *web = (WKWebView *)aspectInfo.arguments.firstObject;
//        NSArray *saveCookienames = @[@"NTES_YD_SESS", @"P_INFO", @"yx_csrf", @"mail_psc_fingerprint", @"yx_stat_seqList", @"yx_aui", @"yx_but_id", @"S_INFO", @"yx_s_tid", @"yx_sid", @"yx_stat_seqList", @"yx_userid", @"yx_username"];
        [web.configuration.websiteDataStore.httpCookieStore getAllCookies:^(NSArray<NSHTTPCookie *> * cookies) {
            NSMutableString *cookieStr = @"".mutableCopy;
            for (NSHTTPCookie *cookie in cookies) {
                if ([cookie.domain containsString:@"163.com"]) {
                    NSString *str = [NSString stringWithFormat:@"%@=%@; ", cookie.name, cookie.value];
                    [cookieStr appendString:str];
                }
            }
            NSUserDefaults *stand = [NSUserDefaults standardUserDefaults];
            [stand setValue:cookieStr forKey:COOKIESAVEKEY];
            [stand synchronize];
        }];
    };
    [FLTWebViewFlutterPlugin aspect_hookSelector: @selector(webView:didFinishNavigation:)
                                  withOptions: AspectPositionBefore
                                   usingBlock: webViewOnpageFinish
                                    error:NULL];
}

@end
