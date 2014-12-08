//
//  EHETchFilterBySubjectViewController.h
//  EHomeEduTeacher
//
//  Created by Yixiang Chen on 12/6/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"

@interface EHETchFilterBySubjectViewController : UIViewController
@property (strong, nonatomic) FPPopoverController *popController;
@property (strong, nonatomic) IBOutlet UILabel *lblChinese;
@property (strong, nonatomic) IBOutlet UILabel *lblMath;
@property (strong, nonatomic) IBOutlet UILabel *lblEnglish;
@property (strong, nonatomic) IBOutlet UILabel *lblPhysic;
@property (strong, nonatomic) IBOutlet UILabel *lblChem;
@property (strong, nonatomic) IBOutlet UILabel *lblBio;
@property (strong, nonatomic) IBOutlet UILabel *lblGeo;
@property (strong, nonatomic) IBOutlet UILabel *lblHistory;
@property (strong, nonatomic) IBOutlet UILabel *lblPolitic;
@property (strong, nonatomic) IBOutlet UILabel *lblMusic;
@property (strong, nonatomic) IBOutlet UILabel *lblDance;
@property (strong, nonatomic) IBOutlet UIButton *btnChinese;
@property (strong, nonatomic) IBOutlet UIButton *btnMath;
@property (strong, nonatomic) IBOutlet UIButton *btnEnglish;
@property (strong, nonatomic) IBOutlet UIButton *btnPhysic;
@property (strong, nonatomic) IBOutlet UIButton *btnChem;
@property (strong, nonatomic) IBOutlet UIButton *btnBio;
@property (strong, nonatomic) IBOutlet UIButton *btnGeo;
@property (strong, nonatomic) IBOutlet UIButton *btnHistory;
@property (strong, nonatomic) IBOutlet UIButton *btnPolitic;
@property (strong, nonatomic) IBOutlet UIButton *btnMusic;
@property (strong, nonatomic) IBOutlet UIButton *btnDance;
@property (strong, nonatomic) IBOutlet UIButton *btnSearch;


@end
