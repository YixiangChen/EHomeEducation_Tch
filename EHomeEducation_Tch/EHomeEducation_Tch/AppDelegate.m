//
//  AppDelegate.m
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/1/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "Defines.h"
#import "AppDelegate.h"
#import "EHETchCommunicationManager.h"
#import "EHETchCoreDataManager.h"
#import "EHETchSearchingViewController.h"
#import "EHETchBookingManagerViewController.h"
#import "EHETchSettingViewController.h"
#import "EHETchOrderDetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    // Override point for customization after application launch.
    //[[EHETchCommunicationManager getInstance] registerWithName:@"TeacherAdmin" andPassword:@"1234"];
    //[[EHETchCommunicationManager getInstance] loginWithName:@"TeacherAdmin" andPassword:@"1234"];
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    [dict setObject:@"135" forKey:@"teacherid"];
//    [dict setObject:@"2000-1-1" forKey:@"birthday"];
//    [dict setObject:@"易中天" forKey:@"name"];
//    [dict setObject:@"男" forKey:@"gender"];
//    [dict setObject:@"11118765073730234" forKey:@"identity"];
//    [dict setObject:@"21002700" forKey:@"qq"];
//    [dict setObject:@"wwww.xiaoxiao.com" forKey:@"sinaweibo"];
//    [dict setObject:@"1305789878" forKey:@"telephone"];
//    [dict setObject:@"大学本科" forKey:@"degree"];
//    [dict setObject:@"晚上七点到十点" forKey:@"timeperiod"];
//    [dict setObject:@"为小学四年级学生量身定做课程" forKey:@"objectinfo"];
//    [dict setObject:@"数学语文" forKey:@"subjectinfo"];
//    [dict setObject:@"非北京勿扰" forKey:@"memo"];
//    [dict setObject:@"39.957074" forKey:@"latitude"];
//    [dict setObject:@"116.278766" forKey:@"longitude"];
//    [[EHETchCommunicationManager getInstance] completeProfileWithInfodict:dict];
    [[EHETchCoreDataManager getInstance] removeAllOrdersFromCoreData];
    [[EHETchCommunicationManager getInstance] loadOrdersWithTeacherId:135 andOrderStatus:-1];
//    [[EHETchCommunicationManager getInstance] confirmOrderWithOrderId:358];
//    [[EHETchCommunicationManager getInstance] cancelOrderWithOrderId:359 withReason:@"您太远了"];
//    [[EHETchCommunicationManager getInstance] completeOrderWithOrderId:358];
//    [[EHETchCommunicationManager getInstance] commentCustomerWithCustomerId:270 andTeacherId:135 andRand:2 andComment:@"只给了我一百块，车费都不够"];
//    [[EHETchCommunicationManager getInstance] loadCommentsWithCustomerId:270];
//    [[EHETchCommunicationManager getInstance] loadOrderDetailWithOrderId:358];
    
    EHETchSearchingViewController *searchingViewController = [[EHETchSearchingViewController alloc] initWithNibName:nil bundle:nil];
    
    UINavigationController *navi_searching = [[UINavigationController alloc] initWithRootViewController:searchingViewController];
    
    EHETchBookingManagerViewController * mapViewController=[[EHETchBookingManagerViewController alloc]initWithNibName:nil bundle:nil];
    UINavigationController * navi_booking=[[UINavigationController alloc]initWithRootViewController:mapViewController];
    
    
    EHETchSettingViewController *settingViewController = [[EHETchSettingViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController * navi_setting=[[UINavigationController alloc]initWithRootViewController:settingViewController];
    
    
    
    self.tab = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    self.tab.delegate = self;
    self.tab.viewControllers = @[navi_searching,navi_booking, navi_setting];
    [[self.tab.viewControllers objectAtIndex:0] setTitle:@"首页"];
    [[[self.tab.viewControllers objectAtIndex:0] tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kGreenForTabbaritem, NSForegroundColorAttributeName, [UIFont fontWithName:@"FZKATJW--GB1-0" size:15], NSFontAttributeName, nil]  forState:UIControlStateNormal];
    
    [[self.tab.viewControllers objectAtIndex:1] setTitle:@"我的"];
    [[[self.tab.viewControllers objectAtIndex:1] tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"FZKATJW--GB1-0" size:15], NSFontAttributeName, nil]  forState:UIControlStateNormal];
    
    [[self.tab.viewControllers objectAtIndex:2] setTitle:@"设置"];
    [[[self.tab.viewControllers objectAtIndex:2] tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"FZKATJW--GB1-0" size:15], NSFontAttributeName, nil]  forState:UIControlStateNormal];
    
    
    self.tab.tabBar.backgroundColor = [UIColor grayColor];
    
    self.window.rootViewController = self.tab;
    [self.window makeKeyAndVisible];
    
    if (SYSTEM_VERSION >= 8.0) {
        //ios8注册推送
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge
                                                                                             |UIUserNotificationTypeAlert
                                                                                             |UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
    }

    if([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]) {
        NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        int orderid = [userInfo[@"orderId"] intValue];
        [[EHETchCommunicationManager getInstance] loadOrderDetailWithOrderId:orderid];
        EHEOrder *order = [[EHETchCoreDataManager getInstance] fetchOrderWithOrderId:orderid];

        EHETchOrderDetailViewController *detailViewController = [[EHETchOrderDetailViewController alloc] initWithNibName:nil bundle:nil];
        detailViewController.order = order;
        
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] init];
        [leftBarButtonItem setTitle:@"返回列表"];
        [leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
        [leftBarButtonItem setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor greenColor]}  forState:UIControlStateNormal];
        EHETchSearchingViewController *searching = [[[self.tab.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
        [searching.navigationController pushViewController:detailViewController animated:YES];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#if __IPHONE_8_0 <= __IPHONE_OS_VERSION_MAX_ALLOWED
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
#endif

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //这里需要判断是否登录，必须使用登录后的id，如果第一次使用，那么id没有那就传一个0过去，那么ownerid就是0，然后下次有了用户了，则将对应的deviceToken更新成该用户的。
    NSLog(@"%@",deviceToken);
    NSString * deviceTokenStr = deviceToken.description;
    deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
    deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@">" withString:@""];
    //将deviceToken弄成一个没有<>和空格的连续64位字符串。
    deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    //拿到token之后，发送请求，然后存入服务器。
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@api/common/devicetokenregister.action",kURLDomain ]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString * postData = [NSString stringWithFormat:@"info={\"devicetoken\":\"%@\",\"tokentype\":1,\"ownerid\":135,\"multipledevice\":0}",deviceTokenStr];
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSLog(@"data:%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    NSLog(@"%@",postData);
    NSLog(@"error:%@",error);
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //收到推送通知的方法
    int orderid = [userInfo[@"orderId"] intValue];
    [[EHETchCommunicationManager getInstance] loadOrderDetailWithOrderId:orderid];
    EHEOrder *order = [[EHETchCoreDataManager getInstance] fetchOrderWithOrderId:orderid];
    EHETchOrderDetailViewController *detailViewController = [[EHETchOrderDetailViewController alloc] initWithNibName:nil bundle:nil];
    detailViewController.order = order;
    EHETchSearchingViewController *searching = [[[self.tab.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
    [searching.navigationController pushViewController:detailViewController animated:YES];
    
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "appchen.EHomeEducation_Tch" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"EHomeEducation_Tch" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"EHomeEducation_Tch.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [[viewController tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kGreenForTabbaritem, NSForegroundColorAttributeName, [UIFont fontWithName:@"FZKATJW--GB1-0" size:15], NSFontAttributeName, nil]  forState:UIControlStateNormal];
    
    for (int i = 0; i < 3; i++) {
        if (i != self.tab.selectedIndex ) {
            [[[self.tab.viewControllers objectAtIndex:i] tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"FZKATJW--GB1-0" size:15], NSFontAttributeName, nil]  forState:UIControlStateNormal];
        }
    }
}

@end
