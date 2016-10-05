//
//  ThemeViewController.h
//  ME_微博_CZL
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ThemeViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView * _table;
    NSDictionary * dic;
    UIColor *_textColor;
}

@end
