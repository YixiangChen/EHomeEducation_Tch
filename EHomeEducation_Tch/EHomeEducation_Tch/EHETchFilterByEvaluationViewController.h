//
//  EHETchFilterByEvaluationViewController.h
//  EHomeEduTeacher
//
//  Created by Yixiang Chen on 12/6/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"

@interface EHETchFilterByEvaluationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) FPPopoverController *popController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property int selectedIndex;

@end
