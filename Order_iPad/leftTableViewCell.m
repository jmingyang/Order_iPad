//
//  leftTableViewCell.m
//  iPad点餐demo
//
//  Created by lucid on 16/10/20.
//  Copyright © 2016年 Gooou. All rights reserved.
//

#import "leftTableViewCell.h"

@implementation leftTableViewCell
@synthesize lab;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 18, self.frame.size.width, 21)];
        lab.font = [UIFont boldSystemFontOfSize:24];
        lab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:lab];
    }
    return self;
}

@end
