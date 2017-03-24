//
//  ImageAndTextFieldView.h
//  信鸽Demo
//
//  Created by alan on 17/3/16.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width


@interface ImageAndTextFieldView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITextField *textFiled;

- (void)setupImageName:(NSString *)imageName textFieldPlaceHolder:(NSString *)placeHolder;

@end
