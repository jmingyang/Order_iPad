//
//  Food+CoreDataProperties.h
//  Order_iPad
//
//  Created by lucid on 16/11/28.
//  Copyright © 2016年 Gooou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Food.h"

NS_ASSUME_NONNULL_BEGIN

@interface Food (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *attachCategory;
@property (nullable, nonatomic, retain) NSString *cookery;
@property (nullable, nonatomic, retain) NSString *coursecode;
@property (nullable, nonatomic, retain) NSString *disPriceRate;
@property (nullable, nonatomic, retain) NSString *foodsChiName;
@property (nullable, nonatomic, retain) NSString *foodsCodeId;
@property (nullable, nonatomic, retain) NSString *foodsEngName;
@property (nullable, nonatomic, retain) NSString *foodsMode;
@property (nullable, nonatomic, retain) NSString *foodsStyle;
@property (nullable, nonatomic, retain) NSString *holidayPrice;
@property (nullable, nonatomic, retain) NSString *mainMaterial;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) NSString *picBigPath;
@property (nullable, nonatomic, retain) NSString *picListPath;
@property (nullable, nonatomic, retain) NSString *picSmallPath;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSString *remark;
@property (nullable, nonatomic, retain) NSString *taste;

@end

NS_ASSUME_NONNULL_END
