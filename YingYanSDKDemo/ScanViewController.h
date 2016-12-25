//
//  ScanViewController.h
//  YingYanSDKDemo
//
//  Created by alan on 16/10/20.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnQRCode)(NSString *qrCode);

@interface ScanViewController : UIViewController

@property (strong, nonatomic) UITextView* myTextView;

@property (nonatomic, copy) ReturnQRCode returnQRCode;
//@property NSString *QR_Code;

@end
