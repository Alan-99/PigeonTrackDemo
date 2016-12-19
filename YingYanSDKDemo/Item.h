//
//  Item.h
//  YingYanSDKDemo
//
//  Created by alan on 16/12/19.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property NSString *pigeonName;
@property NSString *pigeonNumber;
@property NSString *pigeonSex;
@property NSString *pigeonFurcolor;

- (instancetype)initWithItemName:(NSString *)name
                      itemNumber:(NSString *)number
                         itemSex:(NSString *)sex
              itemPigeonFurcolor:(NSString *)furcolor;

@end
