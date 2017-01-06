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
#import "Item.h"

@interface PegionDetailViewController ()
@property (nonatomic, strong) AutoCompletionTableView *pegionNameAutoCompleter;
@property (nonatomic, strong) AutoCompletionTableView *pegionSexAutoCompleter;
@property (nonatomic, strong) AutoCompletionTableView *pegionFurcolorCompleter;
@property (nonatomic, strong) UIView *tableViewBackView;

@end

@implementation PegionDetailViewController
//
//- (void)inputTextField {
//    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(15, 80, self.view.frame.size.width-30, 40)];
//    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
//    _nameTextField.font = [UIFont fontWithName:@"Century Gothic" size:14.0f];
//    _nameTextField.placeholder = @"EnityName";
//    _nameTextField.delegate = self;
//    [self.view addSubview:self.nameTextField];
//
//}

- (AutoCompletionTableView *)pegionNameAutoCompleter
{
    if (!_pegionNameAutoCompleter) {
        NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:5];
        [options setValue:[NSNumber numberWithBool:YES] forKey:ACOCaseSensitive];
        [options setValue:nil forKey:ACOUseSourceFont];
        
//        _autoCompleter = [[AutoCompletionTableView alloc]initWithTextField:self.nameTextField inViewController:self withOptions:options];

        _pegionNameAutoCompleter = [[AutoCompletionTableView alloc]initWithTextField:self.pegionNameField inViewController:self withOptions:options];
        _pegionNameAutoCompleter.autoCompleteDelegate = self;
        
        //这个阵列与推荐单词无关
        _pegionNameAutoCompleter.suggestionsDictionary = [NSArray arrayWithObjects:
//                                                @"pegion0705",
//                                                @"pegion0720",
//                                                @"haha0910",
//                                                @"haha0911",
//                                                @"haha0912",
//                                                @"haha0913",
//                                                @"haha0914",
//                                                @"haha0915",
//                                                @"haha0916",
//                                                @"haha0917",
//                                                @"haha0918",
//                                                @"haha0919",
//                                                @"haha0920",
//                                                @"haha0921",
//                                                @"haha0922",
//                                                @"haha0923",
//                                                @"haha0924",
//                                                @"haha0925",
//                                                @"haha0926",
//                                                @"haha0927",
//                                                @"haha0928",
//                                                @"haha0929",
//                                                @"haha0930",
//                                                @"haha1001",
//                                                @"haha1002",
//                                                @"haha1003",
//                                                @"haha1004",
//                                                @"haha1005",
//                                                @"haha1006",
//                                                @"haha1007",
//                                                @"haha1008",
//                                                @"haha1009",
//                                                @"201609134",
//                                                @"201609135",
//                                                @"201609136",
//                                                @"201609137",
//                                                @"201609138",
//                                                @"201609139",
//                                                @"201609140",
//                                                @"201609141",
//                                                @"201609142",
//                                                @"201609143",
//                                                @"201609144",
//                                                @"201609145",
//                                                @"201609146",
//                                                @"201609147",
//                                                @"201609148",
//                                                @"201609149",
                                                nil];
    }
    return _pegionNameAutoCompleter;
}

- (AutoCompletionTableView *)pegionSexAutoCompleter
{
    if (!_pegionSexAutoCompleter) {
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:4];
    [options setValue:[NSNumber numberWithBool:YES] forKey:ACOCaseSensitive];
    [options setValue:nil forKey:ACOUseSourceFont];
    
    _pegionSexAutoCompleter = [[AutoCompletionTableView alloc]initWithTextField:self.pegionSexField inViewController:self withOptions:options];
    _pegionSexAutoCompleter.autoCompleteDelegate = self;
    _pegionSexAutoCompleter.suggestionsDictionary = [NSArray arrayWithObjects:@"male", @"female", nil];
    }
    return _pegionSexAutoCompleter;
}

- (AutoCompletionTableView *)pegionFurcolorAutoCompleter
{
    if (!_pegionFurcolorCompleter) {
        NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:3];
        [options setValue:[NSNumber numberWithBool:YES] forKey:ACOCaseSensitive];
        [options setValue:nil forKey:ACOUseSourceFont];
        
        _pegionFurcolorCompleter = [[AutoCompletionTableView alloc]initWithTextField:self.pegionFurcolorField inViewController:self withOptions:options];
        _pegionFurcolorCompleter.autoCompleteDelegate = self;
        _pegionFurcolorCompleter.suggestionsDictionary = [NSArray arrayWithObjects:
                                                          @"red",
                                                          @"white",
                                                          @"gray",
                                                          @"black",
                                                          @"灰色",
                                                          @"白色",
                                                          nil];
    }
    return _pegionSexAutoCompleter;
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
            
            //性别推荐
            @"male",
            @"female",
            @"公",
            @"母",
            //羽色推荐
            @"red",
            @"white",
            @"gray",
            @"black",
            @"灰色",
            @"白色",
            nil];
}

- (void) autoCompletion:(AutoCompletionTableView*) completer didSelectAutoCompleteSuggestionWithIndex:(NSInteger) index{
    // invoked when an available suggestion is selected
    NSLog(@"%@ - Suggestion chosen: %ld", completer, (long)index);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer:tap];
    
//    [self.nameTextField addTarget:self.autoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.pegionNameField addTarget:self.pegionNameAutoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.pegionSexField addTarget:self.pegionSexAutoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.pegionFurcolorField addTarget:self.pegionFurcolorAutoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    // Do any additional setup after loading the view from its nib.
}

- (void)closeKeyboard
{
    [self.view endEditing:YES];
}

- (void)setItem:(Item *)item
{
    _item = item;
    self.navigationItem.title = _item.pigeonName;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Item *i = self.item;
    self.pegionNameField.text = i.pigeonName;
    self.pegionSexField.text = i.pigeonSex;
    self.pegionFurcolorField.text = i.pigeonFurcolor;
    self.pegionNumberField.text = i.pigeonNumber;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    
//    Item *i = self.item;
//    i.pigeonName = self.pegionNameField.text;
//    i.pigeonSex = self.pegionSexField.text;
//    i.pigeonNumber = self.pegionNumberField.text;
//    i.pigeonFurcolor = self.pegionFurcolorField.text;
    self.item.pigeonName = self.pegionNameField.text;
    self.item.pigeonSex = self.pegionSexField.text;
    self.item.pigeonNumber = self.pegionNumberField.text;
    self.item.pigeonFurcolor = self.pegionFurcolorField.text;
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
