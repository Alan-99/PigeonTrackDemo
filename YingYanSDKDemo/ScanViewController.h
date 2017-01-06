//
//  ScanViewController.h
//  YingYanSDKDemo
//
//  Created by alan on 16/10/20.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

// 给ScanViewController定义一个协议
@protocol ScanViewControllerDelegate <NSObject>

- (void)getQRCodeValue:(NSString*)value;

@end

@interface ScanViewController : UIViewController

@property (strong, nonatomic) UITextView* myTextView;

// 此处利用协议给ScanViewController定义代理
@property (nonatomic, unsafe_unretained) id<ScanViewControllerDelegate> delegate2;

@end
