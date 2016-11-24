//
//  XmlParser.h
//  Network
//
//  Created by lucid on 16/6/10.
//  Copyright © 2016年 lucid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XmlParser : NSObject{
    NSMutableDictionary *food_dict;
    
    NSMutableArray      *categoryNames;

}

//XMLParser的单例
+ (XmlParser *)sharedXMLParser;
/****
 会员中心部分的网络访问
 *****/

-(NSMutableDictionary *)parseXMLWithFile:(NSString *)filePath;

//返回已解析的Dictionary
- (NSDictionary *)getParsedXMLDictionary;
//返回AttachCategory的名称
- (NSArray *)getAttachCategoryNames;







@end
