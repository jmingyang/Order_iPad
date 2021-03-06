//
//  AppDelegate.h
//  Order_iPad
//
//  Created by lucid on 16/11/22.
//  Copyright © 2016年 Gooou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) UISplitViewController *splitVC;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

