//
//  EHETchOrderHeaderCell.m
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/3/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHETchOrderHeaderCell.h"
#import "Defines.h"
#import <CoreLocation/CoreLocation.h>

@implementation EHETchOrderHeaderCell

- (void)awakeFromNib {
    // Initialization code
    [self.btnMoreInfos setBackgroundColor:kLightGreenForMainColor];
    [self.btnMoreInfos setTitle:@"TA是谁？" forState:UIControlStateNormal];
    [self.btnMoreInfos.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:15]];
    [self.btnMoreInfos.titleLabel setTextColor:[UIColor whiteColor]];
    [self.btnMoreInfos addTarget:self action:@selector(showMoreInfo) forControlEvents:UIControlEventTouchUpInside];
    CALayer * layer =  [self.btnMoreInfos layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:5.0];
    [layer setBorderWidth:1.5];
    [layer setBorderColor:[[UIColor lightGrayColor] CGColor]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) showMoreInfo {
    NSLog(@"Showing more info");
}

-(void)setContent:(EHEOrder *)order {
    self.lblDistance.text = [EHETchOrderHeaderCell calculateDistanceFromOriginLatitude:40.00 andOriginLong:117 ToDestinationLatitude:[order.latitude floatValue] andDesLong:[order.longitude floatValue]];
    
    [self.lblDistance setFont:[UIFont fontWithName:kMengNaFont size:11]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:order.orderdate];
    NSLog(@"date = %@", date);
    
    self.lblOrderdate.text = [EHETchOrderHeaderCell compareCurrentTime:date];
    [self.lblOrderdate setFont:[UIFont fontWithName:kMengNaFont size:11]];
}

+ (NSString *) compareCurrentTime:(NSDate*) compareDate
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

+ (NSString *)calculateDistanceFromOriginLatitude:(float)originLat andOriginLong:(float)originLong ToDestinationLatitude:(float)desLat andDesLong:(float)desLong {
    CLLocation * origin = [[CLLocation alloc] initWithLatitude:originLat longitude:originLong];
    CLLocation * destination = [[CLLocation alloc] initWithLatitude:desLat longitude:desLong];
    
    CLLocationDistance distance = [origin distanceFromLocation:destination] / 1000;
    return [NSString stringWithFormat:@"%.02f km", distance];
}

@end
