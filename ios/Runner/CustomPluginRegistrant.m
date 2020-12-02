//
//  CustomPluginRegistrant.m
//  Runner
//
//  Created by dfg on 2020/12/2.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "CustomPluginRegistrant.h"
#import "Aspects.h"
#import "GloableCookie.h"
#import <webview_flutter/FLTWKNavigationDelegate.h>

@implementation CustomPluginRegistrant
+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
    [GloableCookie registerWithRegistrar:[registry registrarForPlugin:@"GloableCookie"]];
}

+(void)load {
    [FLTWKNavigationDelegate aspect_hookSelector:@selector(webView:didFinishNavigation:)
                                  withOptions:AspectPositionBefore
                                   usingBlock:^(id<AspectInfo> aspectInfo){
        WKWebView *web = (WKWebView *)aspectInfo.arguments.firstObject;
        [web.configuration.websiteDataStore.httpCookieStore getAllCookies:^(NSArray<NSHTTPCookie *> * cookies) {
            NSArray *saveCookienames = @[@"NTES_YD_SESS", @"P_INFO", @"yx_csrf"];
            NSMutableString *cookieStr = @"".mutableCopy;
            for (NSHTTPCookie *cookie in cookies) {
                if ([cookie.domain containsString:@"163.com"] && [saveCookienames containsObject:cookie.name]) {
                    NSString *str = [NSString stringWithFormat:@"%@=%@; ", cookie.name, cookie.value];
                    [cookieStr appendString:str];
                }
            }
            if (saveCookienames.count > 0) {
                NSUserDefaults *stand = [NSUserDefaults standardUserDefaults];
                [stand setValue:cookieStr forKey:@"FlutterUseCookie"];
                [stand synchronize];
            }
        }];
                                        
                                   } error:NULL];

}
@end
