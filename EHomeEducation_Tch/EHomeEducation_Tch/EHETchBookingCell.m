//
//  EHETchBookingCell.m
//  EHomeEducation_Tch
//
//  Created by MacBook Pro on 14-12-3.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHETchBookingCell.h"

@implementation EHETchBookingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.studentIcon=[[UIImageView alloc]initWithFrame:CGRectMake(15, 13, 40, 40)];
        self.studentIcon.image=[UIImage imageNamed:@"little_student"];
        [self addSubview:self.studentIcon];
        
        self.studentNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 3, 150, 30)];
        self.studentNameLabel.textColor=[UIColor blackColor];
        self.studentNameLabel.backgroundColor=[UIColor clearColor];
        self.studentNameLabel.font=[UIFont fontWithName:@"MYoungHKS" size:15.0f];
        [self addSubview:self.studentNameLabel];
        
        self.subjectLabel=[[UILabel alloc]initWithFrame:CGRectMake(125, 3, 150, 30)];
        self.subjectLabel.textAlignment=UITextAlignmentRight;
        self.subjectLabel.textColor=[UIColor blackColor];
        self.subjectLabel.backgroundColor=[UIColor clearColor];
        self.subjectLabel.font=[UIFont fontWithName:@"FZKATJW--GB1-0" size:15.0f];
        [self addSubview:self.subjectLabel];
        
        self.orderDataLabel=[[UILabel alloc]initWithFrame:CGRectMake(70,33, 200, 30)];
        self.orderDataLabel.textColor=[UIColor grayColor];
        self.orderDataLabel.backgroundColor=[UIColor clearColor];
        self.orderDataLabel.font=[UIFont fontWithName:@"FZKATJW--GB1-0" size:13.0f];
        [self addSubview:self.orderDataLabel];
        
        
    }
    return self;
}
@end
