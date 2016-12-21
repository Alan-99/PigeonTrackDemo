//
//  InquiryViewController.m
//  YingYanSDKDemo
//
//  Created by alan on 16/8/18.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "InquiryViewController.h"
#import "TrackViewController.h"

@interface InquiryViewController ()<ApplicationTrackDelegate, BMKMapViewDelegate, UITextFieldDelegate>

@end

@implementation InquiryViewController

dispatch_queue_t global_queue_view2;

NSString *startTime;
NSString *endTime;
static NSString *entityName;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem *tbi = self.tabBarItem;
        tbi.title = @"inquiry";
        UIImage *i = [UIImage imageNamed:@"inquiry.png"];
        tbi.image = i;
        
        self.navigationItem.title = @"查询";
        
//        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addObject)];
//        self.navigationItem.leftBarButtonItem = bbi;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开始查询" style:UIBarButtonItemStylePlain target:self action:@selector(onClickQueryHistoryTrackButton:)];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _entityName2TextField.placeholder = @"请输入待查询信鸽名";
    _entityName2TextField.returnKeyType = UIReturnKeyGo;
    // Do any additional setup after loading the view from its nib.
    global_queue_view2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

- (void)dealloc {
    if(_historyMapView) {
        _historyMapView = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"historyMapView will appear");
    _historyMapView.delegate =self;
    _historyMapView.mapType = BMKMapTypeStandard;
    _historyMapView.hidden = false;
    _datePicker.hidden = true;
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"historyMapView will disappear");
    [_historyMapView viewWillDisappear];
    _historyMapView.delegate = nil;
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _datePicker.hidden = true;
    _historyMapView.hidden = false;
}

- (IBAction)datePickerValueChanged:(UIDatePicker *)sender {
    NSString *timeInterval = [NSString stringWithFormat:@"%f", sender.date.timeIntervalSince1970];
    startTime = [[timeInterval componentsSeparatedByString:@"."] objectAtIndex:0];
    endTime = [NSString stringWithFormat:@"%lld", ([startTime longLongValue] + 24*3600 - 1)];
}

- (IBAction)triggerDatePicker:(UIButton *)sender {
    _datePicker.hidden = false;
    _historyMapView.hidden = true;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    entityName = textField.text;
    // 再清空文本内容并调用resignFirstResponder关闭键盘
    [textField resignFirstResponder];
    return YES;
}

//- (NSString *)returnEntityName:(UITextField *)textField
//{
//    entityName = textField.text;
//    return entityName;
//}

- (void)onClickQueryHistoryTrackButton:(UIButton *)sender {
    _datePicker.hidden = true;
    dispatch_async(global_queue_view2,^{
        extern int serviceId;
        [self textFieldShouldReturn:_entityName2TextField];
        NSLog(@"%@", entityName);
        [[BTRACEAction shared] getTrackHistory:self serviceId:serviceId entityName:entityName startTime:[startTime intValue] endTime:[endTime intValue] simpleReturn:1 isProcessed:1 pageSize:5000 pageIndex:1];
    });
    [self textFieldShouldReturn:_entityName2TextField];
    _historyMapView.hidden = false;
}


- (void) onGetHistoryTrack:(NSData *)data {
    NSString *trackHistoryResult = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",trackHistoryResult);
    NSDictionary *dic = [trackHistoryResult objectFromJSONString];
    NSNumber *status = [dic objectForKey:@"status"];
    NSString *message = [dic objectForKey:@"message"];
    NSLog(@"%@", message);
    if (0 == [status longValue]) {
        NSArray *pois = [dic objectForKey:@"points"];
        //去除经纬度为(0,0)的点 将剩余的坐标点存储在poisWithoutZero中
        NSMutableArray *poisWithoutZero = [[NSMutableArray alloc] init]; ;
        for (int i = 0; i < [pois count]; i++) {
            NSArray *point = [pois objectAtIndex:i];
            NSNumber *longitude = [point objectAtIndex:0];
            NSNumber *latitude = [point objectAtIndex:1];
            extern double const EPSILON;
            if (fabs(longitude.doubleValue - 0) < EPSILON && fabs(latitude.doubleValue - 0) < EPSILON) {
                continue;
            }
            [poisWithoutZero addObject:point];
        }
        
        CLLocationCoordinate2D *locations = malloc([poisWithoutZero count] * sizeof(CLLocationCoordinate2D));
        CLLocationDegrees minLat = 90.0;
        CLLocationDegrees maxLat = -90.0;
        CLLocationDegrees minLon = 180.0;
        CLLocationDegrees maxLon = -180.0;
        for (int i = 0; i < [poisWithoutZero count]; i++) {
            NSArray *point = [poisWithoutZero objectAtIndex:i];
            NSNumber *longitude = [point objectAtIndex:0];
            NSNumber *latitude = [point objectAtIndex:1];
            minLat = MIN(minLat, latitude.doubleValue);
            maxLat = MAX(maxLat, latitude.doubleValue);
            minLon = MIN(minLon, longitude.doubleValue);
            maxLon = MAX(maxLon, longitude.doubleValue);
            
            locations[i] = CLLocationCoordinate2DMake(latitude.doubleValue,longitude.doubleValue);
        }
        
        BMKPolyline* polyline = [BMKPolyline polylineWithCoordinates:locations count:[poisWithoutZero count]];
        
        CLLocationCoordinate2D centerCoord = CLLocationCoordinate2DMake((minLat + maxLat) * 0.5f, (minLon + maxLon) * 0.5f);
        BMKCoordinateSpan viewSapn;
        viewSapn.latitudeDelta = maxLat - minLat;
        viewSapn.longitudeDelta = maxLon - minLon;
        BMKCoordinateRegion viewRegion;
        viewRegion.center = centerCoord;
        viewRegion.span = viewSapn;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_historyMapView setRegion:viewRegion animated:YES];
            [_historyMapView addOverlay:polyline];
        });
        
        free(locations);
    }
}


-(BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

@end
