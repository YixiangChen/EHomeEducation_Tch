//
//  EHETchFilterByDistanceViewController.h
//  EHomeEduTeacher
//
//  Created by Yixiang Chen on 12/6/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"

@interface EHETchFilterByDistanceViewController : UIViewController
@property (strong, nonatomic) FPPopoverController *popController;
@property (strong, nonatomic) IBOutlet UITextField *txtDistance;
@property (strong, nonatomic) IBOutlet UILabel *lblWithinKM;
@property (strong, nonatomic) IBOutlet UIButton *btnSearching;

@end
