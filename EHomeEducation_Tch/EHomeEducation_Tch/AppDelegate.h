//
//  AppDelegate.h
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/1/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "EHEOrder.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UITabBarController *tab;

@property (strong, nonatomic) EHEOrder * order;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

