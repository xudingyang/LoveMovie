//
//  DYLocationTool.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/2.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYLocationTool.h"
#import <CoreLocation/CoreLocation.h>

@interface DYLocationTool () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

/** 当前定位的位置 */
@property (strong, nonatomic) CLLocation *currentLocation;

@end

@implementation DYLocationTool

static id _instance;

+ (instancetype)sharedLoactionTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone{
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        //1 创建定位实例:懒加载中完成
        _locationManager = [[CLLocationManager alloc] init];
        //2 申请授权
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            
            [_locationManager requestWhenInUseAuthorization];
        }
        // iOS9 临时开启后台定位。这回在界面上端有个蓝色条条，表示正在导航
//        if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
//            _locationManager.allowsBackgroundLocationUpdates = YES;
//        }
        
        //3. 设置代理, 来获取数据
        _locationManager.delegate = self;
        
        //4. 开始定位
        [_locationManager startUpdatingLocation];
        
        //5. 距离筛选器
        // 值: 多少米  譬如:设置10, 就代表用户位置发生10米以上的偏移时, 才去定位
        _locationManager.distanceFilter = 20;
        
        //6. 设置精确度
        //desired: 期望
        //Accurac: 精准度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //CLLocation 位置对象 --> 经纬度
    //CLLocationCoordinate2D coordinate 经纬度
    //CLLocationDegrees latitude   纬度
    //CLLocationDegrees longitude  经度
    
    CLLocation *location = locations.firstObject;
    
    NSLog(@"latitude: %f,longitude: %f",location.coordinate.latitude, location.coordinate.longitude);
    
    self.currentLocation = location;
    
}

- (CGFloat)distanceFromLatitude:(CGFloat)latitude andLongitude:(CGFloat)longitude {
    CLLocation *desLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CGFloat distance = [self.currentLocation distanceFromLocation:desLocation];
//    NSLog(@"纬度：%f  经度：%f  speed = %f", desLocation.coordinate.latitude, desLocation.coordinate.longitude, desLocation.speed);
//    NSLog(@"纬度：%f  经度：%f  speed = %f", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude, self.currentLocation.speed);
    return distance;
}


//#pragma mark - 懒加载locationManager
//- (CLLocationManager *)locationManager{
//    if (_locationManager == nil) {
//        _locationManager = [[CLLocationManager alloc] init];
//    }
//    return _locationManager;
//}



@end
