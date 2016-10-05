//
//  ThemeManager.m
//  ME_微博_CZL
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 wuxiang. All rights reserved.
//
#define KcurrentKeyName @"KcurrentKeyName"
#define KcurrentThemeName @"KcurrentThemeName"
#import "ThemeManager.h"
#import <UIKit/UIKit.h>
@implementation ThemeManager
+ (ThemeManager *)shareManage {
    static ThemeManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[super allocWithZone:nil]init];
            
        }
    });
    
    return manager;

}

- (instancetype) init {
    if (self = [super init]) {
        
        
        _currentThemeName = [[NSUserDefaults standardUserDefaults] objectForKey:KcurrentThemeName];
        if(_currentThemeName == nil){
        _currentThemeName = @"cat";
        }
        
        _currentKeyName = [[NSUserDefaults standardUserDefaults] objectForKey:KcurrentKeyName];
        
        if (_currentKeyName == nil) {
            _currentKeyName = @"猫爷";
        }
        
        NSString * fileName = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        
        _allTheme = [NSDictionary dictionaryWithContentsOfFile:fileName];
        
        
        
        [self _loadColorData];
    
    
    }
    return self;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self shareManage];

}
- (id)copy{
    return self;
}

- (void)setCurrentThemeName:(NSString *)currentThemeName {
    
//    if (!_allTheme[currentThemeName]) {
//        return;
//    }
    
    
    if (![_currentThemeName isEqualToString:currentThemeName]) {
        _currentThemeName = [currentThemeName copy];
        
        [self _loadColorData];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:KThemeChangeName object:nil];
    
        [[NSUserDefaults standardUserDefaults] setObject:_currentThemeName forKey:KcurrentThemeName];
        
       
    }
}
-(void)setCurrentKeyName:(NSString *)currentKeyName{
    if (![_currentKeyName isEqualToString:currentKeyName]) {
        _currentKeyName = [currentKeyName copy];
        
         [[NSUserDefaults standardUserDefaults] setObject:_currentKeyName forKey:KcurrentKeyName];
    }

}
- (UIImage *)themeManagerImgName:(NSString *)_imgName{
    NSString * imgName = [NSString stringWithFormat:@"Skins/%@/%@",_currentThemeName,_imgName];
    
    UIImage * _img = [UIImage imageNamed:imgName];
    
    return _img;

}

-(void)_loadColorData {
    NSString * file = [[NSBundle mainBundle] resourcePath];
    
    NSString * fileName = [NSString stringWithFormat:@"%@/%@/config.plist",file,_allTheme[_currentKeyName]];
    
    _ColorDic = [NSDictionary dictionaryWithContentsOfFile:fileName];
    

}
- (UIColor *)themeManagerColorName:(NSString *)_colorName{
    NSDictionary * colorDic = _ColorDic[_colorName];
    if (colorDic == nil) {
        return [UIColor blackColor];
    }
    CGFloat red = [colorDic[@"R"] doubleValue];
    CGFloat greed = [colorDic[@"G"] doubleValue];
    CGFloat blue = [colorDic[@"B"] doubleValue];
    
    
    UIColor * color = [UIColor colorWithRed:red/255 green:greed/255 blue:blue/255 alpha:1];
    
    
    return color;
    
    
}
@end
