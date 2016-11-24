//
//  LeftMenuTableViewController.h
//  iPad点餐demo
//
//  Created by lucid on 16/10/19.
//  Copyright © 2016年 Gooou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuTableViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *MunuArr;//菜名
@property (strong, nonatomic) NSDictionary *FoodDic;//以菜类名为key，菜类下的Food数组为value

@property (nonatomic,assign) id delegate;
@end

@protocol LeftMenuVCDelegate

- (void)fillFoodInfo:(NSArray *)arr typename:(NSString *)type;

@end