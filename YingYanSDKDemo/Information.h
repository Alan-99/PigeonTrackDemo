//
//  Information.h
//  YingYanSDKDemo
//
//  Created by alan on 16/8/25.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Information : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *detail;

#pragma mark 带参数的构造函数
- (Information *)initWithName:(NSString *)name andDetail:(NSString *)detail;
#pragma mark 带参数的静态对象初始化方法
+ (Information *)iniWithName:(NSString *)name andDetail:(NSString *)detail;

@end
