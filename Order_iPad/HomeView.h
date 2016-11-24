//
//  HomeView.h
//  Order_iPad
//
//  Created by lucid on 16/11/23.
//  Copyright © 2016年 Gooou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeView : UIView
{
    UIView *leftView;
    UIView *rightView;
    UIView *btnsView;
//    UIViewController *ctrl;

}
+ (HomeView *)sharedHMView;

@property (nonatomic, assign) UIViewController *ctrl;

- (void)openDoor;
- (void)closeDoor;
- (void)enter;
@end
