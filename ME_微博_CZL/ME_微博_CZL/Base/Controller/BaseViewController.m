//
//  BaseViewController.m
//  ME_微博_CZL
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController
-(void)viewDidLoad{
    ThemeImageView * imageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KscreenHeight)];
    imageView.ImageName = @"bg_detail.jpg";
    
    [self.view insertSubview:imageView atIndex:0];
    [self _createNaviItem];
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self _createNaviItem];

}
-(void)_createNaviItem{
    
    if (self.navigationController.viewControllers.count >=2){
    
        
        ThemeButton * button = [ThemeButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 44);
    button.imgName = @"titlebar_button_back_9.png";
    
        [button setTitle:@"返回" forState:UIControlStateNormal];
      
        [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = item;
    
    
    }

}

- (void)backAction:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];

}
@end
