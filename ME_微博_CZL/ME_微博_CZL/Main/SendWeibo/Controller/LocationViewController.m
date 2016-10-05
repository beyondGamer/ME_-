//
//  LocationViewController.m
//  ME_微博_CZL
//
//  Created by user on 16/10/3.
//  Copyright © 2016年 wuxiang. All rights reserved.
//
#define kLocationAPI @"place/nearby/pois.json"
#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
@interface LocationViewController ()<CLLocationManagerDelegate,SinaWeiboRequestDelegate,UITableViewDelegate,UITableViewDataSource>{
    CLLocationManager * _locationManager;
    
    NSArray * _locationArray;
    
    UITableView * _table;
}

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startloction];
    [self _createTable];
   
    self.title = @"周边地点";
    
    
    // Do any additional setup after loading the view.
}
- (void)_createTable {
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KscreenHeight - 64) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_table];

}
#pragma mark --TableCell 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _locationArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    NSDictionary * dic = _locationArray[indexPath.row];
    
    cell.textLabel.text = dic[@"title"];
    if (![dic[@"address"] isKindOfClass:[NSNull class]]) {
        cell.detailTextLabel.text = dic[@"address"];
        
    }
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"icon"]]];
    return cell;
}




- (void)startloction {
    
    _locationManager = [[CLLocationManager alloc] init];
    
    if (KSystemVersion >= 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    _locationManager.delegate = self;
    
    [_locationManager startUpdatingLocation];
    
    
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    [_locationManager stopUpdatingLocation];
    
    CLLocation * location = [locations firstObject];
    
    double lon = location.coordinate.longitude;
    
    double lat = location.coordinate.latitude;
    
    SinaWeibo * wb = kSinaWeibo;
    NSDictionary * parmas = @{@"long" : [NSString stringWithFormat:@"%f",lon],@"lat" : [NSString stringWithFormat:@"%f",lat]};
    
    [wb requestWithURL:kLocationAPI params:[parmas mutableCopy] httpMethod:@"GET" delegate:self];
    
    
    
    
    
    

}
-(void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    
    _locationArray = result[@"pois"];
    
    [_table reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_block) {
        _block(_locationArray[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addLocationResultBlock:(LocationResultBlock)block {
    _block = [block copy];
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
