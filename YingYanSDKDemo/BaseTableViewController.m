//
//  BaseTableViewController.m
//  YingYanSDKDemo
//
//  Created by alan on 16/11/29.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "BaseTableViewController.h"
#import "CellGroupModel.h"
#import "ArrowCellModel.h"
#import "PushClassViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}

- (NSMutableArray *)cellGroups
{
    if (_cellGroups == nil) {
        _cellGroups = [[NSMutableArray alloc]init];
    }
    return _cellGroups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // 这里用self.cellGroups.count而不是_cellGroups.count
    return self.cellGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 注意：整个cellGroupModel对象是self.cellGroups的某一个section部分
    // 而不是cellGroupModel对象的section属性即cellGroupModel.section = self.cellGroups.section;
    CellGroupModel *cellGroupModel = self.cellGroups[section];
    return cellGroupModel.section.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CellGroupModel *cellGroupModel = self.cellGroups[section];
    return cellGroupModel.header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    if (tableViewCell == nil) {
        tableViewCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"tableViewCell"];
    }
    
    CellGroupModel *cellGroupModel = self.cellGroups[indexPath.section];
    ArrowCellModel *arrowCellModel = cellGroupModel.section[indexPath.row];
    tableViewCell.textLabel.textAlignment = NSTextAlignmentLeft;
    tableViewCell.textLabel.text = arrowCellModel.title;
    
//    // tableViewCell与对应的pushClass之间的传值问题
//    PushClassViewController *pcvc = [[PushClassViewController alloc]init];
//    arrowCellModel.pushClass = pcvc;
//    tableViewCell.detailTextLabel.text = pcvc.detail;
    //
    tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return tableViewCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    CellGroupModel *cellGroupModel = self.cellGroups[section];
    return cellGroupModel.footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellGroupModel *cellGroupModel = self.cellGroups[indexPath.section];
    ArrowCellModel *arrowCellModel = cellGroupModel.section[indexPath.row];
    
    UIViewController *vc = [[arrowCellModel.pushClass alloc]init];
    vc.title = arrowCellModel.title;
    [self.navigationController pushViewController:vc animated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
