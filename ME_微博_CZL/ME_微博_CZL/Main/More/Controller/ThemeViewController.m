//
//  ThemeViewController.m
//  ME_微博_CZL
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 wuxiang. All rights reserved.
//

#import "ThemeViewController.h"

@implementation ThemeViewController
-(void)awakeFromNib{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KscreenHeight-64) style:UITableViewStylePlain];
    
    _table.delegate = self;
    _table.dataSource = self;
    
    _table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_table];
    [self _createBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:KThemeChangeName object:nil];
}
- (void)themeChange {
    _textColor = [[ThemeManager shareManage] themeManagerColorName:@"More_Item_Text_color"];
    
    _table.separatorColor = _textColor;
    
    [_table reloadData];
    
    
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [ThemeManager shareManage].allTheme.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    dic = [ThemeManager shareManage].allTheme;
    NSArray * arr = dic.allKeys;
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.textLabel.text = arr[indexPath.row];
    
    cell.textColor = _textColor;
    
    cell.backgroundColor = [UIColor clearColor];
    
    NSString * key = arr[indexPath.row];

    NSString * string = [NSString stringWithFormat:@"%@/%@",dic[key],@"more_icon_theme.png"];
    UIImage *img = [UIImage imageNamed:string];
    cell.imageView.image = img;
    

    
    ThemeManager * manager = [ThemeManager shareManage];
    NSString * str = dic[key];
    NSString * current = [str substringFromIndex:6];
    
    if ([current isEqualToString:manager.currentThemeName]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ThemeManager * manager = [ThemeManager shareManage];
    
    NSArray * arr = dic.allKeys;
    NSString * key = arr[indexPath.row];
    
    NSString * str = dic[key];
    NSString * current = [str substringFromIndex:6];
    
    manager.currentThemeName = current;
    manager.currentKeyName = key;
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
   
    if ([current isEqualToString:manager.currentThemeName]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [tableView reloadData];
    
    
}
@end
