//
//  EHETchBookingManagerViewController.h
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/2/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface EHETchBookingManagerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic)BOOL wetherGetOrdersSuccessful;
@property(strong,nonatomic)NSArray * allOrdersArray;
@property(strong,nonatomic)UITableView * orderTableView;
@property(strong,nonatomic)NSMutableArray * confirmedOrders;
@property(strong,nonatomic)NSMutableArray * canceledOrders;
@property(strong,nonatomic)NSMutableArray * unfinsihedOrders;
@property(strong,nonatomic)NSMutableArray * finishedOrders;
@property(strong,nonatomic)NSMutableDictionary * ordersDictionary;
@end
