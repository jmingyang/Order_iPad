//
//  XmlParser.m
//  Network
//
//  Created by lucid on 16/6/10.
//  Copyright © 2016年 lucid. All rights reserved.
//
#import <CoreData/CoreData.h>
#import "XmlParser.h"
#import "DDXMLDocument.h"
#import "DDXMLElement.h"
#import "DDXMLNode.h"
#import "Food+CoreDataProperties.h"
#import "AppDelegate.h"

@interface XmlParser ()
@property (nonatomic, weak) AppDelegate* appDelegate;

@end

@implementation XmlParser


static XmlParser *xmlParser_ = nil;

/*
 <summary>
 <function>XMLParser的单例</function>
 <date>2012-10-18</date>
 </summary>
 */

+ (XmlParser *)sharedXMLParser
{
    if (!xmlParser_) {
        xmlParser_ = [[XmlParser alloc] init]; //xmlParser_对象不存在时，进行初始化
    }
    return xmlParser_;
}

//返回已解析的Dictionary
- (NSDictionary *)getParsedXMLDictionary {
    if (food_dict) {
        return food_dict;
    }
    return nil;
}

//返回AttachCategory的名称
- (NSArray *)getAttachCategoryNames {
    NSArray *AttachCategoryNames = [NSArray arrayWithArray:categoryNames];
    return AttachCategoryNames;
}


//将XML转换为以AttachCategory为Key，Food数组为Value的Dictionary
- (NSMutableDictionary *)parseXMLWithFile:(NSString *)filePath {
    
    if (food_dict) {
        [food_dict removeAllObjects];
        
    }
    food_dict = [NSMutableDictionary new];
    if (categoryNames) {
        [categoryNames removeAllObjects];
    }
    categoryNames = [NSMutableArray new];
    
    
//    NSString *xmlStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc] initWithXMLString:filePath options:0 error:nil] ;
    
    DDXMLElement *root = [xmlDoc rootElement];
    
    NSArray *foods = [root elementsForName:@"Food"];
    
    
    for (DDXMLElement *f_ in foods) {
        self.appDelegate = [UIApplication sharedApplication].delegate;
//        Food *f = [[Food alloc] init];
        Food *f = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:self.appDelegate.managedObjectContext];

//        Food *f = [[Food alloc]initWithEntity:[NSEntityDescription entityForName:@"Food" inManagedObjectContext:self.appDelegate.managedObjectContext] insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
        
        [[root elementsForName:@"Result"] lastObject];
        DDXMLElement *FoodsCodeId   = [[f_ elementsForName:@"FoodsCodeId"] lastObject];     //ID
        DDXMLElement *FoodsEngName  = [[f_ elementsForName:@"FoodsEngName"] lastObject];    //英文名
        DDXMLElement *FoodsChiName  = [[f_ elementsForName:@"FoodsChiName"] lastObject];    //中文名
        DDXMLElement *FoodsStyle    = [[f_ elementsForName:@"FoodsStyle"] lastObject];      //样式
        DDXMLElement *FoodsMode     = [[f_ elementsForName:@"FoodsMode"] lastObject];       //单位
        DDXMLElement *Price         = [[f_ elementsForName:@"Price"] lastObject];           //价格
        DDXMLElement *HolidayPrice  = [[f_ elementsForName:@"HolidayPrice"] lastObject];    //节日价格
        DDXMLElement *DisPriceRate  = [[f_ elementsForName:@"DisPriceRate"] lastObject];    //折扣
        DDXMLElement *MainMaterial  = [[f_ elementsForName:@"MainMaterial"]lastObject];    //主料
        DDXMLElement *Taste         = [[f_ elementsForName:@"Taste"] lastObject];           //口味
        DDXMLElement *Cookery       = [[f_ elementsForName:@"Cookery"] lastObject];         //做法
        DDXMLElement *Note          = [[f_ elementsForName:@"Note"] lastObject];            //备注
        DDXMLElement *PicListPath   = [[f_ elementsForName:@"PicListPath"] lastObject];     //菜品介绍图片路径
        DDXMLElement *PicBigPath    = [[f_ elementsForName:@"PicBigPath"] lastObject];      //菜品详情图片路径
        DDXMLElement *PicSmallPath  = [[f_ elementsForName:@"PicSmallPath"] lastObject];    //唱单显示菜品图片路径
//        DDXMLElement *Remark        = [[f_ elementsForName:@"Remark"] lastObject];          //二级分类
        DDXMLElement *AttachCategory= [[f_ elementsForName:@"AttachCategory"] lastObject];  //一级分类
        DDXMLElement *coursecode    = [[f_ elementsForName:@"CourseCode"] lastObject];      //所属球场
        
//        if (PicBigPath) {
//            NSString *str = [NSString stringWithString:PicBigPath.stringValue];
//            
//            NSArray *arr = [str componentsSeparatedByString:@"h"];
//            NSString *string = [NSString stringWithString:arr[1]];
//            NSString *beginstr = [string substringToIndex:string.length-9];
//            NSString *urlString = [NSString stringWithFormat:@"h%@",beginstr];
//            
//            [photoPicarr addObject:urlString];
//        }
        if (FoodsCodeId) {
            f.foodsCodeId = FoodsCodeId.stringValue;
        }
        if (FoodsEngName) {
            f.foodsEngName = FoodsEngName.stringValue;
        }
        if (FoodsChiName) {
            f.foodsChiName = FoodsChiName.stringValue;
        }
        if (FoodsStyle) {
            f.foodsStyle = FoodsStyle.stringValue;
        }
        if (FoodsMode) {
            f.foodsMode = FoodsMode.stringValue;
        }
        if (Price) {
            f.price = Price.stringValue;
        }
        if (HolidayPrice) {
            f.holidayPrice = HolidayPrice.stringValue;
        }
        if (DisPriceRate) {
            f.disPriceRate = DisPriceRate.stringValue;
        }
        if (AttachCategory) {
            f.attachCategory = AttachCategory.stringValue;
            if ([AttachCategory.stringValue length] > 0) {
                NSMutableArray *food_Category = [food_dict objectForKey:AttachCategory.stringValue];
                if (!food_Category) {
                    //无该分类，添加一个新的菜品一级分类
                    food_Category = [[NSMutableArray alloc] init];
                    [food_dict setObject:food_Category forKey:AttachCategory.stringValue];

                    if (![categoryNames containsObject:AttachCategory.stringValue]) {
                        [categoryNames addObject:AttachCategory.stringValue];
                    }
                    
                }else {
                    //已经存在该分类
                }
                [food_Category addObject:f];
            }
        }
        
        if (coursecode) {
            f.coursecode = coursecode.stringValue;
        }
        if (MainMaterial) {
            f.mainMaterial = MainMaterial.stringValue;
        }
        if (Taste) {
            f.taste = Taste.stringValue;
        }
        if (Cookery) {
            f.cookery = Cookery.stringValue;
        }
        if (Note) {
            f.note = Note.stringValue;
        }
        if (PicListPath) {
            f.picListPath = PicListPath.stringValue;
            
//            [photos addObject:f.PicListPath];
        }
        if (PicBigPath) {
            f.picBigPath = PicBigPath.stringValue;
            
//            [photos addObject:f.PicBigPath];
        }
        if (PicSmallPath) {
            f.picSmallPath = PicSmallPath.stringValue;
            
//            [photos addObject:f.PicSmallPath];
        }
        
//        NSError *error;
//        // 设置完实体属性之后，调用托管对象上下文的save:方法将实体写入数据库。如果保存成功
//        if ([self.appDelegate.managedObjectContext save:&error]){
//            NSLog(@"保存成功");
//        } else {
//            NSLog(@"保存实体出错: %@", error);
//        }

        
        
    }
    return food_dict;
}









@end
