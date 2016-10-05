//
//  ThemeManager.h
//  ME_微博_CZL
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "ThemeButton.h"
#import "ThemeNavi.h"
@interface ThemeManager : NSObject
@property (nonatomic, copy)NSString * currentThemeName;
@property (nonatomic, copy)NSDictionary * allTheme;
@property (nonatomic, copy)NSString * currentKeyName;
@property (nonatomic, copy)NSDictionary * ColorDic;
+ (ThemeManager *)shareManage;
- (UIImage *)themeManagerImgName:(NSString *)_imgName;
- (UIColor *)themeManagerColorName:(NSString *)_colorName;
@end
