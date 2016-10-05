//
//  WeiboCell.h
//  ME_微博_CZL
//
//  Created by user on 16/9/28.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXPhotoBrowser.h"
@class TableCellLayout;
@class ThemeLabel;
@class ThemeImageView;
#import "WXLabel.h"

@interface WeiboCell : UITableViewCell<WXLabelDelegate,PhotoBrowerDelegate> {

    __weak IBOutlet UIImageView *_profile_Image;
    __weak IBOutlet ThemeLabel *_userName;
   
    __weak IBOutlet ThemeLabel *_time;
    __weak IBOutlet ThemeLabel *_source;
    TableCellLayout * layout;

}

@property (nonatomic, strong)WeiboModel *weibomodel;
@property (nonatomic, strong)WXLabel *weiboTextLabel;
@property (nonatomic, strong)UITextView * text;
@property (nonatomic, strong)UIImageView * weiboImg;

@property (nonatomic, strong)WXLabel *reWeiboTextLabel;
@property (nonatomic, strong)ThemeImageView *reBGImg;

@property (nonatomic, strong)NSArray *nineArr;

@end
