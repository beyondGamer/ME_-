//
//  ThemeLabel.m
//  ME_微博_CZL
//
//  Created by user on 16/9/26.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "ThemeLabel.h"

@implementation ThemeLabel
-(instancetype)initWithFrame:(CGRect)frame{
   self =  [super initWithFrame:frame];
    if (self) {
        _colorName=[NSString string];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeColorChange) name:KThemeChangeName object:nil];
    }
    return self;
}
-(void)awakeFromNib {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeColorChange) name:KThemeChangeName object:nil];
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)setColorName:(NSString *)colorName {
    _colorName = [colorName copy];
    [self themeColorChange];

}

- (void)themeColorChange {
    ThemeManager *manager = [ThemeManager shareManage];
    
    self.textColor = [manager themeManagerColorName:_colorName];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
