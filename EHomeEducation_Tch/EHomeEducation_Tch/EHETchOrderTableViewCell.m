//
//  EHETchOrderTableViewCell.m
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/2/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHETchOrderTableViewCell.h"

@implementation EHETchOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setContent:(EHEOrder*) order
{
    self.lblName.text = order.customername;
    [self.lblName setFont:[UIFont fontWithName:@"FZKATJW--GB1-0" size:20]];
    
    self.lblOrderdate.text = order.orderdate;
    [self.lblOrderdate setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:10]];
    [self.lblOrderdate setTintColor:[UIColor lightGrayColor]];
    
    self.lblObject.text = order.objectinfo;
    [self.lblObject setFont:[UIFont fontWithName:@"FZKATJW--GB1-0" size:15]];
    
    self.lblSubject.text = order.subjectinfo;
    [self.lblSubject setFont:[UIFont fontWithName:@"FZKATJW--GB1-0" size:15]];
    
    
    self.lblDistance.text = [NSString stringWithFormat:@"10.0 km"];
    [self.lblDistance setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:10]];
    [self.lblDistance setTintColor:[UIColor lightGrayColor]];
    
}

@end
