//
//  AppDelegate.h
//  ME_微博_CZL
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SinaWeibo *sinaWeibo;
- (void)logoutWeibo;
@end

