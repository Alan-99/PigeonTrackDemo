//
//  PegionDetailViewController.m
//  YingYanSDKDemo
//
//  Created by alan on 16/10/17.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "PegionDetailViewController.h"
#import "ScanViewController.h"

#import "AutoCompletionTableView.h"

#import <QuartzCore/QuartzCore.h>

@interface PegionDetailViewController ()
@property (nonatomic, strong) AutoCompletionTableView *autoCompleter;
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

- (AutoCompletionTableView *)autoCompleter
{
    if (!_autoCompleter) {
        NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:2];
        [options setValue:[NSNumber numberWithBool:YES] forKey:ACOCaseSensitive];
        [options setValue:nil forKey:ACOUseSourceFont];
        
        _autoCompleter = [[AutoCompletionTableView alloc]initWithTextField:self.nameTextField inViewController:self withOptions:options];
        _autoCompleter.autoCompleteDelegate = self;
        _autoCompleter.suggestionsDictionary = [NSArray arrayWithObjects:
                                                @"pegion0705",
                                                @"pegion0720",
                                                @"haha0910",
                                                @"haha0911",
                                                @"haha0912",
                                                @"haha0913",
                                                @"haha0914",
                                                @"haha0915",
                                                @"haha0916",
                                                @"haha0917",
                                                @"haha0918",
                                                @"haha0919",
                                                @"haha0920",
                                                @"haha0921",
                                                @"haha0922",
                                                @"haha0923",
                                                @"haha0924",
                                                @"haha0925",
                                                @"haha0926",
                                                @"haha0927",
                                                @"haha0928",
                                                @"haha0929",
                                                @"haha0930",
                                                @"haha1001",
                                                @"haha1002",
                                                @"haha1003",
                                                @"haha1004",
                                                @"haha1005",
                                                @"haha1006",
                                                @"haha1007",
                                                @"haha1008",
                                                @"haha1009",
                                                @"201609134",
                                                @"201609135",
                                                @"201609136",
                                                @"201609137",
                                                @"201609138",
                                                @"201609139",
                                                @"201609140",
                                                @"201609141",
                                                @"201609142",
                                                @"201609143",
                                                @"201609144",
                                                @"201609145",
                                                @"201609146",
                                                @"201609147",
                                                @"201609148",
                                                @"201609149",
                                                nil];
    }
    return _autoCompleter;
}

#pragma mark - AutoCompleteTableViewDelegate

- (NSArray*) autoCompletion:(AutoCompletionTableView*) completer suggestionsFor:(NSString*) string{
    // with the prodided string, build a new array with suggestions - from DB, from a service, etc.
    return [NSArray arrayWithObjects:
            @"pegion0705",
            @"pegion0720",
            @"haha0910",
            @"haha0911",
            @"haha0912",
            @"haha0913",
            @"haha0914",
            @"haha0915",
            @"haha0916",
            @"haha0917",
            @"haha0918",
            @"haha0919",
            @"haha0920",
            @"haha0921",
            @"haha0922",
            @"haha0923",
            @"haha0924",
            @"haha0925",
            @"haha0926",
            @"haha0927",
            @"haha0928",
            @"haha0929",
            @"haha0930",
            @"haha1001",
            @"haha1002",
            @"haha1003",
            @"haha1004",
            @"haha1005",
            @"haha1006",
            @"haha1007",
            @"haha1008",
            @"haha1009",
            @"201609134",
            @"201609135",
            @"201609136",
            @"201609137",
            @"201609138",
            @"201609139",
            @"201609140",
            @"201609141",
            @"201609142",
            @"201609143",
            @"201609144",
            @"201609145",
            @"201609146",
            @"201609147",
            @"201609148",
            @"201609149",
            nil];
}

- (void) autoCompletion:(AutoCompletionTableView*) completer didSelectAutoCompleteSuggestionWithIndex:(NSInteger) index{
    // invoked when an available suggestion is selected
    NSLog(@"%@ - Suggestion chosen: %ld", completer, (long)index);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self inputTextField];
    [self.nameTextField addTarget:self.autoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];

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
