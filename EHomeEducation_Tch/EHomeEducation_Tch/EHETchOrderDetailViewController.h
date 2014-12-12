//
//  EHETchOrderDetailViewController.h
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/2/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHEOrder.h"
#import "EHECustomer.h"

@interface EHETchOrderDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) EHEOrder * order;
@property (strong, nonatomic) EHECustomer * customer;

@end
