//
//  TableCellLayout.h
//  ME_微博_CZL
//
//  Created by user on 16/9/28.
//  Copyright © 2016年 wuxiang. All rights reserved.
//
#define cellHeadHeight 60
#define spaceWidth 10
#define imgWidth 200
#define imgSpace 5

#import <Foundation/Foundation.h>
@class WeiboModel;
@interface TableCellLayout : NSObject

@property (nonatomic, strong) WeiboModel *weibo;



+ (instancetype)LayOutWithModel:(WeiboModel *)_weibo;

@property (nonatomic, assign , readonly)CGRect cellLabelFrame;
@property (nonatomic, assign , readonly)CGRect cellImgFrame;

@property (nonatomic, assign , readonly)CGRect ReCellLabelFrame;

@property (nonatomic, assign ,readonly)CGRect ReBGImgFrame;

@property (nonatomic, strong ,readonly)NSArray *ArryFrame;
- (CGFloat)cellHeight;

- (CGFloat)viewImgCount:(NSInteger)imgCount andViewWidth:(CGFloat)viewWidth andTopHeigth:(CGFloat)topHeight;
@end
