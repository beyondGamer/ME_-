//
//  MoreViewController.m
//  ME_微博_CZL
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "MoreViewController.h"
#import "ThemeLabel.h"
@interface MoreViewController (){

    __weak IBOutlet ThemeImageView *_icon1;

    __weak IBOutlet ThemeImageView *_icon2;
    __weak IBOutlet ThemeImageView *_icon3;
    __weak IBOutlet ThemeImageView *_icon4;
   
    __weak IBOutlet ThemeLabel *_themeLabel;
    __weak IBOutlet ThemeLabel *_label6;
    __weak IBOutlet ThemeLabel *_label5;
    __weak IBOutlet ThemeLabel *_label4;
    __weak IBOutlet ThemeLabel *_label3;
    __weak IBOutlet ThemeLabel *_label2;
    __weak IBOutlet ThemeLabel *_label1;
}

@end

@implementation MoreViewController
-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    
    
    
    
    ThemeManager * manager = [ThemeManager shareManage];
    _themeLabel.text = manager.currentKeyName;
    _label1.colorName = @"More_Item_Text_color";
    _label2.colorName = @"More_Item_Text_color";
    _label3.colorName = @"More_Item_Text_color";
    _label4.colorName = @"More_Item_Text_color";
    _label5.colorName = @"More_Item_Text_color";
    _label6.colorName = @"More_Item_Text_color";
    _themeLabel.colorName = @"More_Item_Text_color";
    
    
    ThemeImageView * imgView = [[ThemeImageView alloc]initWithFrame:self.view.bounds];
    imgView.ImageName = @"bg_detail.jpg";
    
    [self.view insertSubview:imgView atIndex:0];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"更多";
    
    _icon1.ImageName = @"more_icon_theme.png";
    _icon2.ImageName = @"more_icon_queue.png";
    _icon3.ImageName = @"more_icon_draft.png";
    _icon4.ImageName = @"more_icon_about.png";
    
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
