//
//  EHETchSettingViewController.h
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/2/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHETchSettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView * settingTableView;
@property(strong,nonatomic)NSArray * personalInfomationArray;
@property(strong,nonatomic)NSArray * systemSettingArray;
@property(strong,nonatomic)NSArray * connectAndShareArray;
@property(strong,nonatomic)NSArray * testArray;
@property(nonatomic)BOOL check;
@end
