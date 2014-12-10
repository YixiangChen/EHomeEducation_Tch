//
//  EHETchBookingDetailViewController.h
//  EHomeEduTeacher
//
//  Created by MacBook Pro on 14-12-10.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHEOrder.h"
#import "EHECustomer.h"
@interface EHETchBookingDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) EHEOrder * order;
@property (strong, nonatomic) EHECustomer * customer;
@end
