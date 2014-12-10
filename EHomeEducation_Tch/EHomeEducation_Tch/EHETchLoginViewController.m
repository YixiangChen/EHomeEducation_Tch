//
//  EHETchLoginViewController.m
//  EHomeEduTeacher
//
//  Created by MacBook Pro on 14-12-9.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHETchLoginViewController.h"
#import "EHETchCommunicationManager.h"
#import "Defines.h"
#import "EHETchRegisterViewController.h"
@interface EHETchLoginViewController ()

@end

@implementation EHETchLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView * headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    headImageView.image=[UIImage imageNamed:@"loginpicture.jpg"];
    [self.view addSubview:headImageView];
    
    self.userNameTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 170, 230, 40)];
    self.userNameTextField.borderStyle=UITextBorderStyleNone;
    self.userNameTextField.placeholder=@"请输入用户名.....";
    [self.view addSubview:self.userNameTextField];
    
    UIImageView * userNameAccessoryImage=[[UIImageView alloc]initWithFrame:CGRectMake(25, 175, 30, 30)];
    userNameAccessoryImage.image=[UIImage imageNamed:@"L]NZ0([W6E`U~9CO{6NGI{L.jpg"];
    [self.view addSubview:userNameAccessoryImage];
    
    self.passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 220, 230, 40)];
    self.passwordTextField.borderStyle=UITextBorderStyleNone;
    self.passwordTextField.placeholder=@"请输入密码......";
    [self.view addSubview:self.passwordTextField];
    
    UIImageView * passwordAccessoryImage=[[UIImageView alloc]initWithFrame:CGRectMake(25, 225, 30, 30)];
    passwordAccessoryImage.image=[UIImage imageNamed:@"code"];
    [self.view addSubview:passwordAccessoryImage];
    
    UIImageView * spliteLine1=[[UIImageView alloc]initWithFrame:CGRectMake(22, 210, 268, 2)];
    spliteLine1.image=[UIImage imageNamed:@"loginSpliteLine"];
    spliteLine1.alpha=0.8f;
    [self.view addSubview:spliteLine1];
    
    UIImageView * spliteLine2=[[UIImageView alloc]initWithFrame:CGRectMake(22, 260, 268, 2)];
    spliteLine2.image=[UIImage imageNamed:@"loginSpliteLine"];
    spliteLine2.alpha=0.8f;
    [self.view addSubview:spliteLine2];
    
    self.userNameTextField.delegate=self;
    self.passwordTextField.delegate=self;
    self.passwordTextField.secureTextEntry=YES;

    self.loginButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.loginButton.frame=CGRectMake(22, 290, 268, 40);
    self.loginButton.backgroundColor=[UIColor colorWithRed:192.0 / 256.0 green:233 / 256.0 blue:189 / 256.0 alpha:1.0f];
    [self.loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginButton.titleLabel.font=[UIFont fontWithName:kYueYuanFont size:16.0f];
    
    [self.loginButton addTarget:self action:@selector(loignButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton.layer setMasksToBounds:YES];
    [self.loginButton.layer setCornerRadius:10];
    [self.loginButton.layer setBorderWidth:0.5];
    [self.loginButton.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.view addSubview:self.loginButton];
    
    self.forgetPasswordButton=[UIButton buttonWithType:UIButtonTypeSystem];
    self.forgetPasswordButton.frame=CGRectMake(30, 370, 100, 30);
    [self.forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetPasswordButton setTitleColor:[UIColor colorWithRed:192.0 / 256.0 green:233 / 256.0 blue:189 / 256.0 alpha:1.0f] forState:UIControlStateNormal];
    self.forgetPasswordButton.titleLabel.font=[UIFont fontWithName:kYueYuanFont size:16.0f];
    [self.view addSubview:self.forgetPasswordButton];
    
    self.registerButton=[UIButton buttonWithType:UIButtonTypeSystem];
    self.registerButton.frame=CGRectMake(190, 370, 100, 30);
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor colorWithRed:192.0 / 256.0 green:233 / 256.0 blue:189 / 256.0 alpha:1.0f] forState:UIControlStateNormal];
    self.registerButton.titleLabel.font=[UIFont fontWithName:kYueYuanFont size:16.0f];
    [self.registerButton addTarget:self action:@selector(registerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loignButtonClicked:(id)sender
{
    NSString * userName=self.userNameTextField.text;
    NSString * password=self.passwordTextField.text;
    if(userName==nil||password==nil)
    {
        UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"用户名或密码不得为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
    NSLog(@"username=%@,password=%@",userName,password);
    EHETchCommunicationManager * communicationManager=[EHETchCommunicationManager getInstance];
    BOOL ifLogin=[communicationManager loginWithName:userName andPassword:password];
    if(ifLogin)
    {
        [self saveUserNameAndPassword];
        //登陆成功后，获取教师头像并且存到本地：
        NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
        NSString * teacherIcon=[userDefaults objectForKey:@"teacherIcon"];
        
        [communicationManager loadTeacherIconForTeacher:teacherIcon completionBlock:^(NSString * icon) {
        }];
        [self.navigationController popViewControllerAnimated:NO];
    }
    else
    {
        UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"登陆失败，用户名或密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    }
}
-(void)registerButtonClicked:(id)sender
{
    EHETchRegisterViewController * registerViewController=[[EHETchRegisterViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:registerViewController animated:YES];
}
-(void)saveUserNameAndPassword
{
    NSString * userName=self.userNameTextField.text;
    NSString * password=self.passwordTextField.text;
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userName forKey:@"userName"];
    [userDefaults setObject:password forKey:@"passWord"];
    [userDefaults synchronize];
    
}
//点击背景两个TextField放弃第一响应者身份
-(IBAction)backgrounCliked:(id)sender
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
#pragma mark- TextField Delegate Method
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    return YES;
}

@end
