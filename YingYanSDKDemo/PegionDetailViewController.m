//
//  PegionDetailViewController.m
//  YingYanSDKDemo
//
//  Created by alan on 16/10/17.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "PegionDetailViewController.h"
#import "ScanViewController.h"

#import "CustomAutoCompleteCellTableViewCell.h"
#import "MLPAutoCompleteTextField.h"
#import <QuartzCore/QuartzCore.h>

@interface PegionDetailViewController ()
@property (nonatomic, strong) UIView *tableViewBackView;
@end

@implementation PegionDetailViewController

- (void)inputTextField {
    self.nameTextField = [[MLPAutoCompleteTextField alloc]initWithFrame:CGRectMake(15, 80, self.view.frame.size.width-30, 40)];
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextField.font = [UIFont fontWithName:@"Century Gothic" size:14.0f];
    _nameTextField.placeholder = @"EnityName";
    _nameTextField.delegate = self;
    [self.view addSubview:self.nameTextField];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self inputTextField];

    
    //You can use custom TableViewCell classes and nibs in the autocomplete tableview if you wish.
    //This is only supported in iOS 6.0, in iOS 5.0 you can set a custom NIB for the cell
    if ([[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending) {
        [self.nameTextField registerAutoCompleteCellClass:[CustomAutoCompleteCellTableViewCell class]
                                           forCellReuseIdentifier:@"CustomCellId"];
    }
    else{
        //Turn off bold effects on iOS 5.0 as they are not supported and will result in an exception
        self.nameTextField.applyBoldEffectToAutoCompleteSuggestions = NO;
    }
    
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

#pragma mark - MLPAutoCompleteTextField Delegate
- (BOOL)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
          shouldConfigureCell:(UITableViewCell *)cell
       withAutoCompleteString:(NSString *)autocompleteString
         withAttributedString:(NSAttributedString *)boldedString
        forAutoCompleteObject:(id<MLPAutoCompletionObject>)autocompleteObject
            forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //This is your chance to customize an autocomplete tableview cell before it appears in the autocomplete tableview
    NSString *filename = [autocompleteString stringByAppendingString:@".png"];
    filename = [filename stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    filename = [filename stringByReplacingOccurrencesOfString:@"&" withString:@"and"];
    [cell.imageView setImage:[UIImage imageNamed:filename]];
    
    return YES;
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField didSelectAutoCompleteString:(NSString *)selectedString withAutoCompleteObject:(id<MLPAutoCompletionObject>)selectedObject forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(selectedObject) {
        NSLog(@"selected object from autocomplete menu %@ with string %@",selectedObject, [selectedObject autocompleteString]);
    } else {
        NSLog(@"selected string '%@' from autocomplete menu", selectedString);
    }
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField willHideAutoCompleteTableView:(UITableView *)autoCompleteTableView {
    NSLog(@"Autocomplete table view will be removed from the view hierarchy");
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField willShowAutoCompleteTableView:(UITableView *)autoCompleteTableView {
    NSLog(@"Autocomplete table view will be added to the view hierarchy");
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField didHideAutoCompleteTableView:(UITableView *)autoCompleteTableView {
    NSLog(@"Autocomplete table view ws removed from the view hierarchy");
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField didShowAutoCompleteTableView:(UITableView *)autoCompleteTableView {
    NSLog(@"Autocomplete table view was added to the view hierarchy");
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
