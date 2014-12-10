//
//  EHETchBookingHeaderCell.h
//  EHomeEduTeacher
//
//  Created by MacBook Pro on 14-12-10.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHEOrder.h"
#import "EHETchOrderDetailViewController.h"
#import "EHETchBookingDetailViewController.h"
@interface EHETchBookingHeaderCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblDistance;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderdate;
@property (strong, nonatomic) IBOutlet UIButton *btnMoreInfos;
@property(strong,nonatomic)EHETchBookingDetailViewController * bookingDetailViewController;
+(NSString *) compareCurrentTime:(NSDate*) compareDate;
+(NSString *) calculateDistanceFromOriginLatitude:(float) originLat andOriginLong:(float) originLong ToDestinationLatitude:(float)desLat andDesLong:(float) desLong;
-(void) setContent:(EHEOrder *) order;
@end
