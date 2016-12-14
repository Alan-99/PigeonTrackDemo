//
//  EntityNameDataSource.h
//  YingYanSDKDemo
//
//  Created by alan on 16/12/6.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLPAutoCompleteTextFieldDataSource.h"

@interface EntityNameDataSource : NSObject <MLPAutoCompleteTextFieldDataSource>

// Set this to true to return an array of autocomplete objects to the autocomplete textfield instead of strings.
// the objects returned respond to the MLPAutoCompletionObject protocol.

// ARC模式下，assign:成员变量是弱指针，适用于非OC对象类型
@property (assign) BOOL testWithAutoCompleteObjectsInsteadOfStrings;
// set this true to prevent autocomplete terms from returning instantly.
@property (assign) BOOL simulateLatency;

@end
