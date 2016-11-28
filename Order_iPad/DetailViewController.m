//
//  DetailViewController.m
//  iPad点餐demo
//
//  Created by lucid on 16/10/19.
//  Copyright © 2016年 Gooou. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"
#import "DetailCollectionViewCell.h"
#import "XmlParser.h"
#import "Food.h"

@interface DetailViewController ()
@property (nonatomic,strong)UIBarButtonItem *splitViewBarButtonItem;
//@property (nonatomic,strong) UIPopoverController *masterPopover;
//@property (nonatomic,strong)UIPopoverController *iMasterPopOver;
@property (nonatomic, weak) AppDelegate* appDelegate;
@property (nonatomic,retain) UICollectionView *mPicCollectionView;

- (void)setSplitViewBarButtonItem:(UIBarButtonItem *)barButtonItem;


@end

@implementation DetailViewController

static NSString * const reuseidentifier = @"cell";

@synthesize mPicCollectionView;
@synthesize FoodsArr;
@synthesize PhotoDic;
//随机颜色
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1024 1366

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    self.splitViewController.delegate = self;
    self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    self.automaticallyAdjustsScrollViewInsets =NO;//起因是iOS7在Conttoller中新增了automaticallyAdjustsScrollViewInsets这个属性，当设置为YES时（默认YES），如果视图里面存在唯一一个UIScrollView或其子类View，那么它会自动设置相应的内边距，这样可以让scroll占据整个视图，又不会让导航栏遮盖。
    
    NSLog(@"高：%f；宽：%f",self.view.frame.size.height,self.view.frame.size.width);
    
    //我的账单按钮
    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderBtn setBackgroundImage:[UIImage imageNamed: @"my_order.png"] forState:UIControlStateNormal];
    orderBtn.frame = CGRectMake(1000, 935, 188, 62);
    [orderBtn addTarget:self action:@selector(showOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:orderBtn];
    
    //设置按钮
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
//    settingBtn.frame = CGRectMake(150, 935, 62, 62);
    settingBtn.frame = CGRectMake(0, 0, 62, 62);
    //    [settingBtn addTarget:self action:@selector(showSetting) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:settingBtn];
    UIBarButtonItem *ButtonItem0 = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
//    self.navigationItem.rightBarButtonItem = ButtonItem0;
    
    //主页按钮
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeBtn setBackgroundImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    homeBtn.frame = CGRectMake(0, 0, 62, 62);
    [homeBtn addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *ButtonItem = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
//    self.navigationItem.rightBarButtonItem = ButtonItem;
    //    [self.view addSubview:homeBtn];
    
    self.navigationItem.rightBarButtonItems = @[ButtonItem0,ButtonItem];
    

    
    homePage = [HomeView sharedHMView];
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:homePage];
    
    
    UIImageView *content_background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1366, 1024)];
    [content_background setImage:[UIImage imageNamed:@"Background.jpg"]];
    [self.view insertSubview:content_background atIndex:0];

    [self initCollectionView];
    
    NSLog(@"缓存缓存缓存%@",PhotoDic);
    
    
    self.appDelegate = [UIApplication sharedApplication].delegate;
    // 创建抓取数据的请求对象
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    // 设置要抓取哪种类型的实体
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Food"
                                              inManagedObjectContext:self.appDelegate.managedObjectContext];
    // 设置抓取实体
    request.entity = entity;
    // 设置抓取条件
//    Food *f = [[Food alloc]init];
//    request.predicate = [NSPredicate predicateWithFormat:@"Food=%@",
//                         f];
    NSError *error = nil;
    
    // 执行抓取数据的请求，返回符合条件的数据
    NSArray *foodArray = [[self.appDelegate.managedObjectContext
                   executeFetchRequest:request error:&error] mutableCopy];
    NSLog(@"%@",foodArray[101]);
}

- ( void )initCollectionView
{
    
    //先实例化一个层
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //创建一屏的视图大小
    mPicCollectionView = [[UICollectionView alloc ] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-164) collectionViewLayout :layout];
    mPicCollectionView.backgroundColor = [UIColor clearColor];
    mPicCollectionView.dataSource = self;
    mPicCollectionView.delegate = self;
    mPicCollectionView.bounces = NO;
    mPicCollectionView.scrollEnabled = YES;
    mPicCollectionView.showsVerticalScrollIndicator = NO;
    [mPicCollectionView setCollectionViewLayout:layout];
    [mPicCollectionView registerClass:[DetailCollectionViewCell class] forCellWithReuseIdentifier:reuseidentifier];
    [self.view addSubview :mPicCollectionView];
}

- (void)fillFoodInfo:(NSArray *)arr typename:(NSString *)type{
    
    self.navigationItem.title = type;
    self.FoodsArr = [NSMutableArray arrayWithArray:arr];


}

- (void)home {
    [homePage closeDoor];
}

- (void)showOrder {
    if (!orderView) {
        orderView = [[OrderView alloc] init];
        orderView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view addSubview:orderView];
    }
    
//    [orderView reloadOrderData];
    orderView.alpha = 0;
    orderView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.20];
    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
    orderView.alpha = 1.0;
    orderView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    [UIView commitAnimations];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -
#pragma mark SplitViewDelegate

- (void)splitViewController: (UISplitViewController*)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem*)barButtonItem
       forPopoverController: (UIPopoverController*)pc
{
//    barButtonItem.title = @"Master View";
//    [self.navigationItem setRightBarButtonItem:barButtonItem animated:YES];
//    self.masterPopover = pc;
    barButtonItem.title = @"Courses";
    NSLog(@"隐藏主窗口");
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

// Called when the view is shown  again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    NSLog(@"显示主窗口");
    if (barButtonItem == self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = nil;

    }

}


- (void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode
{
//    NSLog(@"asdfghjkl");
//    NSLog(@"%ld",(long)displayMode);
//    if (displayMode==2) {
//        CGRect tmpFrame = CGRectMake(1366*0.065, 0, 1366, 1024-64);
//        mPicCollectionView.frame = tmpFrame;
//        
//        [UIView beginAnimations:@"imageViewSmall" context:nil];
//        [UIView setAnimationDuration:0.5];
//        CGAffineTransform newTransform =  CGAffineTransformScale(mPicCollectionView.transform, 0.87, 0.87);
//        [mPicCollectionView setTransform:newTransform];
////        self.view.center = CGPointMake(670, 100);
//        [UIView commitAnimations];
//
//    }else{
//        CGRect tmpFrame = CGRectMake(1366*0.065, 64, self.view.frame.size.width, self.view.frame.size.height-164);
//        mPicCollectionView.frame = tmpFrame;
//        mPicCollectionView.transform = CGAffineTransformIdentity;
//    
//    }

}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return FoodsArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    DetailCollectionViewCell *cell = [mPicCollectionView dequeueReusableCellWithReuseIdentifier:reuseidentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[DetailCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, 420, 400)];
    }

    Food *f = FoodsArr[indexPath.row];
    [cell fillCellWithFood:f];
    // 获得url对于的沙盒缓存路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:f.foodsChiName];   // 保存文件的名称
    
    // 先从沙盒中取出图片
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data) {
        //data不为空，说明沙盒中存在这个文件
        cell.imaView.image = [UIImage imageWithData:data];
    } else {// 反之沙盒中不存在这个文件
        NSString *str = [NSString stringWithString:f.picBigPath];
        NSArray *arr = [str componentsSeparatedByString:@"h"];
        NSString *string = [NSString stringWithString:arr[1]];
        NSString *beginstr = [string substringToIndex:string.length-9];
        NSString *urlString = [NSString stringWithFormat:@"h%@",beginstr];
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
        [cell.imaView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"fillimage"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            BOOL result = [UIImageJPEGRepresentation(image, 1)writeToFile: filePath atomically:YES]; // 保存成功会返回YES
            result ? NSLog(@""):NSLog(@"%@未存入本地",f.foodsChiName);
            //可以用贝赛尔曲线绘制圆角，提高性能，但会加重cpu负担
            [cell.imaView setImage:image];
            [cell.imaView setNeedsDisplay];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            NSLog(@"图片加载失败:%@",error);
        }];
    }
    return cell;
}


- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    
}


#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){420,400};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 30, 20, 30);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

#pragma mark ---- UICollectionViewDelegate

//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
// 点击高亮
//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    DetailCollectionViewCell *cell = (DetailCollectionViewCell*)[mPicCollectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
//    cell.selected = YES;
//    NSLog(@"%@",PhotoDic);
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    DetailCollectionViewCell *cell = (DetailCollectionViewCell*)[mPicCollectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = randomColor;
//    cell.selected = NO;
//
//}
//// 选中某item
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//
//
//// 长按某item，弹出copy和paste的菜单
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//// 使copy和paste有效
//- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
//{
//    if ([NSStringFromSelector(action) isEqualToString:@"copy:"] || [NSStringFromSelector(action) isEqualToString:@"paste:"])
//    {
//        return YES;
//    }
//    
//    return NO;
//}
//
////
//- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
//{
//    if([NSStringFromSelector(action) isEqualToString:@"copy:"])
//    {
//        NSLog(@"-------------执行拷贝-------------");
//        
//    }
//    else if([NSStringFromSelector(action) isEqualToString:@"paste:"])
//    {
//        NSLog(@"-------------执行粘贴-------------");
//    }
//}



@end
