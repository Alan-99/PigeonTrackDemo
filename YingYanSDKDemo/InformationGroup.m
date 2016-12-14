//
//  InformationGroup.m
//  YingYanSDKDemo
//
//  Created by alan on 16/8/25.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "InformationGroup.h"

@implementation InformationGroup

- (InformationGroup *)initWithName:(NSString *)name andIllustration:(NSString *)illustration andDetails:(NSMutableArray *)details
{
    self = [super init];
    if (self) {
        self.name = name;
        self.illustration = illustration;
        self.details = details;
    }
    return self;
}

+ (InformationGroup *)initWithName:(NSString *)name andIllustration:(NSString *)illustration andDetails:(NSMutableArray *)details
{
    InformationGroup *ifg = [[InformationGroup alloc] initWithName:name andIllustration:illustration andDetails:details];
    return ifg;
}

@end
