//
//  Food.h
//  Menu_iPad
//
//  Created by admin on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  Food的数据模型

//<!--万达_2012-05-11-->
//<!--版本说明：-->
//<!--以下是字段注释说明:-->
//<!--FoodsCodeId 菜品编码-->
//<!--FoodsEngName 菜品英文名-->
//<!--FoodsChiName 菜品中文名-->
//<!--FoodsStyle 菜味-->
//<!--FoodsMode 菜品规格-->
//<!--Price 价格-->
//<!--HolidayPrice 假日价格-->
//<!--DisPriceRate 打折率-->
//<!--Main Material 主料-->
//<!--Taste 口味-->
//<!--Cookery 做法-->
//<!--Remark 类别-->
//<!--AttachCategory 隶属类别-->
//<!--Note 备注-->
//<!--coursecode 球场代码-->
//<!--PicListPath 菜品介绍图片路径-->
//<!--PicBigPath  菜品详情图片路径-->
//<!--PicSmallPath 唱单显示菜品图片路径-->

#import <Foundation/Foundation.h>

@interface Food : NSObject {
    NSString *FoodsCodeId;   //ID
    NSString *FoodsEngName;  //英文名
    NSString *FoodsChiName;  //中文名
    NSString *FoodsStyle;    //样式
    NSString *FoodsMode;     //单位
    NSString *Price;         //价格
    NSString *HolidayPrice;  //节日价格
    NSString *DisPriceRate;  //折扣
    NSString *MainMaterial;  //主料
    NSString *Taste;         //口味
    NSString *Cookery;       //做法
    NSString *Note;          //备注   
    NSString *Operate;       //操作
    NSString *PicListPath;   //菜品介绍图片路径
    NSString *PicBigPath;    //菜品详情图片路径
    NSString *PicSmallPath;  //唱单显示菜品图片路径
    NSString *Remark;        //二级分类
    NSString *AttachCategory;//一级分类
    NSString *coursecode;    //所属球场
    NSString *caiNumber;    //菜的数量
    
    NSDictionary *orderInfo;
    
}
@property (nonatomic,retain) NSString *FoodsCodeId;   //ID
@property (nonatomic,retain) NSString *FoodsEngName;  //英文名
@property (nonatomic,retain) NSString *FoodsChiName;  //中文名
@property (nonatomic,retain) NSString *FoodsStyle;    //样式
@property (nonatomic,retain) NSString *FoodsMode;     //单位
@property (nonatomic,retain) NSString *Price;         //价格
@property (nonatomic,retain) NSString *HolidayPrice;  //节日价格
@property (nonatomic,retain) NSString *DisPriceRate;  //折扣
@property (nonatomic,retain) NSString *MainMaterial;  //主料
@property (nonatomic,retain) NSString *Taste;         //口味
@property (nonatomic,retain) NSString *Cookery;       //做法
@property (nonatomic,retain) NSString *Note;          //备注   
@property (nonatomic,retain) NSString *Operate;       //操作
@property (nonatomic,retain) NSString *PicListPath;   //菜品介绍图片路径
@property (nonatomic,retain) NSString *PicBigPath;    //菜品详情图片路径
@property (nonatomic,retain) NSString *PicSmallPath;  //唱单显示菜品图片路径
@property (nonatomic,retain) NSString *Remark;        //二级分类
@property (nonatomic,retain) NSString *AttachCategory;//一级分类
@property (nonatomic,retain) NSString *coursecode;    //所属球场
@property (nonatomic,retain) NSString *caiNumber;     //菜的数量

@property (nonatomic,retain) NSDictionary *orderInfo;    //orderInfo

@end
