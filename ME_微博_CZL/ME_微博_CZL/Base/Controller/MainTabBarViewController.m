//
//  MainTabBarViewController.m
//  ME_微博_CZL
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "MainTabBarViewController.h"

@interface MainTabBarViewController (){
    ThemeImageView * _SelectImg;
}

@end

@implementation MainTabBarViewController

- (instancetype)init{

    self = [super init];
    if (self) {
        [self _createSubViewController];
        
        [self _createTabBarItem];
    }
    return self;
}
#pragma mark - 创建子控制器
- (void)_createSubViewController{

    ThemeImageView * imgView = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, -5, KScreenWidth, 54)];
    imgView.ImageName = @"mask_navbar.png";
    
//    self.tabBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Skins/cat/mask_navbar@2x"]];
    
    [self.tabBar insertSubview:imgView atIndex:0];
    
    self.tabBar.shadowImage = [[UIImage alloc]init];
    
    NSMutableArray * navigationName = [NSMutableArray array];
    NSArray * storyBordName = @[@"Home",@"Message",@"Discover",@"Profile",@"More"];
    for (NSString * sbName in storyBordName) {
        
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:sbName bundle:[NSBundle mainBundle]];
        
        UINavigationController *navigation = [storyboard instantiateInitialViewController];
        
        [navigationName addObject:navigation];
    }

    self.viewControllers = [navigationName copy];

}

#pragma mark - 创建标签栏按钮
- (void)_createTabBarItem{
    Class cls = NSClassFromString(@"UITabBarButton");
    
    for (UIView * view in self.tabBar.subviews) {
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }

    _SelectImg  = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth / 5, 49)];
    
    _SelectImg.ImageName = @"home_bottom_tab_arrow@2x";
    
    [self.tabBar insertSubview:_SelectImg atIndex:1];
    
    for (int i = 0; i < 5; i++) {
        ThemeButton * button = [ThemeButton buttonWithType:UIButtonTypeCustom];
        
        CGRect frame = CGRectMake(KScreenWidth/5 * i, 0, KScreenWidth/5, 49);
        button.frame = frame;
        
        NSString * btnImg = [NSString stringWithFormat:@"home_tab_icon_%i@2x",i + 1];
        
        button.imgName = btnImg;
        
        button.tag =  100 + i;
        
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar addSubview:button];
       
        if (i == 0) {
            _SelectImg.center = button.center;
        }
        
        
    }
    
    
    
    
}

- (void)btnAction:(UIButton *)button{
    self.selectedIndex = button.tag - 100;
    _SelectImg.center = button.center;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
