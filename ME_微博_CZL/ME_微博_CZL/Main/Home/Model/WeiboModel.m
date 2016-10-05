//
//  WeiboModel.m
//  ME_微博_CZL
//
//  Created by user on 16/9/27.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "WeiboModel.h"

@implementation WeiboModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *weiboText = [self.text copy];
    //<image url = ''>
    //[weiboText insertString:@"<image url = '001.png'>" atIndex:0];
    NSString * regex = @"\\[\\w+\\]";
    NSArray * array = [weiboText componentsMatchedByRegex:regex];
    
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray * emoticons = [[NSArray alloc] initWithContentsOfFile:fileName];
    
    
    for (NSString * str in array) {
        
        NSString * a = [NSString stringWithFormat:@"chs='%@'",str];
        
        NSPredicate * pre = [NSPredicate predicateWithFormat:a];
        
        NSArray * result = [emoticons filteredArrayUsingPredicate:pre];
        
        NSDictionary * dic = [result firstObject];
        
        if (dic == nil) {
            continue;
        }
        
        NSString * imageName = dic[@"png"];
        NSString * imgStr = [NSString stringWithFormat:@"<image url = '%@'>",imageName];
        
        weiboText = [weiboText stringByReplacingOccurrencesOfString:str withString:imgStr];
        
    }
    
    self.text = [weiboText copy];
    return YES;
}
@end
