//
//  CustomAutoCompleteObject.m
//  YingYanSDKDemo
//
//  Created by alan on 16/12/6.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "CustomAutoCompleteObject.h"

@interface CustomAutoCompleteObject ()

@property (strong) NSString *entityName;

@end

@implementation CustomAutoCompleteObject

- (id)initWithEntityName:(NSString *)name
{
    self = [super init];
    if (self) {
        [self setEntityName:name];
    }
    return self;
}

#pragma mark - MLPAutoCompletionObject Protocol

- (NSString *)autocompleteString
{
    return self.entityName;
}

@end
