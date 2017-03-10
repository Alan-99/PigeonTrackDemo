//
//  SignUpLogInViewController.m
//  信鸽Demo
//
//  Created by alan on 17/3/9.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "SignUpLogInViewController.h"
#import <AFNetworking/AFNetworking.h>
//#import "AFHTTPSessionManager.h"

@interface SignUpLogInViewController ()

@end

@implementation SignUpLogInViewController

- (void)fetchFeed
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    NSString *requestString = @"http://b.hitgk.com:31568/users/queryAll";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error:%@",error);
        } else {
            NSLog(@"相应response：%@, 响应对象responseObject: %@", response, responseObject);
        }
    }];
    [dataTask resume];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
