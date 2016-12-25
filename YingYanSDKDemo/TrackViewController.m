//
//  TrackViewController.m
//  YingYanSDKDemo
//
//  Created by alan on 16/7/26.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "TrackViewController.h"
#import "JSONKit.h"
#import "MarkAnnotation.h"
#import "FFDropDownMenuView.h"
#import "PegionDetailViewController.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

//@interface MarkAnnotation : BMKPointAnnotation
//{
//    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
//    int _degree;
//}
//
//@property (nonatomic) int type;
//@property (nonatomic) int degree;
//@end


@interface TrackViewController () <ApplicationServiceDelegate, ApplicationEntityDelegate, ApplicationTrackDelegate, ApplicationFenceDelegate, BMKGeoCodeSearchDelegate, BMKPoiSearchDelegate, BMKLocationServiceDelegate, BMKRouteSearchDelegate, UIAlertViewDelegate, BMKMapViewDelegate, UITextFieldDelegate, PDVCDelegate>
{
    
    BMKPointAnnotation* entityAnnotation;
    BMKPointAnnotation* poiAnnotation;
    NSArray* startNodeAnnotations;
    NSArray* endNodeAnnotations;
    
    BMKPointAnnotation* startAnnotation;
    BMKPointAnnotation* endAnnotation;
    
    BMKCircle *circleFence;
    
    BMKCitySearchOption* startCitySearchOption;
    BMKCitySearchOption* endCitySearchOption;
}

/** 右侧下拉菜单 **/
@property (nonatomic, strong) FFDropDownMenuView *dropdownMenu;


@end

@implementation TrackViewController

dispatch_queue_t global_queue;

static bool isStartPressed = TRUE;
static NSString * entityName;
static BTRACE * traceInstance = NULL;

double latitudeOfEntity;
double longitudeOfEntity;

NSTimer *timer;
NSRunLoop *loop;
static bool isMonitoringEntity = true;

bool firstTimeIntoForeGround = true;

int mark;

#pragma mark - 系统回调方法

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"track";
        UIImage *i = [UIImage imageNamed:@"track.png"];
        self.tabBarItem.image = i;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"TrackView did load");

    _poisearch = [[BMKPoiSearch alloc]init];

    _locationService = [[BMKLocationService alloc]init];
    _mapView.isSelectedAnnotationViewFront = YES;
    
    global_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    [self setMapProperty];
    [self setTextFieldProperty];
    [self setNavigationProperty];
    [self addObservers];
    [self startFollowing];
    [self setupDropDownMenu];
}

- (void)setMapProperty
{
    [_mapView setZoomLevel:11];
    _mapView.mapType = BMKMapTypeStandard;
    [self.view insertSubview:self.mapView atIndex:0]; //将mapView放在底层
//    _mapView.showMapScaleBar = true; // 显示比例尺控件
}

- (void)setTextFieldProperty
{
    _entityNameTextField.placeholder = @"EntityName";
    _entityNameTextField.returnKeyType = UIReturnKeyDone;
    // 输入框中的叉号在编辑时显示
    _entityNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 不自动纠错
    _entityNameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    _cityText1.returnKeyType = UIReturnKeyDone;
    _keyText1.returnKeyType = UIReturnKeyGo;
    
    _cityText2.returnKeyType = UIReturnKeyDone;
    _keyText2.returnKeyType = UIReturnKeyGo;
    
}

- (void)getPegionNameValue:(NSString *)value
{
    self.navigationItem.title = value;
    entityName = value;
    NSLog(@"导航栏标题：%@",self.navigationItem.title);
}

- (void)setNavigationProperty
{
    //    self.title = @"运动轨迹";
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"开始追踪" style:UIBarButtonItemStylePlain target:self action:@selector(startTrace)];
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"结束追踪" style:UIBarButtonItemStylePlain target:self action:@selector(stopTrace)];
    
//    [self.navigationItem.leftBarButtonItem setEnabled:NO];
    
    // 左侧菜单
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [addButton addTarget:self action:@selector(addDeviceAndPegion) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"Plus.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addButton];
    
    // 右侧追踪菜单栏
    UIButton *trackButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [trackButton addTarget:self action:@selector(showDropDownMenu) forControlEvents:UIControlEventTouchUpInside];
    [trackButton setImage:[UIImage imageNamed:@"Location.png"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:trackButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"first viewWillAppear");
    _mapView.delegate = self;
    
    _poisearch.delegate = self;
    _locationService.delegate = self;
//    [self startFollowing]; // 开启此行代码，手机定位点会向轨迹服务台上传数据
    [self doWork];
}


-(void)applicationWillResignActive {
    NSLog(@"程序即将进入后台执行");
// 从后台界面切换回来后不再出现重复的entity图标！！！！！！！
    [_mapView removeAnnotation:entityAnnotation];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _poisearch.delegate = nil;
    _locationService.delegate = nil;
    entityAnnotation = nil;
    circleFence = nil;
    [timer invalidate];
    isMonitoringEntity = false;
}

-(void)applicationDidBecomeActive {
    
    _poisearch.delegate = self;
    
    _locationService.delegate = self;
//    [self startFollowing];
    [self doWork];
    NSLog(@"程序已经进入前台执行");
    if (firstTimeIntoForeGround) {
        firstTimeIntoForeGround = false;
        return;
    }

}

-(void)viewWillDisappear:(BOOL)animated {
    NSLog(@"first viewWillDisappear");
    // 从其它界面切换回来后不再出现重复的entity图标！！！！！！！
    [_mapView removeAnnotation:entityAnnotation];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _poisearch.delegate = nil;
    _locationService.delegate = nil;
    _routesearch.delegate = nil;
    entityAnnotation = nil;
    circleFence = nil;
    [timer invalidate];
    isMonitoringEntity = false;
}

- (void)dealloc {
    if (_poisearch != nil) {
        _poisearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
    if (_routesearch){
        _routesearch = nil;
    }
    if (_locationService != nil) {
        _locationService = nil;
    }
    [self removeObservers];
}

#pragma mark - 事件监听方法

- (void)startTrace
{
    NSLog(@"!start Trace!!!!");
    isStartPressed = TRUE;
    BOOL intervalSetRet = [traceInstance setInterval:5 packInterval:30];
    NSLog(@"设置间隔结果%@",intervalSetRet ? @"YES" : @"NO");
    dispatch_async(global_queue, ^{
        [[BTRACEAction shared] startTrace:self trace:traceInstance];
    });
}

- (void)stopTrace
{
    NSLog(@"stop trace!!!!");
    dispatch_async(global_queue, ^{
        [[BTRACEAction shared] stopTrace:self trace:traceInstance];
    });
}

#pragma mark - 定位功能

- (void)startFollowing
{
    NSLog(@"进入跟随态");
    dispatch_async(dispatch_get_main_queue(), ^{
        [_locationService startUserLocationService];
        _mapView.showsUserLocation = NO;
        _mapView.userTrackingMode = BMKUserTrackingModeFollow; // 定位跟随模式，我的位置始终在地图中心，我的位置图标会旋转，地图不会旋转
        _mapView.showsUserLocation = YES;
    });

}

- (void)stopLocation
{
    NSLog(@"停止定位功能");
    [_locationService stopUserLocationService];
    _mapView.showsUserLocation = NO;
}

/**
 * 用户方向更新后，会调用此函数
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 * 用户方向更新后，会调用此函数
 */

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
//    NSLog(@"heading is %@", userLocation.heading);
}

 
 /**
 * @param userLocation 新的用户位置
 **/
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
}

/**
 * 在地图View停止定位后，会调用此函数
 * @param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 * 定位失败后，会调用此函数
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"locate error");
}


//- (BMKAnnotationView*)getMarkAnnotationView:(BMKMapView*)mapView viewForAnnotation:(MarkAnnotation*)markAnnotation
//{
//    BMKAnnotationView* annotationView = nil;
//    switch (markAnnotation.type)
//    {
//        case 0: // < 0：起点；1：终点；>
//        {
//            annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
//            if (annotationView == nil){
//                annotationView = [[BMKAnnotationView alloc]initWithAnnotation:markAnnotation reuseIdentifier:@"start_node"];
//                annotationView.image = [UIImage imageNamed:@"StartIcon.png"];
//                annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
//                annotationView.canShowCallout = true;
//            }
//            annotationView.annotation = markAnnotation;
//        }
//            break;
//        case 1:
//        {
//            annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
//            if(annotationView == nil) {
//                annotationView = [[BMKAnnotationView alloc]initWithAnnotation:markAnnotation reuseIdentifier:@"end_node"];
//                annotationView.image = [UIImage imageNamed:@"EndIcon.png"];
//                annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height *0.5));
//                annotationView.canShowCallout = true;
//            }
//            annotationView.annotation = markAnnotation;
//        }
//            break;
//        default:
//            break;
//    }
//    return annotationView;
//}

// 根据传进来的annotation参数创建并返回对应的大头针控件，如果返回nil，显示出来的大头针就采取系统的默认样式
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{

    if (annotation == entityAnnotation)
    {
        NSString *annotationViewID = @"renameMark";
        BMKPinAnnotationView* annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
        if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewID];
        // 设置颜色
        annotationView.pinColor = BMKPinAnnotationColorPurple;
        // 从天上掉下效果
        annotationView.animatesDrop = YES;
        // 设置可拖拽
        annotationView.draggable = YES;
        }
        return annotationView;
    }

        NSString *annotationViewID = @"mark";
        // 检查是否有重用的缓存
        BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
        // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
        if (annotationView == nil) {
            annotationView = [[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:annotationViewID];
            annotationView.image = [UIImage imageNamed:_icon];
        }
        // 设置位置
        annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
        annotationView.annotation = annotation;
        // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
        annotationView.canShowCallout = YES;
        annotationView.draggable = NO; // 设置可拖拽
        return annotationView;
  
    return nil;
}



#pragma mark - 实例方法

- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil]; //监听是否触发home键挂起程序.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil]; //监听是否重新进入程序.
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}



-(void) doWork {
    
    if (entityName == nil || entityName == NULL) {
        NSLog(@"dowork1:%@", entityName);
        [self startFollowing];
        
    }else if ([entityName isKindOfClass:[NSNull class]]){
        NSLog(@"dowork2:%@", entityName);
        [self startFollowing];
    }else if([[entityName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        NSLog(@"dowork3:%@",entityName);
        [self startFollowing];
        
    }else {
        
        NSLog(@"dowork4:%@",entityName);
        //使用鹰眼SDK，必须先实例化Trace对象 operationMode 2代表进行长连接，且采集轨迹数据
        extern int serviceId;
        extern NSString* const AK;
        extern NSString* const MCODE;
        traceInstance = [[BTRACE alloc] initWithAk: AK mcode: MCODE serviceId: serviceId entityName: entityName operationMode: 2];
        
        // delegate次序不能改。。。
        [_mapView viewWillAppear];
        _mapView.delegate = self;
        _mapView.zoomLevel = 13;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self stopLocation];
//            [_locationService stopUserLocationService];
//            _mapView.showsUserLocation = NO;
        });
        
        //视图加载之后就请求实时位置
        [self queryEntityList];
        //查找当前的围栏列表
        [self queryFenceList];
        
        loop = [NSRunLoop currentRunLoop];
        timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:4 target:self selector:@selector(queryEntityList) userInfo:nil repeats:YES];
        [loop addTimer:timer forMode:NSDefaultRunLoopMode];
        
        isMonitoringEntity = true;
    }
    
}


- (void)queryFenceList {
//    dispatch_async(global_queue, ^{
//        extern int serviceId;
//        [[BTRACEAction shared] queryFenceList:self serviceId:serviceId creator:entityName fenceIds:nil];
//    });
}

- (void)queryEntityList {
    dispatch_async(global_queue, ^{
        extern int serviceId;
        NSLog(@"entityName=%@",entityName);
        [[BTRACEAction shared] queryEntityList:self serviceId:serviceId entityNames:entityName columnKey:nil activeTime:0 returnType:0 pageSize:0 pageIndex:0];
    });
}

- (NSString *)textFiledReturnEditing:(UITextField *)textField
{
    textField.returnKeyType = UIReturnKeyDone;
    [textField resignFirstResponder];
    return textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if(textField == _entityNameTextField)
    {
        [self doWork];
//        [self.navigationItem.leftBarButtonItem setEnabled:YES];

    } else if (textField == _keyText1) {
        mark = 0; //起点地址设定后，mark为0
        [self setStart];
        
    } else if (textField == _keyText2) {
        mark = 1; // 终点地址设定后，mark为1
        [self setEnd];
    }
    
    [textField resignFirstResponder];
    return YES;

}



//添加当前位置的标注
-(void)addPointAnnotation {
    CLLocationCoordinate2D coord;
    coord.latitude = latitudeOfEntity;
    coord.longitude = longitudeOfEntity;
    if (nil == entityAnnotation) {
        entityAnnotation = [[BMKPointAnnotation alloc] init];
    }
    entityAnnotation.coordinate = coord;
    entityAnnotation.title = @"Entity最新位置";
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mapView removeAnnotation:entityAnnotation];
        [_mapView setCenterCoordinate:coord animated:true];
        [_mapView addAnnotation:entityAnnotation];
    });
}


-(void)putMessageInTextView:(NSString*) message {
    dispatch_async(dispatch_get_main_queue(), ^{
        _textView.alpha = 1;
        _textView.text = message;
    });
    [NSThread sleepForTimeInterval:2];
    dispatch_async(dispatch_get_main_queue(), ^{
        _textView.text = @"";
        _textView.alpha = 0;
    });
}

-(void)trackLatestLocationOfEntity {
    
    while (isMonitoringEntity) {
        [self queryEntityList];
        for (int i = 0; i < 5; i++) {
            sleep(1);
            if (!isMonitoringEntity) {
                break;
            }
        }
    }
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay {
    
    if (overlay == circleFence) {
        BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [[UIColor greenColor] colorWithAlphaComponent:0.3];
        circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.4];
        circleView.lineWidth = 4.0;
        return circleView;
    }
    return nil;
}

- (NSDictionary*)trackAttr {
    NSMutableDictionary *glossary = [NSMutableDictionary dictionary];
    [glossary setObject: @"col1" forKey: @"v1"];
    [glossary setObject: @"col2" forKey: @"v2"];
    return glossary;
}



#pragma mark - Trace服务相关的回调方法

- (void)onStartTrace:(NSInteger)errNo errMsg:(NSString *)errMsg {
    NSLog(@"startTrace: %@", errMsg);
    NSString* no = [NSString stringWithFormat:@"%ld",(long)errNo];
    [self putMessageInTextView:no];
    [self putMessageInTextView:errMsg];
}

- (void)onStopTrace:(NSInteger)errNo errMsg:(NSString *)errMsg {
    NSLog(@"stopTrace: %@", errMsg);
    [self putMessageInTextView:errMsg];
}

- (void)onPushTrace:(uint8_t)msgType msgContent:(NSString *)msgContent {
    NSLog(@"收到推送消息: 类型[%d] 内容[%@]", msgType, msgContent);
    [self putMessageInTextView:msgContent];
}



#pragma mark - Entity相关的回调方法

- (void)onQueryEntityList:(NSData *)data {
    NSString *entityListResult = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"实时位置查询结果: %@", entityListResult);
    NSDictionary *dic = [entityListResult objectFromJSONString];
    NSNumber *status = [dic objectForKey:@"status"];
    if (0 == [status longValue])
    {
        NSArray *entities = [dic objectForKey:@"entities"];
        NSArray *entities2 = [NSArray arrayWithArray:entities];

        for (int i = 0; i < [entities2 count]; i++)
        {
            NSDictionary *entity = [entities2 objectAtIndex:i];
            NSDictionary *realtimePoint = [entity objectForKey:@"realtime_point"];
            NSArray *location = [realtimePoint objectForKey:@"location"];
            longitudeOfEntity = [[location objectAtIndex:0] doubleValue];
            latitudeOfEntity = [[location objectAtIndex:1] doubleValue];
            extern double const EPSILON;
            if (fabs(longitudeOfEntity - 0) < EPSILON && fabs(latitudeOfEntity - 0) < EPSILON)
            {
                continue;
            }
//            dispatch_async(dispatch_get_main_queue(), ^{
////                [_mapView removeOverlays:_mapView.overlays];
////                [_mapView removeAnnotations:_mapView.annotations];
////                [_mapView removeAnnotation:entityAnnotation];
//            });
            [self addPointAnnotation];
        }
    }
}



#pragma mark - 进行路线检索，结果在onGetDrivingRouteResult回调中返回


- (void)setStart {

    _icon = @"StartIcon.png";
    curPage = 0;
    startCitySearchOption = [[BMKCitySearchOption alloc]init];
    startCitySearchOption.pageIndex = curPage;
    startCitySearchOption.pageCapacity = 1; //默认为10，最多50；
    startCitySearchOption.city = _cityText1.text;
    startCitySearchOption.keyword = _keyText1.text;
    
    BOOL flag = [_poisearch poiSearchInCity:startCitySearchOption];
    if (flag)
    {
        NSLog(@"城市内检索成功");
    }
    else
    {
        NSLog(@"城市内检索失败");
    }
}

- (void)setEnd {
    _icon = @"EndIcon.png";
    curPage = 0;
    endCitySearchOption = [[BMKCitySearchOption alloc]init];
    endCitySearchOption.pageIndex = curPage;
    endCitySearchOption.pageCapacity = 1; //默认为10，最多50；
    endCitySearchOption.city = _cityText2.text;
    endCitySearchOption.keyword = _keyText2.text;
    
    BOOL flag = [_poisearch poiSearchInCity:endCitySearchOption];
    if (flag)
    {
        NSLog(@"城市内检索成功");
    }
    else
    {
        NSLog(@"城市内检索失败");
    }
}


#pragma mark - implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    // 清楚屏幕中所有的annotation
    //    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    //    [_mapView removeAnnotations:array];
    
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < poiResult.poiInfoList.count; i++) {
            BMKPoiInfo *poi = [poiResult.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            
            [annotations addObject:item];
        }
        
        if (mark == 0) {
            [_mapView removeAnnotations:startNodeAnnotations];
            startNodeAnnotations = [NSArray arrayWithArray:annotations];
            [_mapView addAnnotations:startNodeAnnotations];
            [_mapView showAnnotations:startNodeAnnotations animated:YES];
        } else if(mark == 1) {
            [_mapView removeAnnotations:endNodeAnnotations];
            endNodeAnnotations = [NSArray arrayWithArray:annotations];
            [_mapView addAnnotations:endNodeAnnotations];
            [_mapView showAnnotations:endNodeAnnotations animated:YES];
        } else {
            // 没有别的情况了
        }
        
//
//        [_mapView addAnnotations:annotations];
//        [_mapView showAnnotations:annotations animated:YES];
    }else if (errorCode == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}

//- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
//{
//    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//    [_mapView removeAnnotations:array];
//    array = [NSArray arrayWithArray:_mapView.overlays];
//    [_mapView removeOverlays:array];
//    if (error == BMK_SEARCH_NO_ERROR) {
//        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
//        // 计算路线方案中的路段数目
//        NSInteger size = [plan.steps count];
//        int planPointCounts = 0;
//        for (int i = 0; i < size; i++) {
//            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
//            if(i==0){
//                MarkAnnotation* item = [[MarkAnnotation alloc]init];
//                item.coordinate = plan.starting.location;
//                item.title = @"起点";
//                item.type = 0;
//                [_mapView addAnnotation:item]; // 添加起点标注
//                NSLog(@"add startAnnotation success!");
//                
//                
//            }else if(i==size-1)
//            {
//                MarkAnnotation* item = [[MarkAnnotation alloc]init];
//                item.coordinate = plan.terminal.location;
//                item.title = @"终点";
//                item.type = 1;
//                [_mapView addAnnotation:item]; // 添加终点标注
//                NSLog(@"add endAnnotation success!");
//                
//            }
//            //添加annotation节点
//            MarkAnnotation* item = [[MarkAnnotation alloc]init];
//            item.coordinate = transitStep.entrace.location;
//            item.title = transitStep.entraceInstruction;
//            item.degree = transitStep.direction * 30;
////            item.type = 4;
////            [_mapView addAnnotation:item];
//            
//            //轨迹点总数累计
//            planPointCounts += transitStep.pointsCount;
//        }
//        [_mapView setCenterCoordinate:plan.starting.location];
//    }
//}

#pragma mark - 导航栏右侧下拉菜单
/** 初始化下拉菜单 **/
- (void)setupDropDownMenu {
    NSArray *modelsArray = [self getMenuModelsArray];
    self.dropdownMenu = [FFDropDownMenuView ff_DefaultStyleDropDownMenuWithMenuModelsArray:modelsArray menuWidth:FFDefaultFloat eachItemHeight:FFDefaultFloat menuRightMargin:FFDefaultFloat triangleRightMargin:FFDefaultFloat];
}

- (NSArray *)getMenuModelsArray {
    __weak typeof(self) weakSelf = self;
    
    // 菜单模型0
    FFDropDownMenuModel *menuModel0 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"Start Track" menuItemIconName:@"Check.png" menuBlock:^{
        [weakSelf startTrace];
    }];
    // 菜单模型1
    FFDropDownMenuModel *menuModel1 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"Stop Track" menuItemIconName:@"Cross.png" menuBlock:^{
        [weakSelf stopTrace];
    }];
    
    NSArray *menuModelArr = @[menuModel0, menuModel1];
    return menuModelArr;
}

/** 显示下拉菜单 **/
- (void)showDropDownMenu {
    [self.dropdownMenu showMenu];
}

/** 添加设备及鸽子 **/
- (void)addDeviceAndPegion {
    PegionDetailViewController *pdvc1 = [[PegionDetailViewController alloc]init];
    pdvc1.delegate = self;
    [self.navigationController pushViewController:pdvc1 animated:YES];
}



@end
