//
//  ThemeImageView.m
//  ME_微博_CZL
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "ThemeImageView.h"

@implementation ThemeImageView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.leftCapWidth = 0;
        self.topCapWidth = 0;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChange) name:KThemeChangeName object:nil];
        
    }
    return self;
}

- (void)awakeFromNib {
    self.leftCapWidth = 0;
    self.topCapWidth = 0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChange) name:KThemeChangeName object:nil];

}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void)setImageName:(NSString *)ImageName{
    _ImageName = [ImageName copy];
    [self themeChange];

}
- (void)themeChange {
    ThemeManager * themeManager = [ThemeManager shareManage];

  //  self.image = [themeManager themeManagerImgName:_ImageName];
    UIImage *image = [themeManager themeManagerImgName:_ImageName];
   UIImage * imageChanged = [image stretchableImageWithLeftCapWidth:_leftCapWidth topCapHeight:_topCapWidth];
    self.image = imageChanged;

}
-(void)setLeftCapWidth:(CGFloat)leftCapWidth {
    _leftCapWidth = leftCapWidth;
    [self themeChange];
}
-(void)setTopCapWidth:(CGFloat)topCapWidth {
    _topCapWidth = topCapWidth;
    [self themeChange];
}
@end
