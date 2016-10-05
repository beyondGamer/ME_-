//
//  UserModel.m
//  ME_微博_CZL
//
//  Created by user on 16/9/27.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "UserModel.h"
#import "YYModel.h"
@implementation UserModel
+ (NSDictionary *)modelCustomPropertyMapper {
    NSDictionary *dic = @{
                          @"des" : @"description"
                          };
    return dic;

}
@end
