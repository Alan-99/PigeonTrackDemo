//
//  EntityNameDataSource.m
//  YingYanSDKDemo
//
//  Created by alan on 16/12/6.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "EntityNameDataSource.h"
#import "CustomAutoCompleteObject.h" // 初始化：返回entityName
#import <CoreGraphics/CGBase.h>

@interface EntityNameDataSource ()

@property (strong, nonatomic) NSArray *entityObjects;

@end

@implementation EntityNameDataSource

#pragma mark - MLPAutoCompleteTextFieldDataSource
// 异步获取， example of asynchronous fetch
- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        if (self.simulateLatency) {
            CGFloat seconds = arc4random_uniform(4)+arc4random_uniform(4); // normal distribution
            NSLog(@"sleeping fetch of completion for %f",seconds);
            sleep(seconds);
        }
        
        NSArray *completions;
        if(self.testWithAutoCompleteObjectsInsteadOfStrings){
            completions = [self allEntityObjects];
        } else {
            completions = [self allEntities];
        }
        
        handler(completions);
    });
}

- (NSArray *)allEntityObjects
{
    if(!self.entityObjects){
        NSArray *entityNames = [self allEntities];
        NSMutableArray *mutableEntities = [NSMutableArray new];
        for(NSString *entityName in entityNames){
            CustomAutoCompleteObject *entity = [[CustomAutoCompleteObject alloc]initWithEntityName:entityName];
            [mutableEntities addObject:entity];
        }
        [self setEntityObjects:[NSArray arrayWithArray:mutableEntities]];
    }
    return self.entityObjects;
}

- (NSArray *)allEntities
{
    NSArray *entities =
    @[
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
      @"201609149"
      ];
    return entities;
}
@end
