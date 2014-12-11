//
//  EHETchPersonalViewController.h
//  EHomeEducation_Tch
//
//  Created by MacBook Pro on 14-12-3.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EHETchSettingDetailViewController;
@interface EHETchPersonalViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView * tableView;
@property(strong,nonatomic)NSString * name;
@property(strong,nonatomic)NSString * telephoneNumber;
@property(strong,nonatomic)NSString * gender;
@property(strong,nonatomic)NSString * brithday;
@property(strong,nonatomic)UIImage * image;
@property(strong,nonatomic)NSString * identifier;
@property(strong,nonatomic)NSString * sinaWeibo;
@property(strong,nonatomic)NSString * qqNumber;
@property(strong,nonatomic)NSString * degree;
@property(strong,nonatomic)NSString * subjectInfo;
@property(strong,nonatomic)NSString * timeperiod;
@property(strong,nonatomic)NSString * objectInfo;
@property(strong,nonatomic)NSString * type;
@property(strong,nonatomic)EHETchSettingDetailViewController * settingDetail;
@end
