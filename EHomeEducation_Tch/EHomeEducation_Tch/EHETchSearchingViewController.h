//
//  EHETchSearchingViewController.h
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/2/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "EHETchCoreDataManager.h"
#import "EHEOrder.h"
#import "EHETchOrderTableViewCell.h"

#import "EHETchFilterByDistanceViewController.h"
#import "EHETchFilterBySubjectViewController.h"
#import "EHETchFilterByGradeViewController.h"
#import "EHETchFilterByEvaluationViewController.h"

@interface EHETchSearchingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic) EHETchCoreDataManager *coreDataManager;
@property (strong,nonatomic) NSMutableArray *allOrders;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *filterView;

@property (strong, nonatomic) EHETchFilterByDistanceViewController * filterByDistanceController;
@property (strong, nonatomic) EHETchFilterBySubjectViewController * filterBySubjectsController;
@property (strong, nonatomic) EHETchFilterByGradeViewController * filterByGradeController;
@property (strong, nonatomic) EHETchFilterByEvaluationViewController * filterByEvaluationController;

@end
