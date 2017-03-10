//
//  ScanViewController.m
//  YingYanSDKDemo
//
//  Created by alan on 16/10/20.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ScanViewController.h"


@interface ScanViewController () <AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *session;
    AVCaptureVideoPreviewLayer *layer;
}

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCamera];
    [self addLabel];
    self.navigationItem.title = @"扫描二维码";
    
    // 解决Ignoring bogus layer size错误
    self.automaticallyAdjustsScrollViewInsets = false;
    
    // Do any additional setup after loading the view.
    
}

- (void)addLabel
{
    CGRect frame = CGRectMake(50, 380, 280, 60);
    _myTextView = [[UITextView alloc]initWithFrame:frame];
    
    _myTextView.backgroundColor = [UIColor clearColor];
    _myTextView.textColor = [UIColor grayColor];
    // 解决Ignoring bogus layer size错误
//    _myTextView.layoutManager.allowsNonContiguousLayout = NO;
    
    [self.view addSubview:_myTextView];
    
}


- (void)addCamera {
    // 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 初始化链接对象
    session = [[AVCaptureSession alloc]init];
    // 创建输入流
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if(input) {
        // 设置会话的输入设备
        [session addInput:input];
        
        // 创建输出流
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
        // 设置代理，在主线程里刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        // 高质量采集率
        [session setSessionPreset:AVCaptureSessionPresetHigh];
        [session addOutput:output];
        // 设置扫码支持的编码格式（如下设置条形码和二维码兼容）
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeCode128Code];
        layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        // 设置相机扫描框的大小
        layer.frame = CGRectMake(50, 170, 280, 200);
        [self.view.layer insertSublayer:layer atIndex:0];
        // 开始捕获
        [session startRunning];
    } else{
        NSLog(@"error--%@",[error localizedDescription]);
    }

}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSLog(@"来到代理方法中");
    NSString* QR_Code = nil;
    for (AVMetadataObject *metadata in metadataObjects) {
        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]){
            QR_Code = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
            _myTextView.text = [NSString stringWithFormat:@"二维码:%@",QR_Code];
            break;
        }
    }
    NSLog(@"QR Code---%@",QR_Code);
    // 结束代码，如果没有这行代码，手机摄像头对准二维码后就会一直反复调用这个代理方法
    [session stopRunning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.myTextView != nil) {
        [self.delegate2 getQRCodeValue:_myTextView.text];
    }
    [super viewWillDisappear:animated];
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
