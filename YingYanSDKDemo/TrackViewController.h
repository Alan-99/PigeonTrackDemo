//
//  TrackViewController.h
//  YingYanSDKDemo
//
//  Created by alan on 16/7/26.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduTraceSDK/BaiduTraceSDK-Swift.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapApi_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <MapKit/MapKit.h>



@interface TrackViewController : UIViewController <BMKMapViewDelegate>
{
    IBOutlet UITextField* _cityText1;
    IBOutlet UITextField* _cityText2;
    
    IBOutlet UITextField* _keyText1;
    IBOutlet UITextField* _keyText2;
    
    // 自定义大头针图片
    NSString *_icon;
    
    BMKLocationService *_locationService; //定位
    BMKPoiSearch* _poisearch; // 对应<BaiduMapAPI_Search/BMKSearchComponent.h>头文件
    BMKRouteSearch* _routesearch;
    int curPage;
}

@property (strong, nonatomic) IBOutlet UITextField *entityNameTextField;
@property (strong, nonatomic) IBOutlet BMKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *textView;
//@property (strong, nonatomic) BTRACE * traceInstance;


- (void)startTrace;

- (void)stopTrace;

- (void)setStart;
- (void)setEnd;
- (void)startFollowing;


- (NSString *)textFiledReturnEditing:(UITextField *)textField;



@end
