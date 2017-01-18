//
//  AutoCompletionTableView.h
//  YingYanSDKDemo
//
//  Created by alan on 16/12/14.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

// Consts for AutoCompleteOptions:
//
// if YES - suggestions will be picked for display case-sensitive
// if NO - case will be ignored
#define ACOCaseSensitive @"ACOCaseSensitive"

// if "nil" each cell will copy the font of the source UITextField
// if not "nil" given UIFont will be used
#define ACOUseSourceFont @"ACOUseSourceFont"

// if YES substrings in cells will be highlighted with bold as user types in
// *** FOR FUTURE USE ***
#define ACOHighlightSubstrWithBold @"ACOHighlightSubstrWithBold"

// if YES - suggestions view will be on top of the source UITextField
// if NO - it will be on the bottom
// *** FOR FUTURE USE ***
#define ACOShowSuggestionsOnTop @"ACOShowSuggestionsOnTop"

@class AutoCompletionTableView;

@protocol AutoCompletionTableViewDelegate <NSObject>

@required
// 根据需要搜索的string返回动态建议的阵列
- (NSArray *)autoCompletion:(AutoCompletionTableView*)completer
             suggestionsFor:(NSString*)string;
/**
 @method Invoked when user clicked an auto-complete suggestion UITableViewCell.
 @param index: the index that was clicked
 **/
- (void)autoCompletion:(AutoCompletionTableView*)completer didSelectAutoCompleteSuggestionWithIndex:(NSInteger)index;

@end

@interface AutoCompletionTableView : UITableView <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
// dictionary of nsstrings of your auto-completion terms
@property (nonatomic, strong) NSArray *suggestionsDictionary;

//Delegate for AutoCompletionTableView
@property (nonatomic, strong) id<AutoCompletionTableViewDelegate> autoCompleteDelegate;
//Dictionary of auto-completion options(check constants above)
@property (nonatomic, strong) NSDictionary *options;

// call it for proper initializtion
- (UITableView *)initWithTextField:(UITextField *)textField
                  inViewController:(UIViewController*)parentViewController
                       withOptions:(NSDictionary *)options;

@end
