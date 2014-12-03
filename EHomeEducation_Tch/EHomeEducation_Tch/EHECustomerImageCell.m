//
//  EHECustomerImageCell.m
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/3/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHECustomerImageCell.h"
#import "Defines.h"

@implementation EHECustomerImageCell

- (void)awakeFromNib {
    // Initialization code
    
    self.imageViewCustomerIcon.layer.cornerRadius = 38.0f;
    self.imageViewCustomerIcon.clipsToBounds=YES;
    
    [self.lblName setFont:[UIFont fontWithName:kFangZhengKaTongFont size:18]];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
