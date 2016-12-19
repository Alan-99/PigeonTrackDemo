//
//  Item.m
//  YingYanSDKDemo
//
//  Created by alan on 16/12/19.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "Item.h"

@implementation Item

- (instancetype)initWithItemName:(NSString *)name
                      itemNumber:(NSString *)number
                         itemSex:(NSString *)sex
              itemPigeonFurcolor:(NSString *)furcolor
{
    self = [super init];
    if (self) {
        _pigeonName = name;
        _pigeonNumber = number;
        _pigeonSex = sex;
        _pigeonFurcolor = furcolor;
    }
    return self;
}


@end
