//
//  TableCellLayout.m
//  ME_微博_CZL
//
//  Created by user on 16/9/28.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "TableCellLayout.h"
#import "WXLabel.h"
@interface TableCellLayout () {
    CGFloat NewCellHeight;

}
@end

@implementation TableCellLayout
+ (instancetype)LayOutWithModel:(WeiboModel *)_weibo {
    TableCellLayout * layOut = [[TableCellLayout alloc] init];
    if (layOut) {
        layOut.weibo = _weibo;
    }
    return layOut;
}

-(void)setWeibo:(WeiboModel *)weibo {
    if (_weibo == weibo) {
        return;
    }
    _weibo = weibo;
    
    NewCellHeight = 0;
    
    NewCellHeight += cellHeadHeight;
    
    NewCellHeight += spaceWidth;
    
    /*CGRect rect = [_weibo.text boundingRectWithSize:CGSizeMake(KScreenWidth-20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : KweiboFont} context:nil];
    */
   CGFloat height =  [WXLabel getTextHeight:KweiboFont.pointSize width:KScreenWidth-20 text:_weibo.text linespace:10];
    //CGFloat height = rect.size.height;
    
    _cellLabelFrame = CGRectMake(10, NewCellHeight + 10, KScreenWidth -20, height + 10);
    
    NewCellHeight += _cellLabelFrame.size.height;
    NewCellHeight += spaceWidth + 10;
   
    if (weibo.pic_urls.count > 0) {
       /*
        CGFloat _width;
        
        switch (weibo.pic_urls.count) {
            case 1:
                _width = KScreenWidth / 2 + 2 * spaceWidth;
                
                break;
             case 2:
                _width = KScreenWidth / 3 + 3 * spaceWidth;
                
                break;
             case 3:
                _width = KScreenWidth - 2 * spaceWidth;
              
                break;
            case 4:
                _width = KScreenWidth / 3 + 3 * spaceWidth;
                break;
                case 5:
                _width = KScreenWidth - 2 * spaceWidth;
                break;
                case 6:
                _width = KScreenWidth - 2 * spaceWidth;
                break;
                case 7:
                _width = KScreenWidth - 2 * spaceWidth;
                break;
                case 8:
                _width = KScreenWidth - 2 * spaceWidth;
                break;
                case 9:
                _width = KScreenWidth - 2 * spaceWidth;
                break;
            default:
                break;
        }
        
        
        */
        CGFloat height = [self viewImgCount:weibo.pic_urls.count andViewWidth:(KScreenWidth - 2 * spaceWidth) andTopHeigth:NewCellHeight];
        
      //  _cellImgFrame = CGRectMake(0, NewCellHeight, _width, height);
        
        NewCellHeight += height;
        
        
        NewCellHeight +=spaceWidth;
    }else{
        _ArryFrame = nil;
    }
    
    
    
    if (weibo.retweeted_status) {
       //CGRect rect = [_weibo.retweeted_status.text boundingRectWithSize:CGSizeMake(KScreenWidth-20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : KweiboFont} context:nil];
        CGFloat reHeight = [WXLabel getTextHeight:KReweiboFont.pointSize width:KScreenWidth - 20 text:_weibo.retweeted_status.text linespace:3];
       // CGFloat reHeight = rect.size.height;
        
        _ReCellLabelFrame = CGRectMake(2 * spaceWidth, NewCellHeight, KScreenWidth - 4 * spaceWidth, reHeight);
        
        
        
        _ReBGImgFrame = CGRectMake(spaceWidth, NewCellHeight - spaceWidth, KScreenWidth- 2 * spaceWidth, reHeight + 2 * spaceWidth);
       
        NewCellHeight += _ReBGImgFrame.size.height;
        NewCellHeight += spaceWidth;
        
        if (weibo.retweeted_status.pic_urls.count >0) {
        CGFloat height = [self viewImgCount:weibo.retweeted_status.pic_urls.count andViewWidth:(KScreenWidth - 2 * spaceWidth) andTopHeigth:NewCellHeight];
            
            NewCellHeight +=height;
            
            NewCellHeight += spaceWidth;
        }
    }else {
    
        _ReCellLabelFrame = CGRectZero;
        _ReBGImgFrame = CGRectZero;
    }
    
    
    
    
    NewCellHeight += 10;
    
    
    

    
    
    
    
}

- (CGFloat)viewImgCount:(NSInteger)imgCount andViewWidth:(CGFloat)viewWidth andTopHeigth:(CGFloat)topHeight {
    
    CGFloat _imageViewWidth ;
    CGFloat viewHeight ;
    NSInteger numberOfColumn = 2;
    
    if (imgCount > 9 || imgCount <=0) {
        _ArryFrame = nil;
        return 0;
    }else if (imgCount == 1) {
        _imageViewWidth = viewWidth/2;
        viewHeight = viewWidth/2;
        
    }else if (imgCount == 2) {
        _imageViewWidth = (viewWidth - imgSpace) / 2;
        viewHeight = _imageViewWidth;
        
    }else if (imgCount == 4) {
        _imageViewWidth = ( viewWidth - imgSpace ) / 2;
        
        viewHeight = viewWidth;
        
    }else {
        
        _imageViewWidth = (viewWidth - 2 * imgSpace) / 3;
        numberOfColumn = 3;
        
        if (imgCount == 3) {
            viewHeight = _imageViewWidth;
            
            
            
        }else if (imgCount <=6 ) {
            viewHeight = _imageViewWidth * 2 + imgSpace;
            
            
        }else {
           
            viewHeight = viewWidth;
            
            
        }
    }
    
    NSMutableArray * mArry  = [NSMutableArray array];
    for (int i = 0; i <  9; i++) {
        if (i >= imgCount) {
            CGRect frame = CGRectZero;
            [mArry addObject:[NSValue valueWithCGRect:frame]];
        
        }else {
            NSInteger row = i / numberOfColumn;
            NSInteger column = i % numberOfColumn;
            CGFloat width = _imageViewWidth + imgSpace;
            CGFloat left = (KScreenWidth - viewWidth) / 2;
            CGRect frame = CGRectMake(column * width + left, row * width + topHeight, _imageViewWidth, _imageViewWidth);
            
            [mArry addObject:[NSValue valueWithCGRect:frame]];
        }
        
            
        
    }
    _ArryFrame = [mArry mutableCopy];

    return viewHeight;
}
- (CGFloat)cellHeight {

    return NewCellHeight;
}

@end
