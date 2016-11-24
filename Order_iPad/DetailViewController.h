//
//  DetailViewController.h
//  iPad点餐demo
//
//  Created by lucid on 16/10/19.
//  Copyright © 2016年 Gooou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuTableViewController.h"
#import "HomeView.h"

@interface DetailViewController : UIViewController<UISplitViewControllerDelegate,UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout,LeftMenuVCDelegate>
{
    HomeView *homePage;

}
@property (strong, nonatomic) NSMutableDictionary *PhotoDic;//图片
@property (strong, nonatomic) NSMutableArray *FoodsArr;//Food数组
@end
