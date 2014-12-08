//
//  EHETchFilterByGradeViewController.h
//  EHomeEduTeacher
//
//  Created by Yixiang Chen on 12/6/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"

@interface EHETchFilterByGradeViewController : UIViewController
@property (strong, nonatomic) FPPopoverController *popController;
@property (strong, nonatomic) IBOutlet UILabel *lblPrimary;
@property (strong, nonatomic) IBOutlet UILabel *lblSecondary;
@property (strong, nonatomic) IBOutlet UILabel *lblHighSchool;
@property (strong, nonatomic) IBOutlet UIButton *btnPrimary;
@property (strong, nonatomic) IBOutlet UIButton *btnSecondary;
@property (strong, nonatomic) IBOutlet UIButton *btnHighSchool;
@property (strong, nonatomic) IBOutlet UIButton *btnSearch;


@property bool isPrimarySelected;
@property bool isSecondarySelected;
@property bool isHighSchoolSelected;


@end
