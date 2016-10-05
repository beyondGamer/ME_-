//
//  SendWeiboController.m
//  ME_微博_CZL
//
//  Created by user on 16/10/3.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#define kSendAPI @"statuses/update.json"
#define kSendWithImgAPI @"statuses/upload.json"

#define kToolViewHeight 40
#define kLocationHeight 30

#import "SendWeiboController.h"
#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "HomeViewController.h"
#import "LocationViewController.h"
#import "SinaWeibo+SendWeibo.h"
#import "MBProgressHUD.h"


@interface SendWeiboController ()<SinaWeiboRequestDelegate>{
    UITextView * _inputText;
    UIView * _toolView;
    
    UIView * _LocationView;
    ThemeImageView * _LocationIconImg;
    UILabel * _LoctionLabel;
    ThemeButton * _CanceBtn;
    
}
@property (nonatomic,copy)NSDictionary * blocDic;
@end

@implementation SendWeiboController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _creatItem];
    
    [self _createInputText];
    
    [self _createToolView];
    
    [self _createLocationView];
    
    
    self.title = @"写微博";
    // Do any additional setup after loading the view.
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)_createInputText {
    _inputText = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KscreenHeight-64- kToolViewHeight)];
    _inputText.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_inputText];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyChanged:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyEnd:) name:UIKeyboardDidHideNotification object:nil];
}
- (void)_createToolView {
    _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, KscreenHeight - kToolViewHeight - 64, KScreenWidth, kToolViewHeight)];
    _toolView.backgroundColor = [UIColor clearColor];
    
    for (int i = 0; i < 5; i++) {
        ThemeButton * button = [[ThemeButton alloc] initWithFrame:CGRectMake(i *(KScreenWidth / 5), 0, KScreenWidth /5, kToolViewHeight)];
        if (i == 0) {
            button.imgName = @"compose_toolbar_1.png";
            //button.backgroundColor = [UIColor redColor];
            
        }else if (i == 1){
        button.imgName = @"compose_toolbar_3.png";
        }else{
        button.imgName = [NSString stringWithFormat:@"compose_toolbar_%i.png",i+2];
        }
            button.tag = 100 + i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_toolView addSubview:button];
    }
    
    
    [self.view addSubview:_toolView ];

}
- (void)btnClick:(UIButton *)btn {
    if (btn.tag == 100 + 4) {
        
        LocationViewController * location = [[LocationViewController alloc] init];
        [location addLocationResultBlock:^(NSDictionary *result) {
            //NSLog(@"获取到地点 : %@",result);
            
            self.blocDic = result;
        }];
        
        [self.navigationController pushViewController:location animated:YES];
    }
}
- (void)_creatItem {
    ThemeButton * leftButton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 60, 44);
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    leftButton.bgImgName = @"titlebar_button_9.png";
    
    [leftButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = item;
    
    ThemeButton * rightButton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    
    rightButton.frame = CGRectMake(0, 0, 60, 44);
    [rightButton setTitle:@"发送" forState:UIControlStateNormal];
    rightButton.bgImgName = @"titlebar_button_9.png";
    [rightButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rItem;


}
- (void)backClick:(UIButton *)btn {

[self dismissViewControllerAnimated:YES
                         completion:nil];
}

- (void)sendMessage:(UIButton *)btn {
    NSString * text = [_inputText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"发送内容不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    SinaWeibo * weibo = kSinaWeibo;
    NSMutableDictionary * params = [@{@"status" : text} mutableCopy];
    
    if(self.blocDic) {
        NSString * lon = self.blocDic[@"lon"];
        NSString * lat = self.blocDic[@"lat"];
        
        [params setObject:lon forKey:@"long"];
        [params setObject:lat forKey:@"lat"];
    
    }
    MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:self.view.window];
    [self.view.window addSubview:hud];
    
    
    hud.labelText = @"正在发送";
    
    hud.dimBackground = YES;
    
    [hud show:YES];
    //[weibo requestWithURL:kSendAPI params:params httpMethod:@"POST" delegate:self];
   /*
    MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:self.view.window];
    [self.view.window addSubview:hud];
    hud.labelText = @"正在发送";
    hud.dimBackground = YES;
    [hud show:YES];
    
    */
    
    [weibo SendWeiboText:text image:nil params:params success:^(id result) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"发送成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        [_inputText resignFirstResponder];
        
        [self dismissViewControllerAnimated:YES completion:^{
            UIApplication * app = [UIApplication sharedApplication];
            AppDelegate * appdelegate = (AppDelegate *)app.delegate;
            MMDrawerController * mmd = (MMDrawerController *)appdelegate.window.rootViewController;
            
            UITabBarController * tabbar = (UITabBarController *)mmd.centerViewController;
            
            UINavigationController * navi = [tabbar.viewControllers firstObject];
            
            HomeViewController * home = (HomeViewController *)[navi topViewController];
            
            [home reloadNewTab];
            
            
            
            
            [hud hide:YES];
            
            
            
            
            
            
        }];
    } fail:^(NSError *error) {
        /*hud.labelText = @"发送失败";
        [hud hide:YES afterDelay:1.5];*/
    }];
/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"发送成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];*/
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)keyChanged:(NSNotification *)noti {
    
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
  [UIView animateWithDuration:.3 animations:^{
      _inputText.frame = CGRectMake(0, 0, KScreenWidth,rect.origin.y - kToolViewHeight-64);
      _toolView.frame = CGRectMake(0, rect.origin.y - kToolViewHeight-64 ,KScreenWidth, kToolViewHeight);
      
      _LocationView.bottom = _toolView.top;
  }];
    
    
   

}
- (void)keyEnd:(NSNotification *)noti {
   [UIView animateWithDuration:.3 animations:^{
 _inputText = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KscreenHeight-64- kToolViewHeight)];
    _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, KscreenHeight - kToolViewHeight - 64, KScreenWidth, kToolViewHeight)];
}];

}
/*
-(void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse * httprespose = (NSHTTPURLResponse *)response;
    if (httprespose.statusCode == 200) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"发送成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        [_inputText resignFirstResponder];
        
        [self dismissViewControllerAnimated:YES completion:^{
            UIApplication * app = [UIApplication sharedApplication];
            AppDelegate * appdelegate = (AppDelegate *)app.delegate;
            MMDrawerController * mmd = (MMDrawerController *)appdelegate.window.rootViewController;
            
            UITabBarController * tabbar = (UITabBarController *)mmd.centerViewController;
            
            UINavigationController * navi = [tabbar.viewControllers firstObject];
            
            HomeViewController * home = (HomeViewController *)[navi topViewController];
            
            [home reloadNewTab];
        }];
    }


}
*/
- (void)_createLocationView {
    _LocationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kLocationHeight)];
    //_LocationView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_LocationView];
    _LocationView.bottom = _toolView.top;
    
    _LocationIconImg = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, kLocationHeight, kLocationHeight)];
    //_LocationIconImg.backgroundColor = [UIColor grayColor];
   
    [_LocationView addSubview:_LocationIconImg];
    
    _LoctionLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLocationHeight + 5, 0, 100, kLocationHeight)];
   // _LoctionLabel.backgroundColor = [UIColor redColor];
    
    [_LocationView addSubview:_LoctionLabel];
    
    _CanceBtn = [ThemeButton buttonWithType:UIButtonTypeCustom];
    _CanceBtn.frame = CGRectMake(0, 0, kLocationHeight, kLocationHeight);
    _CanceBtn.left = _LoctionLabel.right + 5;
    //_CanceBtn.backgroundColor = [UIColor blueColor];
    _CanceBtn.imgName = @"compose_toolbar_clear.png";
    
    [_CanceBtn addTarget:self action:@selector(CanceBtn) forControlEvents:UIControlEventTouchUpInside];
    [_LocationView addSubview:_CanceBtn];
    
    _LocationView.hidden = YES;
}

- (void)CanceBtn {
    _LocationView.hidden = YES;

}

-(void)setBlocDic:(NSDictionary *)blocDic {
    if (_blocDic != blocDic ) {
        
        _blocDic = [blocDic copy];
        if (_blocDic == nil) {
            _LocationView.hidden = YES;
        }else {
            _LocationView.hidden = NO;
        
        
        
        _LoctionLabel.text = _blocDic[@"title"];
        
        [_LocationIconImg sd_setImageWithURL:[NSURL URLWithString:blocDic[@"icon"]]];
        
            
            CGRect rect = [_LoctionLabel.text boundingRectWithSize:CGSizeMake(KScreenWidth, kLocationHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil];
            
            
            _LoctionLabel.width = rect.size.width + 50;
            
            
            _CanceBtn.left = _LoctionLabel.right;
        
        }
    }

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
