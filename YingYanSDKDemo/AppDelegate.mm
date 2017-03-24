//
//  AppDelegate.m
//  YingYanSDKDemo
//
//  Copyright © 2015 Baidu. All rights reserved.
//

#import "AppDelegate.h"
#import <BaiduTraceSDK/BaiduTraceSDK-Swift.h>
#import "TrackViewController.h"
#import "InquiryViewController.h"
#import "CommunityViewController.h"
#import "MineTableViewController.h"

#import "ScanViewController.h"

#import "PegionDetailViewController.h"

#import "SignUpLogInViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

int const serviceID = 125357;
NSString *entityName;
NSString *const AK = @"b9TS3wDaWTgFbniDiTUMCXzTHh8LcMph";
NSString *const MCODE = @"sibet.Alan.TraceDemoVer0";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    
    // 使用鹰眼SDK第一步必须先实例化BTRACE对象
    TrackViewController *tvc1 = [[TrackViewController alloc]init];
    entityName = tvc1.entityNameTextField.text;
    
    BTRACE * traceInstance = [[BTRACE alloc] initWithAk:AK mcode:MCODE serviceId:serviceID entityName:entityName operationMode:2];
    //开始追踪，异步执行
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
        [[BTRACEAction shared] startTrace:(id<ApplicationServiceDelegate>)self trace:traceInstance];
    });
    // 结束轨迹追踪
    [[BTRACEAction shared] stopTrace:(id<ApplicationServiceDelegate>)self trace:traceInstance];
    
    BOOL ret = [_mapManager start:AK generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{

    });
    
    _tabBarController = [[UITabBarController alloc] init];
//    _tabBarController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tabBarController"];
    UINavigationController *tvcNav = [[UINavigationController alloc] initWithRootViewController:[[TrackViewController alloc]init]];
    UINavigationController *ivcNav = [[UINavigationController alloc] initWithRootViewController:[[InquiryViewController alloc]init]];
    UINavigationController *mtvcNvc = [[UINavigationController alloc] initWithRootViewController:[[MineTableViewController alloc]init]];
    UINavigationController *cvcNav = [[UINavigationController alloc] initWithRootViewController:[[CommunityViewController alloc] init]];
    
    _tabBarController.viewControllers = @[tvcNav,ivcNav,cvcNav,mtvcNvc];
    
//    PegionDetailViewController *pdvc = [[PegionDetailViewController alloc]init];
//    self.window.rootViewController = pdvc;
    
//    ScanViewController *svc = [[ScanViewController alloc]init];
//    self.window.rootViewController = svc;
    SignUpLogInViewController *sulivc = [[SignUpLogInViewController alloc]init];
//    self.window.rootViewController = sulivc;
    self.window.rootViewController = _tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)onStartTrace:(NSInteger)errNo errMsg:(NSString *)errMsg
{
    NSLog(@"%@ === %ld", errMsg, (long)errNo);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

@end
