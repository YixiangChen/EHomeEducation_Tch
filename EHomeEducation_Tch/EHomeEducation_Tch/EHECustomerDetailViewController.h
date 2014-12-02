//
//  EHECustomerDetailViewController.h
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/2/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHEOrder.h"
#import "EHECustomer.h"

@interface EHECustomerDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (strong, nonatomic) EHEOrder *order;
@property (strong, nonatomic) EHECustomer *customer;

@property (strong, nonatomic) IBOutlet UIImageView *imageBackground;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
