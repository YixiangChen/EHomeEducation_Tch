//
//  EHETchOrderRegularCell.m
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/3/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//
#import "Defines.h"
#import "EHETchOrderRegularCell.h"

@implementation EHETchOrderRegularCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setContent:(EHEOrder *)order withRowIndex:(int)index {
    [self.lblItem setFont:[UIFont fontWithName:kMengNaFont size:11]];
    [self.lblItem setTextColor:[UIColor lightGrayColor]];
    [self.lblItemContent setFont:[UIFont fontWithName:kMengNaFont size:11]];
    if (index == 2) {
        self.lblItem.text = @"辅导科目";
        self.lblItemContent.text = [NSString stringWithFormat:@"%@  %@", order.objectinfo, order.subjectinfo];
    }
    
    if (index == 3) {
        self.lblItem.text = @"辅导时间";
        self.lblItemContent.text = order.timeperiod;
    }
    
    if (index == 4) {
        self.lblItem.text = @"辅导地点";
        self.lblItemContent.text = order.serviceaddress;
    }
    
    if (index == 5) {
        self.lblItem.text = @"备注";
        self.lblItemContent.text = order.memo;
    }
    
    if (index == 7) {
        self.lblItem.text = @"个人详情";
        self.lblItemContent.text = @"";
    }
}

@end
