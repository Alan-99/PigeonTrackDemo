//
//  CommunityViewController.m
//  YingYanSDKDemo
//
//  Created by alan on 16/8/26.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "CommunityViewController.h"

@interface CommunityViewController ()
@property (weak, nonatomic) IBOutlet UITextField *comment;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nameSet:(id)sender {
}

- (void)newEvent:(id)sender {
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //UIViewController类就有navigationItem的属性
        self.navigationItem.title = @"社区";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newEvent:)];
        
        UITabBarItem *tbi =  self.tabBarItem;
        tbi.title = @"Community";
        UIImage *i = [UIImage imageNamed:@"community.png"];
        tbi.image = i;
        
        
        //        [self setTabBarItem:self.tabBarItem
        //                      title:@"社区"
        //              withTitleSize:16.0 withTitleColor:[UIColor purpleColor] andFontName:nil selectedImage:nil];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
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


@end
