//
//  NearByWeibo.m
//  ME_微博_CZL
//
//  Created by user on 16/10/4.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "NearByWeibo.h"
#import <MapKit/MapKit.h>
#import "YYModel.h"
#import "WeiboAnnotation.h"

@interface NearByWeibo ()<MKMapViewDelegate,SinaWeiboRequestDelegate> {
    MKMapView * _mapView;
    BOOL isLocation;
}

@end

@implementation NearByWeibo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createMapView];
    isLocation = NO;
    // Do any additional setup after loading the view.
}
- (void)_createMapView {
    if (KSystemVersion >= 8.0) {
        [[[CLLocationManager alloc] init] requestWhenInUseAuthorization];
        
    }
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
    double lat = coordinate.latitude;
    double lon = coordinate.longitude;
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    
    [_mapView setRegion:region animated:YES];
    
    if (isLocation == NO) {
        isLocation = YES;
        SinaWeibo * wb = kSinaWeibo;
        NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
        [params setObject:[NSString stringWithFormat:@"%f",lat] forKey:@"lat"];
        
        [wb requestWithURL:@"place/nearby_timeline.json" params:params httpMethod:@"GET" delegate:self];
        
    }
    

}

-(void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    NSArray * array = result[@"statuses"];
    for (NSDictionary * dic in array) {
     
        WeiboModel * weiboModel = [WeiboModel yy_modelWithJSON:dic];
        
        WeiboAnnotation * annotation = [[WeiboAnnotation alloc] init];
        
        annotation.weiboModel = weiboModel;
        
        [_mapView addAnnotation:annotation];
        
    }
    

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
