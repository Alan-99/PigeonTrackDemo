//
//  CellModel.h
//  YingYanSDKDemo
//
//  Created by alan on 16/11/30.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^Block)();

@interface CellModel : NSObject

@property (nonatomic, strong)UIImage *image;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *subtitle;
@property (nonatomic, strong)NSString *detail;

+ (instancetype)cellModelWithTitle:(NSString *)title detail:(NSString *)detail;

+ (instancetype)cellModelWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle detail:(NSString *)detail;

@end
