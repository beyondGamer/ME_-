//
//  ThemeButton.m
//  ME_微博_CZL
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "ThemeButton.h"

@implementation ThemeButton
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:KThemeChangeName object:nil];
        
    }
    return self;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)awakeFromNib {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:KThemeChangeName object:nil];
}
- (void)themeChange{
    ThemeManager *manager = [ThemeManager shareManage];
    
    [self setImage:[manager themeManagerImgName:_imgName] forState:UIControlStateNormal];
    [self setBackgroundImage:[manager themeManagerImgName:_bgImgName] forState:UIControlStateNormal];
    
    
    
}

-(void)setImgName:(NSString *)imgName{
    _imgName = [imgName copy];
    [self themeChange];
}
-(void)setBgImgName:(NSString *)bgImgName{
    _bgImgName = [bgImgName copy];
    [self themeChange];
}
@end
