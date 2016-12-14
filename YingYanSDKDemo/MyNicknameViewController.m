//
//  MyNicknameViewController.m
//  MineTableView
//
//  Created by alan on 16/11/24.
//  Copyright © 2016年 sibet. All rights reserved.
//

#import "MyNicknameViewController.h"
#import "ValueTransferDelegate.h"

@interface MyNicknameViewController () <UITextFieldDelegate>

@end

@implementation MyNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    [self.delegate0 valueTransfer:_nickNameText];
//    [textField resignFirstResponder];
    return YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
