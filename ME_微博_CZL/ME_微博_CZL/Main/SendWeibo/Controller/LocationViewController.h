//
//  LocationViewController.h
//  ME_微博_CZL
//
//  Created by user on 16/10/3.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^LocationResultBlock)(NSDictionary *result);
@interface LocationViewController : BaseViewController

@property (nonatomic, copy)LocationResultBlock block;



- (void)addLocationResultBlock:(LocationResultBlock)block;
@end
