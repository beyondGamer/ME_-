//
//  DiscoverViewController.m
//  ME_微博_CZL
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "DiscoverViewController.h"
#import "NearByWeibo.h"


@interface DiscoverViewController (){


}

@end

@implementation DiscoverViewController
- (IBAction)nearByman:(UIButton *)sender {
    NearByWeibo * nearBy = [[NearByWeibo alloc] init];
    
    [self.navigationController pushViewController:nearBy animated:YES];
    self.hidesBottomBarWhenPushed = YES;

}
- (IBAction)nearByWeibo:(UIButton *)sender {
}
-(void)awakeFromNib {
    [super awakeFromNib];
    

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
