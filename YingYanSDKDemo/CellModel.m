//
//  CellModel.m
//  YingYanSDKDemo
//
//  Created by alan on 16/11/30.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel

+ (instancetype)cellModelWithTitle:(NSString *)title detail:(NSString *)detail
{
    CellModel *cellModel = [[CellModel alloc]init];
    cellModel.title = title;
    cellModel.detail = detail;
    return cellModel;
}

+ (instancetype)cellModelWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle detail:(NSString *)detail
{
    CellModel *cellModel = [[CellModel alloc]init];
    cellModel.image = image;
    cellModel.title = title;
    cellModel.subtitle = subtitle;
    cellModel.detail = detail;
    return cellModel;
}

@end
