//
//  ImageAndTextFieldView.m
//  信鸽Demo
//
//  Created by alan on 17/3/16.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "ImageAndTextFieldView.h"

@interface ImageAndTextFieldView () <UITextFieldDelegate>

@end

@implementation ImageAndTextFieldView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置imageView的宽度为其父view宽度的1/8,高度取当前view的高度
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,  CGRectGetHeight(self.frame)/6, CGRectGetWidth(self.frame)/6, CGRectGetHeight(self.frame)*2/3)];
        // contents scaled to fit with fixed aspect. remainder is transparent
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        // 单机图片时没有响应事件
        _imageView.userInteractionEnabled = NO;
        [self addSubview:_imageView];
        
        _textFiled = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/6, 0, 5*CGRectGetWidth(self.frame)/6, CGRectGetHeight(self.frame))];
        _textFiled.borderStyle = UITextBorderStyleRoundedRect;
        _textFiled.backgroundColor = [UIColor clearColor];
        _textFiled.textAlignment = NSTextAlignmentLeft;
        _textFiled.textColor = [UIColor blackColor];
        _textFiled.returnKeyType = UIReturnKeyDone;
        [self addSubview:_textFiled];
    }
    return self;
}

- (void)setupImageName:(NSString *)imageName textFieldPlaceHolder:(NSString *)placeHolder
{
    _imageView.image = [UIImage imageNamed:imageName];
    _textFiled.placeholder = placeHolder;
}
//
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _textFiled)
    {
        [textField resignFirstResponder];
    }
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
