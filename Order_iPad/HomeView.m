//
//  HomeView.m
//  Order_iPad
//
//  Created by lucid on 16/11/23.
//  Copyright © 2016年 Gooou. All rights reserved.
//

#import "HomeView.h"
#import "AppDelegate.h"
@implementation HomeView


@synthesize ctrl;
//如果这里不把homeview作为单例处理，每次点击菜类都会出现homeView
static HomeView *_homeView;
//重写allocWithZone:方法，在这里创建唯一的实例(注意线程安全)
+ (HomeView *)allocWithZone:(struct _NSZone *)zone {
    @synchronized(self) {
        if (_homeView == nil) {
            _homeView = [super allocWithZone:zone];
        }
    }
    return _homeView;
}

//单例
+ (HomeView *)sharedHMView {
    if (!_homeView) {
        _homeView = [[HomeView alloc] initWithFrame:CGRectMake(0, 0, 1366, 1024)];
    }
    return _homeView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        leftView = [[UIView alloc] initWithFrame:CGRectMake(683, 0, 683, 1024)];
        leftView.backgroundColor = [UIColor redColor];
        [self addSubview:leftView];
        [leftView.layer setAnchorPoint:CGPointMake(0, leftView.layer.anchorPoint.y)];
        [leftView setCenter:CGPointMake(0, 1024/2)];
        UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 683, 1024)];
        [leftImage setImage:[UIImage imageNamed:@"home_back_left_4.png" ]];//4是美兰湖 5是海西 6是东北嘉荫
        [leftView addSubview:leftImage];
        
        
        rightView = [[UIView alloc] initWithFrame:CGRectMake(1366, 0, 683, 1024)];
        rightView.backgroundColor = [UIColor blueColor];
        [self addSubview:rightView];
        [rightView.layer setAnchorPoint:CGPointMake(1, leftView.layer.anchorPoint.y)];
        [rightView setCenter:CGPointMake(1366, 1024/2+0.7)];
        UIImageView *rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 683, 1024)];
        [rightImage setImage:[UIImage imageNamed:@"home_back_right_4.png" ]];
        [rightView addSubview:rightImage];
        
        
        btnsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1366, 1024)];
        [self addSubview:btnsView];
        
        
//        UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        updateBtn.frame = CGRectMake(20, 670, 84, 70);
//        [updateBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"update_foods.png" ofType:nil]] forState:UIControlStateNormal];
//        [updateBtn addTarget:self action:@selector(updateData) forControlEvents:UIControlEventTouchUpInside];
//        [btnsView addSubview:updateBtn];
//        
//        UIButton *localOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        localOrderBtn.frame = CGRectMake(120, 670, 84, 70);
//        [localOrderBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"local_order.png" ofType:nil]] forState:UIControlStateNormal];
//        [localOrderBtn addTarget:self action:@selector(localOrder) forControlEvents:UIControlEventTouchUpInside];
//        [btnsView addSubview:localOrderBtn];
//        
//        UIButton *cleanOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        cleanOrderBtn.frame = CGRectMake(220, 670, 84, 70);
//        [cleanOrderBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"clear_data.png" ofType:nil]] forState:UIControlStateNormal];
//        [cleanOrderBtn addTarget:self action:@selector(cleanOrder) forControlEvents:UIControlEventTouchUpInside];
//        [btnsView addSubview:cleanOrderBtn];
//        
//        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        //        loginBtn.frame = CGRectMake(420, 670, 84, 70);
//        loginBtn.frame = CGRectMake(320, 670, 84, 70);
//        [loginBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back_login.png" ofType:nil]] forState:UIControlStateNormal];
//        [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//        [btnsView addSubview:loginBtn];
        
        UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        enterBtn.frame = CGRectMake(1000, 900, 188, 62);
        [enterBtn setBackgroundImage:[UIImage imageNamed: @"start_menu.png" ] forState:UIControlStateNormal];
        [enterBtn addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
        [btnsView addSubview:enterBtn];
    }
    return self;
}


- (void)enter {
    
    //check login
    //    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    //    if(userid == nil){
    //        [self performSelector:@selector(login)];
    //        return;
    //    }
    
    [self openDoor];
    
}

- (void)openDoor {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    btnsView.alpha = 0;
    CATransform3D t = CATransform3DIdentity;
    t = CATransform3DRotate(t, -90*M_PI / 180, 0, 1, 0);
    leftView.layer.transform = t;
    CATransform3D t_ = CATransform3DIdentity;
    t_ = CATransform3DRotate(t_, -90*M_PI / 180, 0, 1, 0);
    rightView.layer.transform = t_;
    [UIView commitAnimations];
    
    [NSTimer scheduledTimerWithTimeInterval:1.7 target:self selector:@selector(hiddenSelf) userInfo:nil repeats:NO];
}

- (void)hiddenSelf {
    self.hidden = YES;
}

- (void)closeDoor {
    self.hidden = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    CATransform3D t = CATransform3DIdentity;
    t = CATransform3DRotate(t, 0, 0, 1, 0);
    leftView.layer.transform = t;
    CATransform3D t_ = CATransform3DIdentity;
    t_ = CATransform3DRotate(t_, 0, 0, 1, 0);
    rightView.layer.transform = t_;
    [UIView commitAnimations];
    
    [NSTimer scheduledTimerWithTimeInterval:1.7 target:self selector:@selector(unhiddenSelf) userInfo:nil repeats:NO];
}

- (void)unhiddenSelf {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    btnsView.alpha = 1;
    [UIView commitAnimations];
}

@end
