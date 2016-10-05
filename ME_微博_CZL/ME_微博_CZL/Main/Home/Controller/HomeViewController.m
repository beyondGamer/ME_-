//
//  HomeViewController.m
//  ME_微博_CZL
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "WeiboModel.h"
#import "YYModel.h"
#import "UserModel.h"
#import "WeiboCell.h"
#import "TableCellLayout.h"
#import "WXRefresh.h"

#import <AVFoundation/AVFoundation.h>

@class WeiboModel;
@class TableCellLayout;

#define kWeibotime_lineAPI @"statuses/home_timeline.json"
@interface HomeViewController ()<SinaWeiboRequestDelegate,UITableViewDelegate,UITableViewDataSource>{

    NSMutableArray * _weiboArr;
    UITableView *_table;
    ThemeImageView * _notiImg;
    UILabel * _notiLabel;
    
    SystemSoundID  _soudId;
}

@end

@implementation HomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWeiboData];
    
    [self _createtable];
    
    NSURL * fileUrl = [[NSBundle mainBundle] URLForResource:@"msgcome" withExtension:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileUrl, &_soudId);
    
    
    
    // Do any additional setup after loading the view.
}

-(void)dealloc {
    AudioServicesRemoveSystemSoundCompletion(_soudId);
}
- (void)_createtable {
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KscreenHeight - 49 - 64) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.backgroundColor = [UIColor clearColor];
    
   
    
    [self.view addSubview:_table];
    UINib * nib = [UINib nibWithNibName:@"WeiboCell" bundle:[NSBundle mainBundle]];
    [_table registerNib:nib forCellReuseIdentifier:@"WeiboCell"];
    
    __weak HomeViewController * weakSelf = self;
    
    [_table addPullDownRefreshBlock:^{
      __strong  HomeViewController * strongSelf = weakSelf;
        [strongSelf loadNewData];
    }];
    
    [_table addInfiniteScrollingWithActionHandler:^{
        __strong HomeViewController * strongSelf = weakSelf;
        [strongSelf loadOldData];
    }];
    
    
   
    _notiImg = [[ThemeImageView alloc] initWithFrame:CGRectMake(3, 3, KScreenWidth - 6, 40)];
    _notiImg.ImageName = @"timeline_notify.png";
    
    _notiImg.transform = CGAffineTransformMakeTranslation(0, -60);
    [self.view addSubview:_notiImg];
    
    _notiLabel = [[UILabel alloc] initWithFrame:_notiImg.bounds];
    
    _notiLabel.textAlignment = NSTextAlignmentCenter;
    
    _notiLabel.text = @"8条微博";
    
    [_notiImg addSubview:_notiLabel];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _weiboArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WeiboCell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.weibomodel = _weiboArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboModel * model = _weiboArr[indexPath.row];
   /* CGRect rect = [model.text boundingRectWithSize:CGSizeMake(KScreenWidth-20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : KweiboFont} context:nil];
    CGFloat height = rect.size.height;
    
    CGFloat imgHeight = 0;
    
    if (model.bmiddle_pic) {
        imgHeight = 210;
    }else {
        imgHeight = 0;
    }
    */
    
    TableCellLayout *layout = [TableCellLayout LayOutWithModel:model];
    
    
    return [layout cellHeight];
}
- (void)loadWeiboData {
    SinaWeibo * weibo = kSinaWeibo;
    if (![weibo isAuthValid]) {
        [weibo logIn];
        return;
    }
    NSDictionary * dic = @{@"count" : @"30"};
    
   SinaWeiboRequest * request =  [weibo requestWithURL:kWeibotime_lineAPI params:[dic mutableCopy] httpMethod:@"GET" delegate:self];
    
    request.tag = 0;
}

-(void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    //NSLog(@"%@",result);
    NSArray * array = result[@"statuses"];
    NSMutableArray * mArray = [NSMutableArray array];
    
    
    for (NSDictionary *dic in array) {
        
        WeiboModel *weibomodel = [WeiboModel yy_modelWithJSON:dic];
        
        [mArray addObject:weibomodel];
        
      //  NSLog(@"--------------------------------%@",weibomodel.retweeded_status);
//        NSLog(@"%@:%@",weibomodel.user.name,weibomodel.text);
        
    }
    if (request.tag == 0) {
        _weiboArr = [mArray mutableCopy];
        [_table.pullToRefreshView stopAnimating];
    }else if (request.tag == 1) {
        if (mArray.count == 0) {
         
            [_table.pullToRefreshView stopAnimating];
            
            [self showView:mArray.count];
            return;
        }
        
        NSIndexSet * IndexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, mArray.count)];
        
        [_weiboArr insertObjects:mArray atIndexes:IndexSet];
        
        [_table.pullToRefreshView stopAnimating];
        
        //[self showView:mArray.count];
        
    }else {
        if (mArray.count == 0) {
            
            [_table.pullToRefreshView stopAnimating];
            
            return;
        }
        NSIndexSet * IndexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(_weiboArr.count-1, mArray.count)];
        
        [_weiboArr removeLastObject];
        [_weiboArr insertObjects:mArray atIndexes:IndexSet];
        
        [_table.pullToRefreshView stopAnimating];
    
    }
    
    
    [_table reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadNewData {
    
    WeiboModel * firstModel = [_weiboArr firstObject];
    NSString * idStr = firstModel.idstr;
    
    
    SinaWeibo * weibo = kSinaWeibo;
    
    if (![weibo isAuthValid]) {
        [weibo logIn];
        return;
    }
    NSDictionary * dic = @{@"count" : @"30",
                           @"since_id" : idStr};
    
    SinaWeiboRequest * requeset = [weibo requestWithURL:kWeibotime_lineAPI params:[dic mutableCopy] httpMethod:@"GET" delegate:self];
    requeset.tag = 1;

}
- (void)loadOldData {
    //max_id
    WeiboModel * lastModel = [_weiboArr lastObject];
    NSString * idStr = lastModel.idstr;
    
    SinaWeibo * weibo = kSinaWeibo;
    if (![weibo isAuthValid]) {
        [weibo logIn];
        return;
    }
    NSDictionary * dic = @{@"count" : @"30",
                           @"max_id" : idStr};
    SinaWeiboRequest * request = [weibo requestWithURL:kWeibotime_lineAPI params:[dic mutableCopy] httpMethod:@"GET" delegate:self];
    
    request.tag = 2;
}

- (void)showView:(NSUInteger)count {
    if (count == 0 ) {
        
        _notiLabel.text = @"没有新微博";
        
    }else {
        NSString * noti = [NSString stringWithFormat:@"%li条新微博",count];
        
       _notiLabel.text = noti;
    }
    [UIView animateWithDuration:.5 animations:^{
        _notiImg.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.5 delay:2 options:UIViewAnimationOptionLayoutSubviews animations:^{
            _notiImg.transform = CGAffineTransformMakeTranslation(0, -60);
        } completion:^(BOOL finished) {
            
        } ];
    }];
    
    AudioServicesPlaySystemSound(_soudId);

}
-(void)reloadNewTab {
    
    [_table.pullToRefreshView startAnimating];
    
    [self loadNewData];
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
