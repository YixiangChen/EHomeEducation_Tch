//
//  EHETchFilterByGradeViewController.m
//  EHomeEduTeacher
//
//  Created by Yixiang Chen on 12/6/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//
#import "Defines.h"
#import "EHETchFilterByGradeViewController.h"

@interface EHETchFilterByGradeViewController ()

@end

@implementation EHETchFilterByGradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.btnSearch setTitleColor:kLightGreenForMainColor forState:UIControlStateNormal];
    [self.btnSearch addTarget:self action:@selector(applyFilter) forControlEvents:UIControlEventTouchUpInside];
    [self.btnSearch.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:17]];
    
    
    [self.lblPrimary setTextColor:kLightGreenForMainColor];
    [self.lblPrimary setFont:[UIFont fontWithName:kMengNaFont size:16]];
    
    [self.lblSecondary setTextColor:kLightGreenForMainColor];
    [self.lblSecondary setFont:[UIFont fontWithName:kMengNaFont size:16]];
    
    [self.lblHighSchool setTextColor:kLightGreenForMainColor];
    [self.lblHighSchool setFont:[UIFont fontWithName:kMengNaFont size:16]];


    [self.btnPrimary setTitle:@" " forState:UIControlStateNormal];
    [self.btnPrimary addTarget:self action:@selector(primarySelected) forControlEvents:UIControlEventTouchUpInside];
    //[self.maleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UICon];
    CALayer * btnPrimaryLayer =  [self.btnPrimary layer];
    [btnPrimaryLayer setMasksToBounds:YES];
    [btnPrimaryLayer setCornerRadius:10.0];
    [btnPrimaryLayer setBorderWidth:2.0];
    [btnPrimaryLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [self.btnSecondary setTitle:@" " forState:UIControlStateNormal];
    [self.btnSecondary addTarget:self action:@selector(secondarySelected) forControlEvents:UIControlEventTouchUpInside];
    //[self.maleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UICon];
    CALayer * btnSecondaryLayer =  [self.btnSecondary layer];
    [btnSecondaryLayer setMasksToBounds:YES];
    [btnSecondaryLayer setCornerRadius:10.0];
    [btnSecondaryLayer setBorderWidth:2.0];
    [btnSecondaryLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [self.btnHighSchool setTitle:@" " forState:UIControlStateNormal];
    [self.btnHighSchool addTarget:self action:@selector(highSchoolSelected) forControlEvents:UIControlEventTouchUpInside];
    //[self.maleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UICon];
    CALayer * btnHighSchoolLayer =  [self.btnHighSchool layer];
    [btnHighSchoolLayer setMasksToBounds:YES];
    [btnHighSchoolLayer setCornerRadius:10.0];
    [btnHighSchoolLayer setBorderWidth:2.0];
    [btnHighSchoolLayer setBorderColor:[[UIColor grayColor] CGColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) primarySelected {
    self.isPrimarySelected = !self.isPrimarySelected;
    if (self.isPrimarySelected) {
        [self.btnPrimary setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
    } else {
        [self.btnPrimary setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void) secondarySelected {
    self.isSecondarySelected = !self.isSecondarySelected;
    if (self.isSecondarySelected) {
        [self.btnSecondary setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
    } else {
        [self.btnSecondary setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void) highSchoolSelected {
 
    self.isHighSchoolSelected = !self.isHighSchoolSelected;
    if (self.isHighSchoolSelected) {
        [self.btnHighSchool setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
    } else {
        [self.btnHighSchool setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void) applyFilter {
    [self.popController dismissPopoverAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
