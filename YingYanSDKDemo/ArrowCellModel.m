//
//  ArrowCellModel.m
//  YingYanSDKDemo
//
//  Created by alan on 16/12/1.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "ArrowCellModel.h"
#import "PushClassViewController.h"

@implementation ArrowCellModel

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.detail = self.pushClass->detail;
//    }
//    return self;
//}

+ (instancetype)arrowCellModelWithTitle:(NSString *)title pushClass:(Class)pushClass
{
    //    ArrowCellModel *arrowCellModel = [ArrowCellModel cellModelWithTitle:title detail:detail];
    ArrowCellModel *arrowCellModel = [[ArrowCellModel alloc]init];
    arrowCellModel.title = title;
    arrowCellModel.pushClass = pushClass;
    
    return arrowCellModel;
}

+ (instancetype)arrowCellModelWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle detail:(NSString *)detail pushClass:(Class)pushClass
{
    ArrowCellModel *arrowCellModel = [ArrowCellModel cellModelWithImage:image title:title subtitle:subtitle detail:detail];
    arrowCellModel.pushClass = pushClass;
    return arrowCellModel;
}

@end
