//
//  LeftMenuTableViewController.m
//  iPad点餐demo
//
//  Created by lucid on 16/10/19.
//  Copyright © 2016年 Gooou. All rights reserved.
//

#import "LeftMenuTableViewController.h"
#import "leftTableViewCell.h"
#import "DetailViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "XmlParser.h"
#import "Food.h"
@interface LeftMenuTableViewController ()

@end

@implementation LeftMenuTableViewController
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@synthesize MunuArr;
@synthesize FoodDic;
@synthesize delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"菜类";
    
    UIImageView *content_background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1366, 1024)];
    [content_background setImage:[UIImage imageNamed:@"Background.jpg"]];
    [self.view insertSubview:content_background atIndex:0];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    
    
    NSLog(@"%@",[[NSBundle mainBundle] pathForResource:@"foodInfo.xml" ofType:nil]);
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"foodInfo.xml" ofType:nil];
    NSString *str=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];

    XmlParser *xp = [XmlParser sharedXMLParser];
    [xp parseXMLWithFile:str];
    FoodDic = [xp getParsedXMLDictionary];
    MunuArr = [NSMutableArray arrayWithArray:[xp getAttachCategoryNames]];

    //默认选中第一行
    NSIndexPath *path=[NSIndexPath indexPathForItem:0 inSection:2];
    [self tableView:self.tableView didSelectRowAtIndexPath:path];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return MunuArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    leftTableViewCell *cell = [[leftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.lab.text = [NSString stringWithFormat:@"%@",MunuArr[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *dv = [[DetailViewController alloc]init ];

    NSString *str = MunuArr[indexPath.row];

    self.delegate = dv;
    //代理传值
    if (delegate && [delegate respondsToSelector:@selector(fillFoodInfo: typename:)]) {
        [delegate fillFoodInfo:FoodDic[str] typename:str];
    }
    //判断是iPad还是iPhone
    if (!self.splitViewController) {
        [self.navigationController pushViewController:dv animated:YES];
    }else{
        UINavigationController *DetailNavi = [self.splitViewController.childViewControllers lastObject];
        [DetailNavi setViewControllers:@[dv]];
        [self.splitViewController showDetailViewController:DetailNavi sender:nil];
//            [self.splitViewController showViewController:dv sender:nil];也可以用
    }
    


    
}


@end
