//
//  BaseNavigation.m
//  ME_微博_CZL
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "BaseNavigation.h"

@interface BaseNavigation ()

@end

@implementation BaseNavigation

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    CGFloat systemVersion = [[UIDevice currentDevice].systemVersion floatValue];
    
    if (KSystemVersion > 7.0) {
//        ThemeImageView * imgView = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 64)];
//        imgView.ImageName = @"mask_titlebar64@2x";
//        [self.navigationBar insertSubview:imgView atIndex:1];
//
//        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"Skins/cat/mask_titlebar64@2x"] forBarMetrics:UIBarMetricsDefault];
        
        self.imgName = @"mask_titlebar64@2x";
    }else{
//        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"Skins/cat/mask_titlebar@2x"] forBarMetrics:UIBarMetricsDefault];

        
//                ThemeImageView * imgView = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 44)];
//        imgView.ImageName = @"mask_titlebar@2x";
//        [self.navigationBar insertSubview:imgView atIndex:1];
    self.imgName = @"mask_titlebar@2x";
    }
    
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:25],NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    self.navigationBar.shadowImage = [[UIImage alloc]init];
    
    self.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
}
- (UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
