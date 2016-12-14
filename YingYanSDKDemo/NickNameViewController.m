//
//  NickNameViewController.m
//  YingYanSDKDemo
//
//  Created by alan on 16/12/2.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "NickNameViewController.h"

@interface NickNameViewController ()

@end

@implementation NickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    // 取消当前的第一响应对象
//    [self.view endEditing:YES];
//    self.detail = self.nickName.text;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.nickName.text = self.detail;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
