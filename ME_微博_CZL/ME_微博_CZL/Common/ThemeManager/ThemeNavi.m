//
//  ThemeNavi.m
//  ME_微博_CZL
//
//  Created by user on 16/9/22.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "ThemeNavi.h"

@interface ThemeNavi ()

@end

@implementation ThemeNavi

- (void)viewDidLoad {
    [super viewDidLoad];
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChange) name:KThemeChangeName object:nil];
    // Do any additional setup after loading the view.
}
-(void)awakeFromNib{
[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChange) name:KThemeChangeName object:nil];
}
-(void)setImgName:(NSString *)imgName{

    _imgName = [imgName copy];
    
    [self themeChange];
    


}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)themeChange {
    ThemeManager * themeManager = [ThemeManager shareManage];
    
    [self.navigationBar setBackgroundImage:[themeManager themeManagerImgName:_imgName] forBarMetrics:UIBarMetricsDefault];

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
