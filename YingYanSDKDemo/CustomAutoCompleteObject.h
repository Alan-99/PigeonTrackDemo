//
//  CustomAutoCompleteObject.h
//  YingYanSDKDemo
//
//  Created by alan on 16/12/6.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLPAutoCompleteTextField/MLPAutoCompletionObject.h"

@interface CustomAutoCompleteObject : NSObject <MLPAutoCompletionObject>

- (id)initWithEntityName:(NSString *)name;

@end
