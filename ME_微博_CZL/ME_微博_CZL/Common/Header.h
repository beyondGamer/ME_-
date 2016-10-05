//
//  Header.h
//  ME_微博_CZL
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 wuxiang. All rights reserved.
//
#ifndef Header_h
#define Header_h
//-----------------------header------------------
#import "SinaWeibo.h"
#import "ThemeManager.h"
#import "UserModel.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"
#import "RegexKitLite.h"
#import "UIViewExt.h"
#import "AppDelegate.h"
//-----------------------宏定义-------------------


#define KScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define KscreenHeight ([UIScreen mainScreen].bounds.size.height)

#define KSystemVersion ([[UIDevice currentDevice].systemVersion floatValue])

#define kSinaWeibo (((AppDelegate *)[UIApplication sharedApplication].delegate).sinaWeibo)

//微博字体大小
#define KweiboFont [UIFont systemFontOfSize:16]
//转发微博字体大小
#define KReweiboFont [UIFont systemFontOfSize:14]

#define KThemeChangeName @"KThemeChangeName"
#endif /* Header_h */



