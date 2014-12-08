//
//  EHETchFilterByDistanceViewController.m
//  EHomeEduTeacher
//
//  Created by Yixiang Chen on 12/6/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//
#import "Defines.h"
#import "EHETchFilterByDistanceViewController.h"

@interface EHETchFilterByDistanceViewController ()

@end

@implementation EHETchFilterByDistanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.btnSearching setTitleColor:kLightGreenForMainColor forState:UIControlStateNormal];
    [self.btnSearching addTarget:self action:@selector(applyFilter) forControlEvents:UIControlEventTouchUpInside];
    [self.btnSearching.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:17]];
    
    [self.lblWithinKM setTextColor:kLightGreenForMainColor];
    [self.lblWithinKM setFont:[UIFont fontWithName:kMengNaFont size:16]];
    
    
}


-(void) applyFilter {
    [self.popController dismissPopoverAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return  YES;
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
