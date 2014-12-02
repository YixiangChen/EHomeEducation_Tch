//
//  EHETchOrderTableViewCell.h
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/2/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHEOrder.h"

@interface EHETchOrderTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblSubject;
@property (strong, nonatomic) IBOutlet UILabel *lblObject;
@property (strong, nonatomic) IBOutlet UILabel *lblDistance;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderdate;

-(void)setContent:(EHEOrder*) order;
@end
