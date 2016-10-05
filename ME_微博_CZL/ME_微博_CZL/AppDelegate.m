//
//  AppDelegate.m
//  ME_微博_CZL
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 wuxiang. All rights reserved.
//
#define kWeiboAuthDateKey @"kWeiboAuthDateKey"
#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "BaseNavigation.h"

#import "MMDrawerController.h"
@interface AppDelegate ()<SinaWeiboDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
     self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.window makeKeyAndVisible];
    
    MainTabBarViewController * table = [[MainTabBarViewController alloc]init];
    
   
    LeftViewController * leftVC = [[LeftViewController alloc] init];
    
    RightViewController * rightVC = [[RightViewController alloc] init];
    
    BaseNavigation * leftNa = [[BaseNavigation alloc] initWithRootViewController:leftVC];
    
    BaseNavigation * rightNa = [[BaseNavigation alloc] initWithRootViewController:rightVC];
    
    MMDrawerController * mmd = [[MMDrawerController alloc] initWithCenterViewController:table leftDrawerViewController:leftNa rightDrawerViewController:rightNa];
    
    mmd.maximumLeftDrawerWidth = 180;
    mmd.maximumRightDrawerWidth = 80;
    
    [mmd setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [mmd setCloseDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    self.window.rootViewController = mmd;
    
    
    
    
    
    _sinaWeibo = [[SinaWeibo alloc]initWithAppKey:@"1400740469" appSecret:@"8777409b6cd630ed831ffd57876c29de" appRedirectURI:@"http://www.baidu.com" andDelegate:self];
    
    
    BOOL isAuth = [self readAuthData];
    
    if (isAuth == NO) {
        [_sinaWeibo logIn];
    }else{
        NSLog(@"已登陆微博%@",_sinaWeibo.accessToken);
    }
    
    
    return YES;
}

//登陆成功
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo {

    [self _saveAuthData];
    
}
//注销
- (void)logoutWeibo {
    [_sinaWeibo logOut];

}
//注销之后
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kWeiboAuthDateKey];
    
    
}
//登陆取消
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo {

}

#pragma mark - 保持登陆状态
- (void)_saveAuthData {
    NSString * token = _sinaWeibo.accessToken;
    
    NSString * uid = _sinaWeibo.userID;
    
    NSDate * date = _sinaWeibo.expirationDate;
    
    NSUserDefaults * userDef = [NSUserDefaults standardUserDefaults];
    
    NSDictionary * dic = @{@"accesstoken" : token , @"uid" : uid , @"expirationdate" : date};
    
    [userDef setObject:dic forKey:kWeiboAuthDateKey];
    
    [userDef synchronize];
    
}

- (BOOL)readAuthData{
    
    NSUserDefaults * urserDef = [NSUserDefaults standardUserDefaults];
    
    NSDictionary * dic = [urserDef objectForKey:kWeiboAuthDateKey];
    
    if (dic == nil) {
        return NO;
    }
    
    NSString * token = dic[@"accesstoken"];
    
    NSString * uid = dic[@"uid"];
    
    NSDate * date = dic[@"expirationdate"];
    
    if (token == nil || uid == nil || date == nil) {
        return NO;
    }
    
    _sinaWeibo.accessToken = token;
    
    _sinaWeibo.userID = uid;
    
    _sinaWeibo.expirationDate = date;
    
   
    
    return YES;
    
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
