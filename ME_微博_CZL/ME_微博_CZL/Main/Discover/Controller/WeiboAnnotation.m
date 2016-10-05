//
//  WeiboAnnotation.m
//  ME_微博_CZL
//
//  Created by user on 16/10/4.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "WeiboAnnotation.h"

@implementation WeiboAnnotation

-(void)setWeiboModel:(WeiboModel *)weiboModel {

    _weiboModel = weiboModel;
    
    NSDictionary * geo = weiboModel.geo;
    
    NSArray * array = geo[@"coordinates"];
    
    if (array.count == 2) {
        double lat = [[array firstObject] doubleValue];
        double lon = [[array lastObject] doubleValue];
        
        _coordinate = CLLocationCoordinate2DMake(lat, lon);
        
    }

}
@end
