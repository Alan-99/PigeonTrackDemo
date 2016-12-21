//
//  NickNameViewController.h
//  YingYanSDKDemo
//
//  Created by alan on 16/12/2.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "PushClassViewController.h"

typedef void (^ReturnTextBlock)(NSString *text);

@interface NickNameViewController : PushClassViewController

@property (weak, nonatomic) IBOutlet UITextField *nickName;
@property (nonatomic, copy) ReturnTextBlock returnTextBlock;

@end
