//
//  PegionDetailViewController.m
//  YingYanSDKDemo
//
//  Created by alan on 16/10/17.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "PegionDetailViewController.h"
#import "ScanViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface PegionDetailViewController ()
@property (nonatomic, strong) UIView *tableViewBackView;
@end

@implementation PegionDetailViewController

- (void)inputTextField {
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(15, 80, self.view.frame.size.width-30, 40)];
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextField.font = [UIFont fontWithName:@"Century Gothic" size:14.0f];
    _nameTextField.placeholder = @"EnityName";
    _nameTextField.delegate = self;
    [self.view addSubview:self.nameTextField];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self inputTextField];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view setAlpha:0];
    [UIView animateWithDuration:0.2
                          delay:0.25
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{[self.view setAlpha:1.0];}
                     completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.delegate getPegionNameValue:_pegionNameField.text];
    NSLog(@"鸽名：%@",_pegionNameField.text);
    [textField resignFirstResponder];

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

- (IBAction)sweepCode:(UIButton *)sender {
    ScanViewController *svc = [[ScanViewController alloc]init];
    svc.delegate2 = self;
    
    [self.navigationController pushViewController:svc animated:NO];

}

- (void)getQRCodeValue:(NSString *)value
{
    self.pegionNumberField.text = value;
}

@end
