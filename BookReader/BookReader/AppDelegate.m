//
//  AppDelegate.m
//  BookReader
//
//  Created by joe on 2017/5/17.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BRMainTabBarController.h"
#import "HTTPServer.h"
#import "MyHTTPConnection.h"
#import "BRIPHelper.h"
@interface AppDelegate () {
    HTTPServer *httpServer;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:kMainScreenBounds];
    
    window.backgroundColor = [UIColor whiteColor];
    
    BRMainTabBarController *tabVc = [[BRMainTabBarController alloc] init];
    
    window.rootViewController = tabVc;
    
    [window makeKeyAndVisible];
    
    self.window = window;
    
    
//    httpServer = [[HTTPServer alloc] init];
//    [httpServer setType:@"_http._tcp."];
//     [httpServer setPort:12345];
    NSString * webLocalPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
//    [httpServer setDocumentRoot:webLocalPath];
//    
//    NSLog(@"Setting document root: %@", webLocalPath);
//    
//    NSError * error;
//    if([httpServer start:&error])
//    {
//        NSLog(@"start server success in port %d %@",[httpServer listeningPort],[httpServer publishedName]);
//        
//    }
//    else
//    {
//        NSLog(@"启动失败");
//    }
    httpServer = [[HTTPServer alloc] init];
    [httpServer setType:@"_http._tcp."];
    // webPath是server搜寻HTML等文件的路径
    [httpServer setDocumentRoot:webLocalPath];
    [httpServer setConnectionClass:[MyHTTPConnection class]];
    NSError *err;
    if ([httpServer start:&err]) {
        NSLog(@"port %hu",[httpServer listeningPort]);
    }else{
        NSLog(@"%@",err);
    }
    
    NSString *ip = [BRIPHelper deviceIPAdress];
    NSLog(@"ipipip = %@", ip);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIScreen mainScreen] setBrightness:0.5];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
