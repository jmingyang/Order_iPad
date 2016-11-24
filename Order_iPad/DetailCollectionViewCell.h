//
//  DetailCollectionViewCell.h
//  SplitVCDemo
//
//  Created by lucid on 16/11/14.
//  Copyright © 2016年 Gooou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"
@interface DetailCollectionViewCell : UICollectionViewCell{
    UILabel *numLab;
    UIButton *numBtn;
    UITextView *foodName;
    UILabel *foodPrice;
    Food *food;

}

@property (nonatomic,retain) UIImageView *imaView;
@property (nonatomic,retain) Food *food;
-(void)fillCellWithFood:(Food *)f;
@end
