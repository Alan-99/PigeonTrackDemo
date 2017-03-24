//
//  SignUpLogInViewController.m
//  信鸽Demo
//
//  Created by alan on 17/3/9.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "SignUpLogInViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionManager.h"
#import "ImageAndTextFieldView.h"


#define JScreenWidth [[UIScreen mainScreen]bounds].size.width
#define JScreenHight [[UIScreen mainScreen]bounds].size.hight

@interface SignUpLogInViewController () <UITextFieldDelegate>

@property (nonatomic) UITextField *indexTextFiled;
@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSMutableData *receiveData;
@property (nonatomic) AFHTTPSessionManager *manager;

@end

@implementation SignUpLogInViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURL *baseUrl = [NSURL URLWithString:@"http://b.hitgk.com"];
        _manager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseUrl sessionConfiguration:config];
        
//        [self fetchFeed];
    }
    return self;
    
}

- (void)fetchFeed:(id)sender
{
    // url0:查询用户
    NSString *url0 = @"http://b.hitgk.com:31568/users/queryAll";
    // url1:添加用户
    NSString *url1 = @"http://b.hitgk.com:31568/users/addUser";
    NSString *param = [[NSString alloc]init];
    [_manager GET:url0 parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"dataTask:%@",task);
        NSLog(@"responseObject:%@",responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSString *indexString = _indexTextFiled.text;
            NSUInteger index = [indexString integerValue];
            NSDictionary *userInfo = [(NSArray *)responseObject objectAtIndex:index];
//            NSLog(@"%@",userInfo);
            NSString *id = [(NSDictionary *)userInfo objectForKey:@"id"];
            NSString *password =[(NSDictionary *)userInfo objectForKey:@"password"];
            NSLog(@"%@",id);
            dispatch_async(dispatch_get_main_queue(), ^{
                _account.textFiled.text = [NSString stringWithFormat:@"%@",id];
                _PassWord.textFiled.text = password;
            });
        }
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *msg = [(NSDictionary *)responseObject objectForKey:@"msg"];
            NSLog(@"%@",msg);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        NSLog(@"error:%@",error);
    }];
//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//    // 初始化_session
//    _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
    
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:config];
//    // 指明访问的服务器地址    
//    NSURL *url = [NSURL URLWithString:@"http://b.hitgk.com:31568/users/queryAll"];
//    // 创建可变的请求对象，可以改变请求类型
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod = @"GET";
    // 创建一个数据接收任务
//    NSURLSessionDataTask *dataTask =
    
    // 创建第二个数据接收任务
//    NSURLSessionDataTask *dataTask1 = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"出错：%@",error);
//        } else {
//            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"得到的数据是：%@",str);
//            
//            NSLog(@"得到的响应：%@",response);
//        }
//    }];
    
//    [dataTask resume];
//    [dataTask1 resume];
}

- (void)postWebRequest:(id)sender
{
    // 指明访问的服务器地址
    NSString *urlString = @"http://b.hitgk.com:31568/users/addUser";
    NSURL *url = [NSURL URLWithString:urlString];
    // 请求参数
    NSString *phoneNumber = _account.textFiled.text;
    NSString *passWord = _PassWord.textFiled.text;
    // 请求参数的拼接
    NSString *param = [NSString stringWithFormat:@"id=%@&password=%@",phoneNumber,passWord];
    // 进行格式转换
    
    NSData *postData = [param dataUsingEncoding:NSUTF8StringEncoding];
    
    [_manager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
        request.HTTPBody = postData;
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        NSLog(@"task:%@",task);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, JScreenWidth, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:10];
    titleLabel.text = @"我是萌萌哒标题";
    [self.view addSubview:titleLabel];
    
    UIImageView *titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 80, JScreenWidth - 60 * 2, 80 )];
    titleImage.image = [UIImage imageNamed:@"Pegion.png"];
    titleImage.contentMode = UIViewContentModeScaleAspectFit;
    titleImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:titleImage];
    
    UILabel *indexLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 200, 80 , 40)];
    indexLabel.text = @"索引";
    indexLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:indexLabel];
    
    _indexTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 40, 30)];
    _indexTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    _indexTextFiled.text = @"0";
    _indexTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_indexTextFiled];
    
    
    _account = [[ImageAndTextFieldView alloc]initWithFrame:CGRectMake(40, 240, JScreenWidth - 2 * 40 , 40)];
    _account.backgroundColor = [UIColor clearColor];
    [_account setupImageName:@"User.png" textFieldPlaceHolder:@"请输入手机号"];
    _account.textFiled.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_account];
    
    _PassWord = [[ImageAndTextFieldView alloc]initWithFrame:CGRectMake(40, 240 + 40, JScreenWidth - 2 * 40, 40)];
    _PassWord.backgroundColor = [UIColor clearColor];
    [_PassWord setupImageName:@"Lock.png" textFieldPlaceHolder:@"请输入密码"];
    _PassWord.textFiled.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_PassWord];
    
    UIButton *getButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 320 + 30, JScreenWidth - 2 * 40, 40)];
    getButton.backgroundColor = [UIColor colorWithRed:116/255.0 green:168/255.0 blue:42/255.0 alpha:1];
    [getButton setTitle:@"接收数据" forState:UIControlStateNormal];
    [getButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getButton addTarget:self action:@selector(fetchFeed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getButton];
    
    UIButton *postButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 320 + 80, JScreenWidth - 2 * 40, 40)];
    postButton.backgroundColor = [UIColor colorWithRed:211/255.0  green:69/255.0  blue:68/255.0  alpha:1];
    [postButton setTitle:@"上传数据" forState:UIControlStateNormal];
    [postButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [postButton addTarget:self action:@selector(postWebRequest:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _account.textFiled) {
        [textField resignFirstResponder];
    } else if (textField == _PassWord.textFiled)
    {
        [textField resignFirstResponder];
    }
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
