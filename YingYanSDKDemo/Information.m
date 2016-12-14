//
//  Information.m
//  YingYanSDKDemo
//
//  Created by alan on 16/8/25.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "Information.h"

@implementation Information

- (Information *)initWithName:(NSString *)name andDetail:(NSString *)detail
{
    self = [super init];
    if (self) {
        self.name = name;
        self.detail = detail;
    }
    return self;
}

+ (Information *)iniWithName:(NSString *)name andDetail:(NSString *)detail
{
    Information *ifm1 = [[Information alloc] initWithName:name andDetail:detail];
    return ifm1;
}

@end
