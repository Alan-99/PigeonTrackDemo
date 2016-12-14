//
//  InformationGroup.h
//  YingYanSDKDemo
//
//  Created by alan on 16/8/25.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformationGroup : NSObject

#pragma mark 组名
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *illustration;
@property (nonatomic, strong) NSMutableArray *details;

#pragma mark 带参数的构造函数
- (InformationGroup *)initWithName:(NSString *)name andIllustration:(NSString *)illustration andDetails:(NSMutableArray *)details;
+ (InformationGroup *)initWithName:(NSString *)name andIllustration:(NSString *)illustration andDetails:(NSMutableArray *)details;

@end
