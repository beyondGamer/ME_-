//
//  WeiboCell.m
//  ME_微博_CZL
//
//  Created by user on 16/9/28.
//  Copyright © 2016年 wuxiang. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "WeiboCell.h"
#import "GDataXMLNode.h"
#import "ThemeLabel.h"

#import "WXPhotoBrowser.h"
#import "WeiboWebController.h"
#import "TableCellLayout.h"
@class TableCellLayout;
@implementation WeiboCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:KThemeChangeName object:nil];
    
    [self themeChange];
    // Initialization code
}
- (void)themeChange {
    ThemeManager * manager = [ThemeManager shareManage];
    
    
   self.weiboTextLabel.textColor = [manager themeManagerColorName:@"More_Item_Text_color"];
    self.reWeiboTextLabel.textColor = [manager themeManagerColorName:@"More_Item_Text_color"];
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
#pragma mark----WXLabel
-(NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel {
    //需要添加链接字符串的正则表达式：@用户、http://、#话题#
    NSString *regex1 = @"@\\w+";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#\\w+#";
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
}
-(UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel {
    return [[ThemeManager shareManage] themeManagerColorName:@"Link_color"];
}
-(UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel {
    return [UIColor redColor];
}
-(void)toucheBenginWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context {

}

-(void)toucheEndWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context {
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    if ([context isMatchedByRegex:regex2]) {
        
    }
    
    NSURL * url = [NSURL URLWithString:context];
    
    WeiboWebController * WeiboWeb = [[WeiboWebController alloc] initWithURL:url];
    
    WeiboWeb.hidesBottomBarWhenPushed = YES;
    
    UIResponder * nextResponder = self.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            UINavigationController * navi = (UINavigationController *)nextResponder;
            [navi pushViewController:WeiboWeb animated:YES];
            break;
        }
        nextResponder = nextResponder.nextResponder;
    }

}

-(void)setWeibomodel:(WeiboModel *)weibomodel {
    
    for (UIImageView * vc in _nineArr) {
        vc.frame = CGRectZero;
    }
    
    _weibomodel = weibomodel;
    
    _userName.text = weibomodel.user.name;
    
    _userName.colorName = @"More_Item_Text_color";
    
//    _souce.text = weibomodel.source;
    
//    _time.text = weibomodel.created_at;
    
    [_profile_Image sd_setImageWithURL:weibomodel.user.profile_image_url placeholderImage:nil];
    
//    if (weibomodel.source.length != 0) {
//        NSArray * array1 = [weibomodel.source componentsSeparatedByString:@">"];
//        NSString * str1 = [array1 objectAtIndex:1];
//        NSString * str2 = [[str1 componentsSeparatedByString:@"<"] objectAtIndex:0];
//        _souce.text = [NSString stringWithFormat:@"来源 : %@",str2];
//        
//        _souce.hidden = NO;
//        
//    }else {
//        _souce.hidden = YES;
//    }
    if (weibomodel.source.length != 0) {
        GDataXMLElement * element = [[GDataXMLElement alloc] initWithXMLString:weibomodel.source error:nil];
        NSString * str2 = element.stringValue;
        _source.text = str2;
        _source.hidden = NO;
    }else {
        _source.hidden = YES;
    }
    
    _source.colorName = @"More_Item_Text_color";
    
    //时间
    NSString * format = @"E M d HH:mm:ss Z yyyy";
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    
     NSDate * date = [formatter dateFromString:weibomodel.created_at];
    
    NSTimeInterval second = -[date timeIntervalSinceNow];
    NSTimeInterval minute = second / 60;
    NSTimeInterval hour = minute / 60;
    NSTimeInterval day = hour / 24 ;
    
    NSString * timeNow = nil;
    
    if (second < 60) {
        
        timeNow = @"刚刚";
        
    }else if(minute < 60){
        
        timeNow = [NSString stringWithFormat:@"%li分钟之前",(NSInteger)minute];
    
    }else if (hour < 24){
        
        timeNow = [NSString stringWithFormat:@"%li小时之前",(NSInteger)hour];

    }else if (day < 7){
        
        timeNow = [NSString stringWithFormat:@"%li天之前",(NSInteger)day];

    }else {
        
        [formatter setDateFormat:@"M月d日 HH:mm"];
        
        [formatter setLocale:[NSLocale currentLocale]];
        
        timeNow = [formatter stringFromDate:date];
    }
   
    _time.text = timeNow;
    _time.colorName = @"More_Item_Text_color";
    NSString * str = _weibomodel.text;
    self.weiboTextLabel.text = str;
   
    NSString * reStr = [NSString stringWithFormat:@"#转发#%@",weibomodel.retweeted_status.text];
    self.reWeiboTextLabel.text = reStr;
    /*
    CGRect rect = [weibomodel.text boundingRectWithSize:CGSizeMake(KScreenWidth-20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : KweiboFont} context:nil];
    CGFloat height = rect.size.height;
//
    _weiboTextLabel.frame = CGRectMake(10, 70, KScreenWidth - 20, height);
    */
    //_weiboTextLabel.colorName = @"More_Item_Text_color";
    
    layout = [TableCellLayout LayOutWithModel:weibomodel];
   
    if (_nineArr == nil) {
        NSMutableArray * mArry = [NSMutableArray array];
        for (int i = 0; i < 9; i++) {
            UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectZero];
            img.backgroundColor = [UIColor blackColor];
            img.tag = 100 + i;
            [mArry addObject:img];
            [self.contentView addSubview:img];
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImgClick:)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            [img addGestureRecognizer:tap];
            
            img.userInteractionEnabled = YES;
        }
        _nineArr = [mArry mutableCopy];
    }
    
    if (_weibomodel.retweeted_status.pic_urls) {
        for (int i = 0; i<9; i++) {
            UIImageView * iv = _nineArr[i];
            iv.frame = [layout.ArryFrame[i] CGRectValue];
            if (i < _weibomodel.retweeted_status.pic_urls.count) {
                [iv sd_setImageWithURL:_weibomodel.retweeted_status.pic_urls[i][@"thumbnail_pic"]];
            }
        }
    }else if (_weibomodel.bmiddle_pic){
        for (int i = 0; i<9; i++) {
            UIImageView * iv = _nineArr[i];
            iv.frame = [layout.ArryFrame[i] CGRectValue];
            if (i < _weibomodel.pic_urls.count) {
                [iv sd_setImageWithURL:weibomodel.pic_urls[i][@"thumbnail_pic"]];
            }
        }
    }else {
        for (UIImageView * iv in _nineArr) {
            iv.frame = CGRectZero;
        }
    }
    

    
   
    _weiboTextLabel.frame = layout.cellLabelFrame;
    _weiboImg.frame = layout.cellImgFrame;
    
   // [_weiboImg sd_setImageWithURL:[NSURL URLWithString:_weibomodel.bmiddle_pic]];
    
    _reWeiboTextLabel.frame = layout.ReCellLabelFrame;
    
    _reBGImg.frame = layout.ReBGImgFrame;
   
  
    
    
    
}
/*
-(NSArray *)nineArr {
    if (_nineArr == nil) {
        NSMutableArray * mArry = [NSMutableArray array];
        for (int i = 0; i < 9; i++) {
            UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectZero];
            img.backgroundColor = [UIColor blackColor];
            
            [self.contentView addSubview:img];
        }
        _nineArr = [mArry mutableCopy];
    }
    return _nineArr;
}
*/
-(WXLabel *)weiboTextLabel {
    
    if (_weiboTextLabel == nil) {
        _weiboTextLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
        
        _weiboTextLabel.font = KweiboFont;
        
        _weiboTextLabel.numberOfLines = 0;
        
       // _weiboTextLabel.linespace = 3;
        
        _weiboTextLabel.wxLabelDelegate = self;
        
 /*   if (_weiboImg == nil) {
            _weiboImg = [[UIImageView alloc] initWithFrame:CGRectZero];
            _weiboImg.backgroundColor = [UIColor redColor];
            [self.contentView addSubview:_weiboImg];
        
        _weiboImg.userInteractionEnabled = YES;
        
        
    }
 */
        [self.contentView addSubview:_weiboTextLabel];
    }
   /*
    if (_nineArr == nil) {
        NSMutableArray * mArry = [NSMutableArray array];
        for (int i = 0; i < 9; i++) {
            UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectZero];
            img.backgroundColor = [UIColor blackColor];
        [mArry addObject:img];
            [self.contentView addSubview:img];
        }
    _nineArr = [mArry mutableCopy];
       
    }
    */
        // NSMutableArray * mArray = [NSMutableArray array];
        
      /*  for (int i = 0; i < self.weibomodel.pic_urls.count; i++) {
            UIImageView * nineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
            nineImg.frame = [layout.ArryFrame[i] CGRectValue];
            nineImg.backgroundColor = [UIColor blackColor];
            [_weiboImg addSubview:nineImg];
            
        }
    */
    
    
        
        
    


    return _weiboTextLabel;
}

-(WXLabel *)reWeiboTextLabel {
    if (_reWeiboTextLabel == nil) {
        _reWeiboTextLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
        _reWeiboTextLabel.font = KReweiboFont;
        _reWeiboTextLabel.numberOfLines = 0;
        
       // _reWeiboTextLabel.linespace = 3;
        _reWeiboTextLabel.wxLabelDelegate = self;
        [self.contentView addSubview:_reWeiboTextLabel];
    }
 /*
    if (_reBGImg == nil) {
        _reBGImg = [[ThemeImageView alloc] initWithFrame:CGRectZero];
        _reBGImg.ImageName = @"timeline_rt_border_selected_9.png";
        //[self.contentView insertSubview:_reBGImg atIndex:0];
    }
*/
    return _reWeiboTextLabel;
 
}
- (void)ImgClick:(UITapGestureRecognizer *)tap {
    UIImageView * imgView = (UIImageView *)tap.view;
    
    [WXPhotoBrowser showImageInView:self.window selectImageIndex:imgView.tag-100 delegate:self];

}
-(NSUInteger)numberOfPhotosInPhotoBrowser:(WXPhotoBrowser *)photoBrowser {
    if (_weibomodel.retweeted_status.pic_urls.count > 0) {
        return _weibomodel.retweeted_status.pic_urls.count;
    }else {
        return _weibomodel.pic_urls.count;
    }
}
-(WXPhoto *)photoBrowser:(WXPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    WXPhoto * photo = [[WXPhoto alloc] init];
    NSString * imgUrlstring = nil;
    if (_weibomodel.retweeted_status.pic_urls.count > 0) {
        NSDictionary * dic = _weibomodel.retweeted_status.pic_urls[index];
        imgUrlstring = dic[@"thumbnail_pic"];
        
    }else {
        NSDictionary * dic = _weibomodel.pic_urls[index];
        imgUrlstring = dic[@"thumbnail_pic"];
        
    }
    imgUrlstring = [imgUrlstring stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
    photo.url = [NSURL URLWithString:imgUrlstring];
    photo.srcImageView = _nineArr[index];
    
    
    
    
    return photo;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
