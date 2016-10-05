//
//  WeiboAnnotation.h
//  ME_微博_CZL
//
//  Created by user on 16/10/4.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface WeiboAnnotation : NSObject<MKAnnotation>
@property (nonatomic, readonly)CLLocationCoordinate2D coordinate;

@property (nonatomic, readonly , copy ,nullable)NSString * title;
@property (nonatomic, readonly ,copy ,nullable)NSString * subtitle;

@property (nonatomic, nullable , strong)WeiboModel * weiboModel;
@end
