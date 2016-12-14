//
//  PegionDetailViewController.h
//  YingYanSDKDemo
//
//  Created by alan on 16/10/17.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanViewController.h"
#import "MLPAutoCompleteTextField/MLPAutoCompleteTextFieldDelegate.h"

#import "TrackViewController.h"
#import "MarkAnnotation.h"
#import "ScanViewController.h"

@class EntityNameDataSource;
@class MLPAutoCompleteTextField;

@protocol PDVCDelegate <NSObject>
- (void)getPegionNameValue:(NSString*)value;
@end

@interface PegionDetailViewController : UIViewController <UITextFieldDelegate, ScanViewControllerDelegate, MLPAutoCompleteTextFieldDelegate>

// <ScanViewControllerDelegate, UITextFieldDelegate，MLPAutoCompleteTextField>

@property (nonatomic, unsafe_unretained) id<PDVCDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *pegionNameField;
// 用来显示ScanViewController delegate 传过来的值
@property (weak, nonatomic) IBOutlet UITextField *pegionNumberField;
@property (weak, nonatomic) IBOutlet UITextField *pegionSexField;
@property (weak, nonatomic) IBOutlet UITextField *pegionFurcolorField;
@property (weak, nonatomic) IBOutlet UIButton *qrButton;

@property (strong) IBOutlet MLPAutoCompleteTextField *nameTextField;

- (IBAction)sweepCode:(UIButton *)sender;

@end
