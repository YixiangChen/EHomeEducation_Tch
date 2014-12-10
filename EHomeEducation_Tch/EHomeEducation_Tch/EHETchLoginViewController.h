//
//  EHETchLoginViewController.h
//  EHomeEduTeacher
//
//  Created by MacBook Pro on 14-12-9.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHETchLoginViewController : UIViewController<UITextFieldDelegate>
@property(strong,nonatomic)UILabel * userNameLabel;
@property(strong,nonatomic)UILabel * passwordLabel;
@property(strong,nonatomic)UITextField * userNameTextField;
@property(strong,nonatomic)UITextField * passwordTextField;
@property(strong,nonatomic)UIButton * loginButton;
@property(strong,nonatomic)UIButton * registerButton;
@property(strong,nonatomic)UIButton * forgetPasswordButton;
-(IBAction)backgrounCliked:(id)sender;
@end
