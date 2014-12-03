//
//  EHETchOrderRegularCell.h
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/3/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHEOrder.h"

@interface EHETchOrderRegularCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblItem;
@property (strong, nonatomic) IBOutlet UILabel *lblItemContent;

-(void) setContent:(EHEOrder *) order withRowIndex:(int) index;
@end
