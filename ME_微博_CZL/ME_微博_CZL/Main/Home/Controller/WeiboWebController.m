//
//  WeiboWebController.m
//  ME_微博_CZL
//
//  Created by user on 16/10/2.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "WeiboWebController.h"

@interface WeiboWebController ()

@end

@implementation WeiboWebController

- (instancetype)initWithURL:(NSURL *)url {
    if (self = [super init]) {
        self.url = url;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KscreenHeight-64)];
    
    [self.view addSubview:webView];
    
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:self.url];
    
    [webView loadRequest:request];
    
    [self _createBtn];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)_createBtn{
    
    
    ThemeButton * button = [[ThemeButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    button.imgName = @"titlebar_button_back_9.png";
    
    //    [button setTitle:@"返回" forState:UIControlStateNormal];
    //    button.titleLabel.text = @"返回";
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * text = [[UILabel alloc]initWithFrame:CGRectMake(13, 0, 60, 44)];
    text.text = @"返回";
    text.textColor = [UIColor whiteColor];
    text.backgroundColor = [UIColor clearColor];
    
    [button addSubview:text];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
    //    [item setTitle:@"返回"];
    
    self.navigationItem.leftBarButtonItem = item;
}
- (void)backAction:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
    
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
