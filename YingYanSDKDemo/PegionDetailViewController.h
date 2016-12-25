//
//  PegionDetailViewController.h
//  YingYanSDKDemo
//
//  Created by alan on 16/10/17.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanViewController.h"

@class Item;

@protocol AutoCompletionTableViewDelegate;

@protocol PDVCDelegate <NSObject>
- (void)getPegionNameValue:(NSString*)value;
@end

@interface PegionDetailViewController : UIViewController <UITextFieldDelegate, AutoCompletionTableViewDelegate>

// <ScanViewControllerDelegate, UITextFieldDelegate，MLPAutoCompleteTextField>

@property (nonatomic, unsafe_unretained) id<PDVCDelegate> delegate;

@property (nonatomic, strong) Item *item;

@property (weak, nonatomic) IBOutlet UITextField *pegionNameField;
// 用来显示ScanViewController delegate 传过来的值
@property (weak, nonatomic) IBOutlet UITextField *pegionNumberField;
@property (weak, nonatomic) IBOutlet UITextField *pegionSexField;
@property (weak, nonatomic) IBOutlet UITextField *pegionFurcolorField;
@property (weak, nonatomic) IBOutlet UIButton *qrButton;

// @property (strong, nonatomic) IBOutlet UITextField *nameTextField;

- (IBAction)sweepCode:(UIButton *)sender;

@end
