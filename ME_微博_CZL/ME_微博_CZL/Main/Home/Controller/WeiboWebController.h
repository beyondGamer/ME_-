//
//  WeiboWebController.h
//  ME_微博_CZL
//
//  Created by user on 16/10/2.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "BaseViewController.h"

@interface WeiboWebController : BaseViewController
@property (nonatomic, strong)NSURL *url;
- (instancetype)initWithURL:(NSURL *)url;
@end
