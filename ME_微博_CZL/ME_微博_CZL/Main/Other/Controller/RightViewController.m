//
//  RightViewController.m
//  ME_微博_CZL
//
//  Created by user on 16/9/26.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "RightViewController.h"
#import "SendWeiboController.h"
#import "BaseNavigation.h"
#import "UIViewController+MMDrawerController.h"
@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ThemeImageView * bgImg = [[ThemeImageView alloc] initWithFrame:self.view.bounds];
    
    bgImg.ImageName = @"mask_bg.jpg";
    
    [self.view insertSubview:bgImg atIndex:0];
    
    
    [self _createBtn];
    // Do any additional setup after loading the view.
}
- (void)_createBtn {
    CGFloat space = 15;
    CGFloat btnWidth = 50;
    for (int i = 0; i <= 4; i++) {
        CGRect frame = CGRectMake(space,i * (space + btnWidth), btnWidth, btnWidth);
        ThemeButton * btn = [ThemeButton buttonWithType:UIButtonTypeCustom];
        btn.frame = frame;
        //btn.backgroundColor = [UIColor orangeColor];
        btn.tag = i + 100;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString * imgName = [NSString stringWithFormat:@"newbar_icon_%i.png", i+1];
        
        btn.imgName = imgName;
        [self.view addSubview:btn];
    }

    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mapButton.frame = CGRectMake(space, 0, btnWidth, btnWidth);
    
    [mapButton setImage:[UIImage imageNamed:@"btn_map_location"] forState:UIControlStateNormal];
    //mapButton.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:mapButton];
    
    UIButton *qrButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    qrButton.frame = CGRectMake(space, 0, btnWidth, btnWidth);
    
    [qrButton setImage:[UIImage imageNamed:@"qr_btn"] forState:UIControlStateNormal];
    
    //qrButton.backgroundColor = [UIColor blueColor];
    [self.view addSubview:qrButton];
    
    qrButton.bottom = KscreenHeight -64 -space;
    
    mapButton.bottom = qrButton.top ;
    
}
- (void)btnClick:(UIButton *)btn {
    if (btn.tag == 100) {
        SendWeiboController * sendWeibo = [[SendWeiboController alloc] init];
        BaseNavigation * navi = [[BaseNavigation alloc] initWithRootViewController:sendWeibo];
        [self presentViewController:navi animated:YES completion:^{
            MMDrawerController * mmd = self.mm_drawerController;
            [mmd closeDrawerAnimated:YES
                          completion:nil];
        }];
    }

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
