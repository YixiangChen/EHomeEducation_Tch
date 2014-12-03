//
//  EHETchOrderHeaderCell.h
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/3/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHEOrder.h"

@interface EHETchOrderHeaderCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblDistance;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderdate;
@property (strong, nonatomic) IBOutlet UIButton *btnMoreInfos;

+(NSString *) compareCurrentTime:(NSDate*) compareDate;
+(NSString *) calculateDistanceFromOriginLatitude:(float) originLat andOriginLong:(float) originLong ToDestinationLatitude:(float)desLat andDesLong:(float) desLong;
-(void) setContent:(EHEOrder *) order;

@end
