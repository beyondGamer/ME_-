//
//  SinaWeibo+SendWeibo.m
//  ME_微博_CZL
//
//  Created by user on 16/10/4.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "SinaWeibo+SendWeibo.h"
#import "AFNetworking.h"
@implementation SinaWeibo (SendWeibo)
- (void)SendWeiboText:(NSString *)text image:(UIImage *)img params:(NSDictionary *)params success:(SendWeiboSuccessBlock)success fail:(SendWeiboFailBlock)fail {


    NSMutableDictionary *mDic = [params mutableCopy];
    
    [mDic setObject:self.accessToken forKey:@"access_token"];
    [mDic setObject:text forKey:@"status"];
    
    if (img) {
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
       [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:mDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
           NSData * ImgData = UIImageJPEGRepresentation(img, 0.8);
           
           [formData appendPartWithFileData:ImgData name:@"pic" fileName:@"image.jpg" mimeType:@"image/jpeg"];
       } success:^(NSURLSessionDataTask *task, id responseObject) {
           if (success) {
               success(responseObject);
           }
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           if (fail) {
               fail(error);
           }
       }];
        
        
        
        
        
    }else {
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:mDic success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (fail) {
                fail(error);
            }
        }];
    
    }




}


@end
