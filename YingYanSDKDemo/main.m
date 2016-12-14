//
//  main.m
//  YingYanSDKDemo
//
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


//全局变量
int const serviceId = 125356; //此处填写在鹰眼管理后台创建的服务的ID  郭凯的数据库
NSString *const AK = @"b9TS3wDaWTgFbniDiTUMCXzTHh8LcMph";//此处填写您在API控制台申请得到的ak，该ak必须为iOS类型的ak
NSString *const MCODE = @"sibet.Alan.TraceDemoVer0";//此处填写您申请iOS类型ak时填写的安全码
double const EPSILON = 0.0001;


int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
