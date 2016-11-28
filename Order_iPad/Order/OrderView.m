//
//  OrderView.m
//  Order_iPad
//
//  Created by lucid on 16/11/28.
//  Copyright © 2016年 Gooou. All rights reserved.
//

#import "OrderView.h"
#import "OrderTableViewCell.h"
@implementation OrderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
        
        //    orderFoods = [[NSMutableArray alloc] initWithArray: [[OrderCenter sharedOrderCenter] getOrder]];
        //    orderNote = [[NSMutableDictionary alloc] init];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 1366, 1024);
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
        [self addSubview:backBtn];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 64, 1346, 860) ];
        backView.backgroundColor = [UIColor whiteColor];
        [backView.layer setCornerRadius:10];
        [self addSubview:backView];
        
        UIImageView *localBillTitleback = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"local_bill_titleback.png"]];
        [backView addSubview:localBillTitleback];
        localBillTitleback.frame = CGRectMake(0, 0, 1346, 42);
        
        UILabel *foodPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1346, 40)];
//        foodPrice.center = CGPointMake(512, 20);
        foodPrice.textColor = RED_COLOR_DEEP;
        foodPrice.textAlignment = NSTextAlignmentCenter;
        foodPrice.text = @"我的账单";
        foodPrice.shadowColor = [UIColor colorWithWhite:0.9 alpha:1];
        foodPrice.shadowOffset = CGSizeMake(1, 1);
        foodPrice.font = [UIFont systemFontOfSize:22];
        [foodPrice setAdjustsFontSizeToFitWidth:YES];
        foodPrice.textAlignment = NSTextAlignmentCenter;
        foodPrice.backgroundColor = [UIColor clearColor];
        [localBillTitleback addSubview:foodPrice];
        
        
        UILabel *TextLab;
        TextLab = [[UILabel alloc] initWithFrame:CGRectMake(210, 50, 200, 30)];
        TextLab.font = [UIFont systemFontOfSize:20];
        TextLab.textColor = RED_COLOR_DEEP;
        TextLab.text = @"名称";
        TextLab.backgroundColor = [UIColor clearColor];
        [localBillTitleback addSubview:TextLab];
        
        TextLab = [[UILabel alloc] initWithFrame:CGRectMake(425, 50, 200, 30)];
        TextLab.font = [UIFont systemFontOfSize:20];
        TextLab.textColor = RED_COLOR_DEEP;
        TextLab.text = @"单价";
        TextLab.backgroundColor = [UIColor clearColor];
        [localBillTitleback addSubview:TextLab];
        
        TextLab = [[UILabel alloc] initWithFrame:CGRectMake(578, 50, 200, 30)];
        TextLab.font = [UIFont systemFontOfSize:20];
        TextLab.textColor = RED_COLOR_DEEP;
        TextLab.text = @"数量";
        TextLab.backgroundColor = [UIColor clearColor];
        [localBillTitleback addSubview:TextLab];
        
        TextLab = [[UILabel alloc] initWithFrame:CGRectMake(745, 50, 200, 30)];
        TextLab.font = [UIFont systemFontOfSize:20];
        TextLab.textColor = RED_COLOR_DEEP;
        TextLab.text = @"总价";
        TextLab.backgroundColor = [UIColor clearColor];
        [localBillTitleback addSubview:TextLab];
        
        TextLab = [[UILabel alloc] initWithFrame:CGRectMake(930, 50, 200, 30)];
        TextLab.font = [UIFont systemFontOfSize:20];
        TextLab.textColor = RED_COLOR_DEEP;
        TextLab.text = @"备注";
        TextLab.backgroundColor = [UIColor clearColor];
        [localBillTitleback addSubview:TextLab];
        
        UIView *tableBackView = [[UIView alloc] initWithFrame:CGRectMake(18, 192, 1328, 598)];
        tableBackView.backgroundColor = RED_COLOR_DEEP;
        [tableBackView.layer setCornerRadius:10];
        [self addSubview:tableBackView];
        
        orderTable = [[UITableView alloc] initWithFrame:CGRectMake(20, 194, 1324, 594)];
        [orderTable.layer setCornerRadius:10];
        orderTable.separatorColor = [UIColor clearColor];
        orderTable.delegate = self;
        orderTable.dataSource = self;
        orderTable.backgroundColor = [UIColor whiteColor];
        [self addSubview:orderTable];
        
        //编辑按钮
        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [editBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"edit.png" ofType:nil]] forState:UIControlStateNormal];
        editBtn.frame = CGRectMake(20, 640, 80, 40);
        [editBtn addTarget:self action:@selector(editMode:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:editBtn];
        
        //确认下单按钮
        UIButton *commitOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [commitOrderBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"commit_bill.png" ofType:nil]] forState:UIControlStateNormal];
        commitOrderBtn.frame = CGRectMake(135, 640, 140, 40);
        [commitOrderBtn addTarget:self action:@selector(commitOrder) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:commitOrderBtn];
    }
    return self;
}


- (void)back {
    //    if (orderTable.editing) {
    //        return;
    //    }
    self.alpha = 1;
    [UIView animateWithDuration:0.2f animations:^(void){
        self.alpha = 0;
    }];
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    if (cell == nil) {
        cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    }else {
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UITableViewCellEditingStyleDelete == editingStyle) {
       
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


@end
