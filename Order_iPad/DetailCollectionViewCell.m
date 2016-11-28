//
//  DetailCollectionViewCell.m
//  SplitVCDemo
//
//  Created by lucid on 16/11/14.
//  Copyright © 2016年 Gooou. All rights reserved.
//

#import "DetailCollectionViewCell.h"

@implementation DetailCollectionViewCell
@synthesize imaView,food;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
//layer.cornerRadius
//        self.layer.cornerRadius = 40;
//        self.layer.masksToBounds = YES;
//        self.layer.shouldRasterize = YES;
//        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
//mask
//        CAShapeLayer *layer = [CAShapeLayer layer];
//        UIBezierPath *aPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
//        layer.path = aPath.CGPath;
//        self.layer.mask = layer;
        
        
        imaView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 420, 300)];
        imaView.backgroundColor = [UIColor clearColor];
        [self addSubview:imaView];
        
        UIImageView *numBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"num_back.png" ]];
        [numBack setClipsToBounds:YES];
        [numBack.layer setCornerRadius:10];
        [self addSubview:numBack];
        numBack.frame = CGRectMake(75, 350, 72, 30);
        
        
        numLab = [[UILabel alloc] initWithFrame:CGRectMake(75, 350, 72, 40)];
//        numLab.textColor = RED_COLOR_DEEP;
        numLab.backgroundColor = [UIColor clearColor];
        numLab.textAlignment = NSTextAlignmentCenter;
        numLab.font = [UIFont boldSystemFontOfSize:24];
        [numLab setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:numLab];
        
        
        foodName = [[UILabel alloc] initWithFrame:CGRectMake(0, 285, 200, 55)];
//        foodName.textColor = RED_COLOR_DEEP;
        
        foodName.numberOfLines = 2;
        foodName.font = [UIFont systemFontOfSize:18];
        foodName.backgroundColor = [UIColor clearColor];
        [self addSubview:foodName];
        
        
        foodPrice = [[UILabel alloc] initWithFrame:CGRectMake(250, 285, 120, 55)];
//        foodPrice.textColor = RED_COLOR_DEEP;
        foodPrice.font = [UIFont systemFontOfSize:24];
        [foodPrice setAdjustsFontSizeToFitWidth:YES];
        foodPrice.textAlignment = NSTextAlignmentRight;
        foodPrice.backgroundColor = [UIColor clearColor];
        
        [self addSubview:foodPrice];
        
        
        UIButton *decreaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        decreaseBtn.frame = CGRectMake(5, 350, 68, 30);
        [decreaseBtn setBackgroundImage:[UIImage imageNamed:@"decrease_btn.png" ] forState:UIControlStateNormal];
        [decreaseBtn addTarget:self action:@selector(decreaseFood) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:decreaseBtn];
        
        UIButton *increaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        increaseBtn.frame = CGRectMake(150, 350, 68, 30);
        [increaseBtn setBackgroundImage:[UIImage imageNamed:@"increase_btn.png"] forState:UIControlStateNormal];
//        [increaseBtn addTarget:self action:@selector(increaseFood) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:increaseBtn];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = imaView.frame;
//        [btn addTarget:self action:@selector(enterDetail) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIButton *detailbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [detailbtn setBackgroundImage:[UIImage imageNamed:@"detail_btn.png" ] forState:UIControlStateNormal];
        detailbtn.frame = CGRectMake(305, 350, 68, 30);
//        [detailbtn addTarget:self action:@selector(enterDetail) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:detailbtn];
        
        numBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        numBtn.frame = numLab.frame;
        [self addSubview:numBtn];
//        [numBtn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
                
        
    }
    
    return self;
}

-(void)fillCellWithFood:(Food *)f{
    foodName.text = [NSString stringWithFormat:@"%@\n%@",f.foodsChiName,f.foodsEngName];
    if ([f.foodsEngName length] == 0) {
        foodName.font = [UIFont systemFontOfSize:24];
//        [foodName setContentInset:UIEdgeInsetsMake(0, 3, 0, 0)];
    }
    
    foodPrice.text = [NSString stringWithFormat:@"%d/%@",[f.price intValue],f.foodsMode];

}


@end
