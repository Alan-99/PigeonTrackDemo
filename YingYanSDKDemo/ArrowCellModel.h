//
//  ArrowCellModel.h
//  YingYanSDKDemo
//
//  Created by alan on 16/12/1.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "CellModel.h"

@interface ArrowCellModel : CellModel

@property (nonatomic, assign) Class pushClass;

+ (instancetype)arrowCellModelWithTitle:(NSString *)title pushClass:(Class)pushClass;

+ (instancetype)arrowCellModelWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle detail:(NSString *)detail pushClass:(Class)pushClass;

@end
