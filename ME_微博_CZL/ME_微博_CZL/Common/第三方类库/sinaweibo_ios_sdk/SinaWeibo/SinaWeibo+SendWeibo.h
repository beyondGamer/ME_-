//
//  SinaWeibo+SendWeibo.h
//  ME_微博_CZL
//
//  Created by user on 16/10/4.
//  Copyright © 2016年 wuxiang. All rights reserved.
//
//https://api.weibo.com/2/statuses/update.json
//https://upload.api.weibo.com/2/statuses/upload.json
#import "SinaWeibo.h"

typedef void(^SendWeiboSuccessBlock)(id result);
typedef void(^SendWeiboFailBlock)(NSError *error);

@interface SinaWeibo (SendWeibo)
- (void)SendWeiboText:(NSString * )text image:(UIImage *)img params:(NSDictionary *)params success:(SendWeiboSuccessBlock)success fail:(SendWeiboFailBlock)fail;
@end
