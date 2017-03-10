//
//  PegionDetailViewController.h
//  YingYanSDKDemo
//
//  Created by alan on 16/10/17.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanViewController.h"
#import "AutoCompletionTableView.h"

@class Item;

@protocol PDVCDelegate <NSObject>
- (void)getPegionNumberValue:(NSString*)value;
@end

@interface PegionDetailViewController : UIViewController <UITextFieldDelegate, ScanViewControllerDelegate, AutoCompletionTableViewDelegate>

// <ScanViewControllerDelegate, UITextFieldDelegate，MLPAutoCompleteTextField>

@property (nonatomic, unsafe_unretained) id<PDVCDelegate> delegate;

@property (nonatomic, strong) Item *item;

@property (weak, nonatomic) IBOutlet UITextField *pegionNameField;
@property (weak, nonatomic) IBOutlet UITextField *pegionNumberField;
@property (weak, nonatomic) IBOutlet UITextField *pegionSexField;
@property (weak, nonatomic) IBOutlet UITextField *pegionFurcolorField;
@property (weak, nonatomic) IBOutlet UIButton *qrButton;

- (IBAction)sweepCode:(UIButton *)sender;

@end
