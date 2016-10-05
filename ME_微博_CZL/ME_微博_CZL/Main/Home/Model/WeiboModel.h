//
//  WeiboModel.h
//  ME_微博_CZL
//
//  Created by user on 16/9/27.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
#import "YYModel.h"
@interface WeiboModel : NSObject

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *idstr;


@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) NSNumber *reposts_count;

@property (nonatomic, strong) NSNumber *comments_count;

@property (nonatomic, strong) NSNumber *attiudes_count;

@property (nonatomic, strong) UserModel *user;

@property (nonatomic, strong) WeiboModel *retweeted_status;

@property (nonatomic, copy) NSURL *thumbnail_pic;

@property (nonatomic, copy) NSString *bmiddle_pic;

@property (nonatomic, copy) NSURL *original_pic;

@property (nonatomic, copy) NSArray *pic_urls;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSDictionary *geo;

- (instancetype)initWithDic:(NSDictionary *)_dic;

@end
