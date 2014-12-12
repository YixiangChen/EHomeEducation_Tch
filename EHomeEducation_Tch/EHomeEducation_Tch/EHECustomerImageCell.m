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
    
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    if(screenWidth==320&&screenHeight==480)
    {
        self.imageViewBackground=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 145)];
        self.imageViewCustomerIcon=[[UIImageView alloc]initWithFrame:CGRectMake(120, 24, 80, 80)];
        self.lblName=[[UILabel alloc]initWithFrame:CGRectMake(66, 112, 117, 21)];
        self.lblEvaluation=[[UILabel alloc]initWithFrame:CGRectMake(176, 112, 123, 21)];
        
    }
    else if(screenWidth==320&&screenHeight==568)
    {
         self.imageViewBackground=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 145)];
        self.imageViewCustomerIcon=[[UIImageView alloc]initWithFrame:CGRectMake(120, 24, 80, 80)];
        self.lblName=[[UILabel alloc]initWithFrame:CGRectMake(66, 112, 117, 21)];
         self.lblEvaluation=[[UILabel alloc]initWithFrame:CGRectMake(176, 112, 123, 21)];
    }
    else if(screenWidth==375&&screenHeight==667)
    {
         self.imageViewBackground=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 145)];
        self.imageViewCustomerIcon=[[UIImageView alloc]initWithFrame:CGRectMake(150, 24, 80, 80)];
        self.lblName=[[UILabel alloc]initWithFrame:CGRectMake(126, 112, 117, 21)];
         self.lblEvaluation=[[UILabel alloc]initWithFrame:CGRectMake(256, 112, 123, 21)];
    }
    else
    {
        self.imageViewBackground=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 414, 145)];
        self.imageViewCustomerIcon=[[UIImageView alloc]initWithFrame:CGRectMake(170, 24, 80, 80)];
        self.lblName=[[UILabel alloc]initWithFrame:CGRectMake(96, 112, 117, 21)];
        self.lblEvaluation=[[UILabel alloc]initWithFrame:CGRectMake(256, 112, 123, 21)];
    }
    self.imageViewBackground.image=[UIImage imageNamed:@"lightgreen.png"];
    self.imageViewCustomerIcon.image=[UIImage imageNamed:@"male_tablecell.png"];
    
    self.imageViewCustomerIcon.layer.cornerRadius = 38.0f;
    self.imageViewCustomerIcon.clipsToBounds=YES;
    
    self.lblName.textColor=[UIColor blackColor];
    self.lblName.backgroundColor=[UIColor clearColor];
    [self.lblName setFont:[UIFont fontWithName:kFangZhengKaTongFont size:18]];
    
    self.lblEvaluation.textColor=[UIColor blackColor];
    self.lblEvaluation.backgroundColor=[UIColor clearColor];
    [self.lblEvaluation setFont:[UIFont fontWithName:kFangZhengKaTongFont size:18]];
    
    
    
    [self addSubview:self.imageViewBackground];
    [self addSubview:self.imageViewCustomerIcon];
    [self addSubview:self.lblEvaluation];
    [self addSubview:self.lblName];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
