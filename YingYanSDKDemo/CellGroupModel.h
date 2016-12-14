//
//  CellGroupModel.h
//  YingYanSDKDemo
//
//  Created by alan on 16/12/1.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellGroupModel : NSObject

@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *footer;
@property (nonatomic, strong) NSArray *section;

@end
