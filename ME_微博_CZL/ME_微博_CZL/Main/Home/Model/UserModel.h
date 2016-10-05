//
//  UserModel.h
//  ME_微博_CZL
//
//  Created by user on 16/9/27.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *des;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSURL *profile_image_url;
@property (nonatomic, copy) NSString *avatar_large;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, retain) NSNumber *followers_count;
@property (nonatomic, retain) NSNumber *friends_count;
@property (nonatomic, retain) NSNumber *statuses_count;
@property (nonatomic, retain) NSNumber *favorites_count;
@property (nonatomic, retain) NSNumber *verified;

@end
