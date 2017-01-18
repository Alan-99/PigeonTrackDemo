//
//  AutoCompletionTableView.m
//  YingYanSDKDemo
//
//  Created by alan on 16/12/14.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "AutoCompletionTableView.h"

@interface AutoCompletionTableView ()

@property (nonatomic, strong) NSArray *suggestionOptions; // of selected NSStrings
@property (nonatomic, strong) UITextField *textField; // will set automatically as user enters text
@property (nonatomic, strong) UIFont *cellLabelFont; // will copy style from assigned textfield

@end

@implementation AutoCompletionTableView

@synthesize suggestionsDictionary = _suggestionsDictionary;
@synthesize suggestionOptions = _suggestionOptions;
@synthesize textField = _textField;
@synthesize cellLabelFont = _cellLabelFont;
@synthesize options = _options;

#pragma mark - Initialization
- (UITableView *)initWithTextField:(UITextField *)textField inViewController:(UIViewController *)parentViewController withOptions:(NSDictionary *)options
{
    self.options = options;
    // frame must aligh to the textField
    // 240:改变整个table的高度？
    CGRect frame = CGRectMake(textField.frame.origin.x, CGRectGetMaxY(textField.frame), textField.frame.size.width, 240);
//
//    CGRect frame = CGRectMake(textField.frame.origin.x, textField.frame.origin.y+textField.frame.size.height, textField.frame.size.width, 120);
    // save the font info to reuse in cells
    self.cellLabelFont = textField.font;
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    
    self.delegate = self;
    self.dataSource = self;
    self.scrollEnabled = YES;
    // turn off standard correctin
    textField.autocorrectionType = UITextAutocorrectionTypeNo; // 关闭系统自动联想
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone; //关闭首字母大写
    
    
    // to get rid of "extra empty cell" on the bottom
    // when there's only one cell in the table
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textField.frame.size.width, 1)];
    v.backgroundColor = [UIColor grayColor];
    [self setTableFooterView:v];
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textField.frame.size.width, 5)];
    v1.backgroundColor = [UIColor grayColor];
    [self setTableHeaderView:v1];
    self.hidden = YES;
    [parentViewController.view addSubview:self];
    
    return self;
}

#pragma mark - logic staff
- (BOOL)substringIsInDictionary:(NSString *)subString
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    NSRange range;
    
    if (_autoCompleteDelegate && [_autoCompleteDelegate respondsToSelector:@selector(autoCompletion:suggestionsFor:)]) {
        self.suggestionsDictionary = [_autoCompleteDelegate autoCompletion:self suggestionsFor:subString];
    }
    
    for (NSString *tmpString in self.suggestionsDictionary)
    {
        range = ([[self.options valueForKey:ACOCaseSensitive] isEqualToNumber:[NSNumber numberWithInt:1]]) ? [tmpString rangeOfString:subString] : [tmpString rangeOfString:subString options:NSCaseInsensitiveSearch];
        if (range.location != NSNotFound) [tmpArray addObject:tmpString];
    }
    if ([tmpArray count]>0)
    {
        self.suggestionOptions = tmpArray; //给tableView推荐的行阵列赋值
        return YES;
    }
    return NO;
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.suggestionOptions.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
    }
    
    // 字体配置 ACOUseSourceFont
    // if "nil" each cell will copy the font of the source UITextField
    // if not "nil" given UIFont will be used
    if ([self.options valueForKey:ACOUseSourceFont])
    {
        cell.textLabel.font = [self.options valueForKey:ACOUseSourceFont];
    } else
    {
        cell.textLabel.font = self.cellLabelFont;
    }
    cell.textLabel.adjustsFontSizeToFitWidth = NO;
    cell.textLabel.text = [self.suggestionOptions objectAtIndex:indexPath.row];
    
    UIView *tempView = [[UIView alloc]init];
    [cell setBackgroundView:tempView];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}
#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.textField setText:[self.suggestionOptions objectAtIndex:indexPath.row]];
    if (_autoCompleteDelegate && [_autoCompleteDelegate respondsToSelector:@selector(autoCompletion:didSelectAutoCompleteSuggestionWithIndex:)])
    {
        [_autoCompleteDelegate autoCompletion:self didSelectAutoCompleteSuggestionWithIndex:indexPath.row];
    }
    
    [self hideOptionsView];
//    [self.textField resignFirstResponder];
}

#pragma mark - UITextField delegate
- (void)textFieldValueChanged:(UITextField *)textField
{
    self.textField = textField;
    NSString *curString = textField.text;
    
    if (![curString length])
    {
        [self hideOptionsView];
        return;
    }else if ([self substringIsInDictionary:curString])
    {
        [self showOptionsView];
        [self reloadData];
    } else [self hideOptionsView];
}

// options view control
- (void)showOptionsView
{
    self.hidden = NO;
}

- (void)hideOptionsView
{
    self.hidden = YES;
}




@end
