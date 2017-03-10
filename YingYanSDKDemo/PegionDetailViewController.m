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
#import "Item.h"

@interface PegionDetailViewController ()

@property (nonatomic, strong) AutoCompletionTableView *pegionNameAutoCompleter;
@property (nonatomic, strong) AutoCompletionTableView *pegionNumberAutoCompleter;

// 性别及羽色属性在这里删除了
//@property (nonatomic, strong) AutoCompletionTableView *pegionSexAutoCompleter;
//@property (nonatomic, strong) AutoCompletionTableView *pegionFurcolorCompleter;

@end

@implementation PegionDetailViewController

@synthesize pegionNameField = _pegionNameField;
@synthesize pegionNumberField = _pegionNumberField;
@synthesize pegionSexField = _pegionSexField;
@synthesize pegionFurcolorField = _pegionFurcolorField;

@synthesize pegionNameAutoCompleter = _pegionNameAutoCompleter;
@synthesize pegionNumberAutoCompleter = _pegionNumberAutoCompleter;

//@synthesize pegionSexAutoCompleter = _pegionSexAutoCompleter;
//@synthesize pegionFurcolorCompleter = _pegionFurcolorCompleter;

- (AutoCompletionTableView *)pegionNumberAutoCompleter
{
    if (!_pegionNumberAutoCompleter) {
        NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:2];
        [options setValue:[NSNumber numberWithBool:YES] forKey:ACOCaseSensitive];
        [options setValue:nil forKey:ACOUseSourceFont];
        
        _pegionNumberAutoCompleter = [[AutoCompletionTableView alloc] initWithTextField:self.pegionNumberField inViewController:self withOptions:options];
        _pegionNumberAutoCompleter.autoCompleteDelegate = self;
        
        _pegionNumberAutoCompleter.suggestionsDictionary = [NSArray arrayWithObjects:
                                                            @"1064812500279",
                                                            @"1064812500280",
                                                            @"1064812500281",
                                                            @"1064812500282",
                                                            @"1064812500283",
                                                            @"1064812500284",
                                                            @"1064812500285",
                                                            @"1064812500286",
                                                            @"1064812500287",
                                                            @"1064812500288",
                                                            @"1064812500289",
                                                            @"1064812500290",
                                                            @"1064812500291",
                                                            @"1064812500292",
                                                            @"1064812500293",
                                                            @"1064812500294",
                                                            @"1064812500295",
                                                            @"1064812500296",
                                                            @"1064812500297",
                                                            @"1064812500298",
                                                            @"201611040",
                                                            @"201612040",
                                                            @"201609135",
                                                            @"201609140",
                                                            @"0107",
                                                            nil];
    }
    return _pegionNumberAutoCompleter;
}

- (AutoCompletionTableView *)pegionNameAutoCompleter
{
    if (!_pegionNameAutoCompleter) {
        NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:5];
        [options setValue:[NSNumber numberWithBool:YES] forKey:ACOCaseSensitive];
        [options setValue:nil forKey:ACOUseSourceFont];

        _pegionNameAutoCompleter = [[AutoCompletionTableView alloc]initWithTextField:self.pegionNameField inViewController:self withOptions:options];
        _pegionNameAutoCompleter.autoCompleteDelegate = self;
        
        //这个阵列与推荐单词无关
        _pegionNameAutoCompleter.suggestionsDictionary = [NSArray arrayWithObjects:
                                                @"赤赤",
                                                @"橙橙",
                                                @"蓝蓝",
                                                @"绿绿",
                                                @"青青",
                                                @"蓝蓝",
                                                @"紫紫",
                                                nil];
    }
    return _pegionNameAutoCompleter;
}

//- (AutoCompletionTableView *)pegionSexAutoCompleter
//{
//    if (!_pegionSexAutoCompleter) {
//    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:4];
//    [options setValue:[NSNumber numberWithBool:YES] forKey:ACOCaseSensitive];
//    [options setValue:nil forKey:ACOUseSourceFont];
//    
//    _pegionSexAutoCompleter = [[AutoCompletionTableView alloc]initWithTextField:self.pegionSexField inViewController:self withOptions:options];
//    _pegionSexAutoCompleter.autoCompleteDelegate = self;
//    _pegionSexAutoCompleter.suggestionsDictionary = [NSArray arrayWithObjects:@"male", @"female", nil];
//    }
//    return _pegionSexAutoCompleter;
//}
//
//- (AutoCompletionTableView *)pegionFurcolorAutoCompleter
//{
//    if (!_pegionFurcolorCompleter) {
//        NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:3];
//        [options setValue:[NSNumber numberWithBool:YES] forKey:ACOCaseSensitive];
//        [options setValue:nil forKey:ACOUseSourceFont];
//        
//        _pegionFurcolorCompleter = [[AutoCompletionTableView alloc]initWithTextField:self.pegionFurcolorField inViewController:self withOptions:options];
//        _pegionFurcolorCompleter.autoCompleteDelegate = self;
//        _pegionFurcolorCompleter.suggestionsDictionary = [NSArray arrayWithObjects:
//                                                          @"red",
//                                                          @"white",
//                                                          @"gray",
//                                                          @"black",
//                                                          @"灰色",
//                                                          @"白色",
//                                                          nil];
//    }
//    return _pegionSexAutoCompleter;
//}

#pragma mark - AutoCompleteTableViewDelegate

- (NSArray*) autoCompletion:(AutoCompletionTableView*) completer suggestionsFor:(NSString*) string{
    // with the prodided string, build a new array with suggestions - from DB, from a service, etc.
    // 不同的textField对应不同的推荐值
    if (completer == _pegionNumberAutoCompleter) {
        return [NSArray arrayWithObjects:
                @"1064812500279",
                @"1064812500280",
                @"1064812500281",
                @"1064812500282",
                @"1064812500283",
                @"1064812500284",
                @"1064812500285",
                @"1064812500286",
                @"1064812500287",
                @"1064812500288",
                @"1064812500289",
                @"1064812500290",
                @"1064812500291",
                @"1064812500292",
                @"1064812500293",
                @"1064812500294",
                @"1064812500295",
                @"1064812500296",
                @"1064812500297",
                @"1064812500298",
                @"201611040",
                @"201612040",
                @"0107",
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
    } else if (completer == _pegionNameAutoCompleter) {
        return [NSArray arrayWithObjects:
                @"赤赤",
                @"橙橙",
                @"蓝蓝",
                @"绿绿",
                @"青青",
                @"蓝蓝",
                @"紫紫",
                nil];
    } else {
        return nil  ;
    }
}

- (void) autoCompletion:(AutoCompletionTableView*) completer didSelectAutoCompleteSuggestionWithIndex:(NSInteger) index{
    // invoked when an available suggestion is selected
    NSLog(@"%@ - Suggestion chosen: %ld", completer, index);
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
//    tap.numberOfTapsRequired = 1;
//    tap.numberOfTouchesRequired = 1;
//
//    [self.view addGestureRecognizer:tap];
    
    self.view.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:239.0/255.0 blue:232.0/255.0 alpha:1.0];
    
    _pegionNameField.placeholder = @"请输入待跟踪信鸽名";
    _pegionNameField.returnKeyType = UIReturnKeyDone;
    _pegionNameField.keyboardType = UIKeyboardTypeDefault;
    _pegionNumberField.placeholder = @"请输入待跟踪设备号";
    _pegionNumberField.returnKeyType = UIReturnKeyDone;
    
    [self.pegionNumberField addTarget:self.pegionNumberAutoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.pegionNameField addTarget:self.pegionNameAutoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
//    [self.pegionSexField addTarget:self.pegionSexAutoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
//    [self.pegionFurcolorField addTarget:self.pegionFurcolorAutoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
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
    if (self.pegionNumberField != nil) {
        [self.delegate getPegionNumberValue:_pegionNumberField.text];
    }
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    
    Item *i = self.item;
    i.pigeonName = self.pegionNameField.text;
    i.pigeonSex = self.pegionSexField.text;
    i.pigeonNumber = self.pegionNumberField.text;
    i.pigeonFurcolor = self.pegionFurcolorField.text;
//    self.item.pigeonName = self.pegionNameField.text;
//    self.item.pigeonSex = self.pegionSexField.text;
//    self.item.pigeonNumber = self.pegionNumberField.text;
//    self.item.pigeonFurcolor = self.pegionFurcolorField.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    [self.delegate getPegionNumberValue:_pegionNumberField.text];
//    NSLog(@"鸽名：%@",_pegionNameField.text);
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


- (void)getQRCodeValue:(NSString *)value
{
    self.pegionNumberField.text = value;
    NSLog(@"pegionNumberField");
}

- (IBAction)sweepCode:(UIButton *)sender {
    ScanViewController *svc = [[ScanViewController alloc]init];
    svc.delegate2 = self;
    
    [self.navigationController pushViewController:svc animated:NO];

}


@end
