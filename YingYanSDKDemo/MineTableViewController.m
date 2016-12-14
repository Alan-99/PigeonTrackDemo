//
//  MineTableViewController.m
//  MineTableView
//
//  Created by alan on 16/11/23.
//  Copyright © 2016年 sibet. All rights reserved.
//

#import "MineTableViewController.h"
#import "CellGroupModel.h"
#import "ArrowCellModel.h"

#import "MyNicknameViewController.h"
#import "FeedYearsViewController.h"
#import "GloriesViewController.h"

#import "TestViewController.h"

#import "MyPegionViewController.h"
#import "MyDeviceViewController.h"
#import "MySettingViewController.h"

@interface MineTableViewController ()

@end

@implementation MineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingCellsData];
    NSLog(@"MineTableViewController view did load");
    // Do any additional setup after loading the view.
}

- (void)settingCellsData {
    ArrowCellModel *model00 = [ArrowCellModel ArrowCellModelWithTitle:@"昵称" detail:nil relateClass:[MyNicknameViewController class]];
    ArrowCellModel *model01 = [ArrowCellModel ArrowCellModelWithTitle:@"养殖鸽龄" detail:nil relateClass:[FeedYearsViewController class]];
    ArrowCellModel *model02 = [ArrowCellModel ArrowCellModelWithTitle:@"荣誉" detail:nil relateClass:[GloriesViewController class]];
    ArrowCellModel *model03 = [ArrowCellModel ArrowCellModelWithTitle:@"test" detail:nil relateClass:[TestViewController class]];
    CellGroupModel *group0 = [[CellGroupModel alloc]init];
    group0.section = @[model00, model01, model02, model03];
    group0.header = @"一些简介😀🙂😋😊🙄😟😞😔☹️";
    group0.footer = @"简介有些少🐸🦁🐮🙊";
    [self.cells addObject:group0];
    NSLog(@"添加第一组");
    
    ArrowCellModel *model10 = [ArrowCellModel ArrowCellModelWithTitle:@"我的鸽子" detail:nil relateClass:[MyPegionViewController class]];
    ArrowCellModel *model11 = [ArrowCellModel ArrowCellModelWithTitle:@"我的设备" detail:nil relateClass:[MyDeviceViewController class]];
    CellGroupModel *group1 = [[CellGroupModel alloc]init];
    group1.section = @[model10, model11];
    group1.header = @"信鸽信息啦🍅🍆🌶🍍🍅🍓🍋";
    group1.footer = @"就这两个指标么🍛🍙🍣🍥🍲";
    [self.cells addObject:group1];
    
    ArrowCellModel *model20 = [ArrowCellModel ArrowCellModelWithTitle:@"设置" detail:nil relateClass:[MySettingViewController class]];
    CellGroupModel *group2 = [[CellGroupModel alloc]init];
    group2.section = @[model20];
    [self.cells addObject:group2];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"jkldjfskl;dajfads;lfjkdas;kl///////");
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
