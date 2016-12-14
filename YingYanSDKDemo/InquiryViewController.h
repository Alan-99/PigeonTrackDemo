//
//  InquiryViewController.h
//  YingYanSDKDemo
//
//  Created by alan on 16/8/18.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduTraceSDK/BaiduTraceSDK-Swift.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h> //引入地图功能所有的头文件
#import "JSONKit.h"
#import <MapKit/MapKit.h>
#import <stdlib.h>
#import "TrackViewController.h"

@interface InquiryViewController : UIViewController

@property (strong, nonatomic) IBOutlet BMKMapView *historyMapView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *chooseTarget;
@property (weak, nonatomic) IBOutlet UITextField *entityName2TextField;

- (IBAction)datePickerValueChanged:(UIDatePicker *)sender;
- (IBAction)triggerDatePicker:(UIButton *)sender;
- (void)onClickQueryHistoryTrackButton:(UIButton *)sender;

@end
