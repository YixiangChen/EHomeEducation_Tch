//
//  EHETchFilterBySubjectViewController.m
//  EHomeEduTeacher
//
//  Created by Yixiang Chen on 12/6/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHETchFilterBySubjectViewController.h"
#import "Defines.h"

@interface EHETchFilterBySubjectViewController ()

@property bool isChineseSelected;
@property bool isEnglishSelected;
@property bool isMathSelected;
@property bool isPhysicSelected;
@property bool isChemSelected;
@property bool isBioSelected;
@property bool isGeoSelected;
@property bool isHistorySelected;
@property bool isPoliticSelected;
@property bool isMusicSelected;
@property bool isDanceSelected;



@end

@implementation EHETchFilterBySubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.btnSearch setTitleColor:kLightGreenForMainColor forState:UIControlStateNormal];
    [self.btnSearch addTarget:self action:@selector(applyFilter) forControlEvents:UIControlEventTouchUpInside];
    [self.btnSearch.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:17]];
    
    [self.lblChinese setTextColor:kLightGreenForMainColor];
    [self.lblChinese setFont:[UIFont fontWithName:kMengNaFont size:16]];
    
    [self.lblMath setTextColor:kLightGreenForMainColor];
    [self.lblMath setFont:[UIFont fontWithName:kMengNaFont size:16]];
    
    [self.lblEnglish setTextColor:kLightGreenForMainColor];
    [self.lblEnglish setFont:[UIFont fontWithName:kMengNaFont size:16]];
    
    [self.lblBio setTextColor:kLightGreenForMainColor];
    [self.lblBio setFont:[UIFont fontWithName:kMengNaFont size:16]];
    
    [self.lblPhysic setTextColor:kLightGreenForMainColor];
    [self.lblPhysic setFont:[UIFont fontWithName:kMengNaFont size:16]];
    
    [self.lblChem setTextColor:kLightGreenForMainColor];
    [self.lblChem setFont:[UIFont fontWithName:kMengNaFont size:16]];
    
    [self.lblGeo setTextColor:kLightGreenForMainColor];
    [self.lblGeo setFont:[UIFont fontWithName:kMengNaFont size:16]];
    
    [self.lblHistory setTextColor:kLightGreenForMainColor];
    [self.lblHistory setFont:[UIFont fontWithName:kMengNaFont size:16]];
    
    [self.lblPolitic setTextColor:kLightGreenForMainColor];
    [self.lblPolitic setFont:[UIFont fontWithName:kMengNaFont size:16]];
    
    [self.lblDance setTextColor:kLightGreenForMainColor];
    [self.lblDance setFont:[UIFont fontWithName:kMengNaFont size:16]];
    
    [self.lblMusic setTextColor:kLightGreenForMainColor];
    [self.lblMusic setFont:[UIFont fontWithName:kMengNaFont size:16]];
    
    
    [self.btnChinese setTitle:@" " forState:UIControlStateNormal];
    [self.btnChinese addTarget:self action:@selector(chineseSelected) forControlEvents:UIControlEventTouchUpInside];
    //[self.maleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UICon];
    CALayer * btnChineseLayer =  [self.btnChinese layer];
    [btnChineseLayer setMasksToBounds:YES];
    [btnChineseLayer setCornerRadius:10.0];
    [btnChineseLayer setBorderWidth:2.0];
    [btnChineseLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [self.btnEnglish setTitle:@" " forState:UIControlStateNormal];
    [self.btnEnglish addTarget:self action:@selector(englishSelected) forControlEvents:UIControlEventTouchUpInside];
    //[self.maleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UICon];
    CALayer * btnEnglishLayer =  [self.btnEnglish layer];
    [btnEnglishLayer setMasksToBounds:YES];
    [btnEnglishLayer setCornerRadius:10.0];
    [btnEnglishLayer setBorderWidth:2.0];
    [btnEnglishLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [self.btnMath setTitle:@" " forState:UIControlStateNormal];
    [self.btnMath addTarget:self action:@selector(mathSelected) forControlEvents:UIControlEventTouchUpInside];
    //[self.maleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UICon];
    CALayer * btnMathLayer =  [self.btnMath layer];
    [btnMathLayer setMasksToBounds:YES];
    [btnMathLayer setCornerRadius:10.0];
    [btnMathLayer setBorderWidth:2.0];
    [btnMathLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [self.btnPhysic setTitle:@" " forState:UIControlStateNormal];
    [self.btnPhysic addTarget:self action:@selector(physicSelected) forControlEvents:UIControlEventTouchUpInside];
    //[self.maleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UICon];
    CALayer * btnPhysicLayer =  [self.btnPhysic layer];
    [btnPhysicLayer setMasksToBounds:YES];
    [btnPhysicLayer setCornerRadius:10.0];
    [btnPhysicLayer setBorderWidth:2.0];
    [btnPhysicLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [self.btnChem setTitle:@" " forState:UIControlStateNormal];
    [self.btnChem addTarget:self action:@selector(chemSelected) forControlEvents:UIControlEventTouchUpInside];
    //[self.maleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UICon];
    CALayer * btnChemLayer =  [self.btnChem layer];
    [btnChemLayer setMasksToBounds:YES];
    [btnChemLayer setCornerRadius:10.0];
    [btnChemLayer setBorderWidth:2.0];
    [btnChemLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [self.btnBio setTitle:@" " forState:UIControlStateNormal];
    [self.btnBio addTarget:self action:@selector(bioSelected) forControlEvents:UIControlEventTouchUpInside];
    //[self.maleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UICon];
    CALayer * btnBioLayer =  [self.btnBio layer];
    [btnBioLayer setMasksToBounds:YES];
    [btnBioLayer setCornerRadius:10.0];
    [btnBioLayer setBorderWidth:2.0];
    [btnBioLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [self.btnGeo setTitle:@" " forState:UIControlStateNormal];
    [self.btnGeo addTarget:self action:@selector(geoSelected) forControlEvents:UIControlEventTouchUpInside];
    //[self.maleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UICon];
    CALayer * btnGeoLayer =  [self.btnGeo layer];
    [btnGeoLayer setMasksToBounds:YES];
    [btnGeoLayer setCornerRadius:10.0];
    [btnGeoLayer setBorderWidth:2.0];
    [btnGeoLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [self.btnPolitic setTitle:@" " forState:UIControlStateNormal];
    [self.btnPolitic addTarget:self action:@selector(politicSelected) forControlEvents:UIControlEventTouchUpInside];
    //[self.maleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UICon];
    CALayer * btnPoliticLayer =  [self.btnPolitic layer];
    [btnPoliticLayer setMasksToBounds:YES];
    [btnPoliticLayer setCornerRadius:10.0];
    [btnPoliticLayer setBorderWidth:2.0];
    [btnPoliticLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [self.btnHistory setTitle:@" " forState:UIControlStateNormal];
    [self.btnHistory addTarget:self action:@selector(historySelected) forControlEvents:UIControlEventTouchUpInside];
    //[self.maleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UICon];
    CALayer * btnHistoryLayer =  [self.btnHistory layer];
    [btnHistoryLayer setMasksToBounds:YES];
    [btnHistoryLayer setCornerRadius:10.0];
    [btnHistoryLayer setBorderWidth:2.0];
    [btnHistoryLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [self.btnMusic setTitle:@" " forState:UIControlStateNormal];
    [self.btnMusic addTarget:self action:@selector(musicSelected) forControlEvents:UIControlEventTouchUpInside];
    //[self.maleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UICon];
    CALayer * btnMusicLayer =  [self.btnMusic layer];
    [btnMusicLayer setMasksToBounds:YES];
    [btnMusicLayer setCornerRadius:10.0];
    [btnMusicLayer setBorderWidth:2.0];
    [btnMusicLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [self.btnDance setTitle:@" " forState:UIControlStateNormal];
    [self.btnDance addTarget:self action:@selector(danceSelected) forControlEvents:UIControlEventTouchUpInside];
    //[self.maleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UICon];
    CALayer * btnDanceLayer =  [self.btnDance layer];
    [btnDanceLayer setMasksToBounds:YES];
    [btnDanceLayer setCornerRadius:10.0];
    [btnDanceLayer setBorderWidth:2.0];
    [btnDanceLayer setBorderColor:[[UIColor grayColor] CGColor]];
    

}

-(void) chineseSelected {
    self.isChineseSelected = !self.isChineseSelected;
    if (self.isChineseSelected) {
        [self.btnChinese setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
    } else {
        [self.btnChinese setBackgroundImage:nil forState:UIControlStateNormal];
    }
    
}

-(void) englishSelected {
    self.isEnglishSelected = !self.isEnglishSelected;
    if (self.isEnglishSelected) {
        [self.btnEnglish setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
    } else {
        [self.btnEnglish setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void) mathSelected {
    self.isMathSelected = !self.isMathSelected;
    if (self.isMathSelected) {
        [self.btnMath setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
    } else {
        [self.btnMath setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void) physicSelected {
    self.isPhysicSelected = !self.isPhysicSelected;
    if (self.isPhysicSelected) {
        [self.btnPhysic setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
    } else {
        [self.btnPhysic setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void) chemSelected {
    self.isChemSelected = !self.isChemSelected;
    if (self.isChemSelected) {
        [self.btnChem setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
    } else {
        [self.btnChem setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void) bioSelected {
    self.isBioSelected = !self.isBioSelected;
    if (self.isBioSelected) {
        [self.btnBio setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
    } else {
        [self.btnBio setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void) geoSelected {
    self.isGeoSelected = !self.isGeoSelected;
    if (self.isGeoSelected) {
        [self.btnGeo setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
    } else {
        [self.btnGeo setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void) politicSelected {
    self.isPoliticSelected = !self.isPoliticSelected;
    if (self.isPoliticSelected) {
        [self.btnPolitic setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
    } else {
        [self.btnPolitic setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void) historySelected {
    self.isHistorySelected = !self.isHistorySelected;
    if (self.isHistorySelected) {
        [self.btnHistory setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
    } else {
        [self.btnHistory setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void) musicSelected {
    self.isMusicSelected = !self.isMusicSelected;
    if (self.isMusicSelected) {
        [self.btnMusic setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
    } else {
        [self.btnMusic setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void) danceSelected {
    self.isDanceSelected = !self.isDanceSelected;
    if (self.isDanceSelected) {
        [self.btnDance setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
    } else {
        [self.btnDance setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void) applyFilter {
    [self.popController dismissPopoverAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
