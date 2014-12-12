//
//  EHETchPersonalViewController.m
//  EHomeEducation_Tch
//
//  Created by MacBook Pro on 14-12-3.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHETchPersonalViewController.h"
#import "EHETchSettingDetailCell.h"
#import "EHETchSettingDetailViewController.h"
#import "EHETchCommunicationManager.h"
#import "Defines.h"
@interface EHETchPersonalViewController ()
@property(strong,nonatomic)UIButton * leftBarButton;
@property(strong,nonatomic)UILabel * titleLabel;
@property(strong,nonatomic)UIButton * rightButton;
@end

@implementation EHETchPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if(screenWidth==320&&screenHeight==480)
    {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320,self.view.frame.size.height-50) style:UITableViewStyleGrouped];
    }
    else if(screenWidth==320&&screenHeight==568)
    {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320,568) style:UITableViewStyleGrouped];
    }
    else if(screenWidth==375&&screenHeight==667)
    {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375,568) style:UITableViewStyleGrouped];
    }
    else if(screenWidth==414&&screenHeight==736)
    {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,414,598) style:UITableViewStyleGrouped];
    }
    
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem * rightButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sendInfomation)];
    self.navigationItem.rightBarButtonItem=rightButton;
    
    //[self fetchInfomationFromUserDefault];
    
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.leftBarButtonItem=nil;
}

-(void)sendInfomation
{
    NSMutableDictionary * teacherInfoDic=[[NSMutableDictionary alloc]initWithCapacity:0];
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * teacherid=[userDefaults objectForKey:@"teacherid"];
    NSNumber * teacheridNumber=[NSNumber numberWithInt:teacherid.intValue];
    
    [teacherInfoDic setObject:teacheridNumber forKey:@"teacherid"];
    [teacherInfoDic setObject:self.name forKey:@"name"];
    [teacherInfoDic setObject:self.brithday forKey:@"birthday"];
    [teacherInfoDic setObject:self.gender forKey:@"gender"];
    [teacherInfoDic setObject:self.identifier forKey:@"identity"];
    [teacherInfoDic setObject:self.qqNumber forKey:@"qq"];
    [teacherInfoDic setObject:@"12343454@sina.com" forKey:@"sinaweibo"];
    [teacherInfoDic setObject:self.telephoneNumber forKey:@"telephone"];
    [teacherInfoDic setObject:self.degree forKey:@"degree"];
    [teacherInfoDic setObject:self.timeperiod forKey:@"timeperiod"];
    [teacherInfoDic setObject:self.objectInfo forKey:@"objectinfo"];
    [teacherInfoDic setObject:self.subjectInfo forKey:@"subjectinfo"];
    [teacherInfoDic setObject:@"" forKey:@"memo"];
    [teacherInfoDic setObject:@"北京石景山" forKey:@"majoraddress"];
    [teacherInfoDic setObject:@(39.164828374) forKey:@"latitude"];
    [teacherInfoDic setObject:@(116.37238379) forKey:@"longitude"];
    
    if([self.name isEqualToString:@""]||[self.brithday isEqualToString:@""]||[self.gender isEqualToString:@""]||[self.identifier isEqualToString:@""]||[self.qqNumber isEqualToString:@""]||[self.telephoneNumber isEqualToString:@""]||[self.degree isEqualToString:@""]||[self.timeperiod isEqualToString:@""]||[self.objectInfo isEqualToString:@""]||[self.subjectInfo isEqualToString:@""])
    {
      UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"各项不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        EHETchCommunicationManager * commucationManager=[EHETchCommunicationManager getInstance];
        BOOL ifComplete= [commucationManager completeProfileWithInfodict:teacherInfoDic];
        if(ifComplete)
        {
            NSLog(@"补充个人信息成功！");
        
            UIView * blackView=[[UIView alloc]init];
            blackView.center=self.view.center;
            blackView.backgroundColor=[UIColor blackColor];
            blackView.alpha=0.0f;
            blackView.frame=CGRectMake(120,180, 80, 80);
            blackView.layer.cornerRadius=20.0f;
            [self.view addSubview:blackView];
            
            UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(11, 25, 130, 30)];
            label1.textColor=[UIColor whiteColor];
            label1.backgroundColor=[UIColor clearColor];
            label1.text=@"发送成功";
            label1.font=[UIFont fontWithName:kFangZhengKaTongFont size:15.0f];
            [blackView addSubview:label1];
            
            [UIView animateWithDuration:1.0 animations:^{
                blackView.alpha=0.8f;
            }];
            [UIView animateWithDuration:2.5 animations:^{
                blackView.alpha=0.0f;
            }];
            
            [self saveTeacherInfomationWhenSendSuccessfully];
        }
        else
        {
            NSLog(@"补充个人信息失败！");
            UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"提交错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    }
}
-(void)saveTeacherInfomationWhenSendSuccessfully
{
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * teacherid=[userDefaults objectForKey:@"teacherid"];
    NSNumber * teacheridNumber=[NSNumber numberWithInt:teacherid.intValue];
    
    [userDefaults setObject:self.name forKey:@"name"];
    [userDefaults setObject:self.brithday forKey:[self getKey:@"birthday" andTeacherid:teacheridNumber]];
    [userDefaults setObject:self.gender forKey:@"gender"];
    [userDefaults setObject:self.identifier forKey:[self getKey:@"identifier" andTeacherid:teacheridNumber]];
    [userDefaults setObject:self.qqNumber forKey:@"qqNumber"];
    [userDefaults setObject:@"12343454@sina.com" forKey:[self getKey:@"12343454@sina.com" andTeacherid:teacheridNumber]];
    [userDefaults setObject:self.telephoneNumber forKey:@"telephone"];
    [userDefaults setObject:self.degree forKey:[self getKey:@"degree" andTeacherid:teacheridNumber]];
    [userDefaults setObject:self.timeperiod forKey:[self getKey:@"timeperiod" andTeacherid:teacheridNumber]];
    [userDefaults setObject:self.objectInfo forKey:[self getKey:@"objectInfo" andTeacherid:teacheridNumber]];
    [userDefaults setObject:self.subjectInfo forKey:[self getKey:@"subjectInfo" andTeacherid:teacheridNumber]];
    [userDefaults synchronize];
}
-(void)fetchInfomationFromUserDefault
{
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * teacherid=[userDefaults objectForKey:@"teacherid"];
    NSNumber * teacheridNumber=[NSNumber numberWithInt:teacherid.intValue];
    NSData * teacherIconData=[userDefaults objectForKey:@"teacherIconImage"];
    
    self.name=[userDefaults objectForKey:@"name"];
    NSLog(@"self.name=%@",self.name);
    self.brithday=[userDefaults objectForKey:[self getKey:@"birthday" andTeacherid:teacheridNumber]];
    NSLog(@"self.birthday=%@",self.brithday);
    self.gender=[userDefaults objectForKey:@"gender"];
    self.identifier=[userDefaults objectForKey:[self getKey:@"identifier" andTeacherid:teacheridNumber]];
    self.qqNumber=[userDefaults objectForKey:@"qqNumber"];
    self.telephoneNumber=[userDefaults objectForKey:@"telephone"];
    self.degree=[userDefaults objectForKey:[self getKey:@"degree" andTeacherid:teacheridNumber]];
    self.timeperiod=[userDefaults objectForKey:[self getKey:@"timeperiod" andTeacherid:teacheridNumber]];
    self.objectInfo=[userDefaults objectForKey:[self getKey:@"objectInfo" andTeacherid:teacheridNumber]];
    self.subjectInfo=[userDefaults objectForKey:[self getKey:@"subjectInfo" andTeacherid:teacheridNumber]];
    self.image=[UIImage imageWithData:teacherIconData];
    NSLog(@"self.image=%@",self.image);
    [self.tableView reloadData];
    
}
-(NSString *)getKey:(NSString *)para1 andTeacherid:(NSNumber*)para2
{
    return [NSString stringWithFormat:@"%@%@",para1,para2];
}
-(void)viewDidAppear:(BOOL)animated
{
    //[self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(3, 8, 80, 30)];
    [self.leftBarButton setTitle:@"< 设置" forState:UIControlStateNormal];
    [self.leftBarButton.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:18]];
    [self.leftBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.leftBarButton setBackgroundColor:kGreenForTabbaritem];
    [self.leftBarButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    CALayer * leftBarButtonLayer =  [self.leftBarButton layer];
    [leftBarButtonLayer setMasksToBounds:YES];
    [leftBarButtonLayer setCornerRadius:5.0];
    [leftBarButtonLayer setBorderWidth:0.5];
    [leftBarButtonLayer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.navigationController.navigationBar addSubview:self.leftBarButton];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if(screenWidth==320&&screenHeight==480)
    {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 5, 100, 30)];
    }
    else if(screenWidth==320&&screenHeight==568)
    {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 5, 100, 30)];
    }
    else if(screenWidth==375&&screenHeight==667)
    {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(145, 5, 100, 30)];
    }
    else
    {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 5, 100, 30)];
    }
    [self.titleLabel setText:@"个人信息"];
    [self.titleLabel setTextColor:kGreenForTabbaritem];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:22]];
    [self.navigationController.navigationBar addSubview:self.titleLabel];
    if([self.type isEqualToString:@"1"])
    {
        [self.tableView reloadData];
    }
    else
    {
    [self fetchInfomationFromUserDefault];
    }
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.leftBarButton removeFromSuperview];
    [self.titleLabel removeFromSuperview];
}
-(void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableView DataSouce Method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 12;
    }
    else
    {
        return 0;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * Identifier=@"Identifier";
    EHETchSettingDetailCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(!cell)
    {
        cell=[[EHETchSettingDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    NSInteger row = [indexPath row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if(row==0)
    {
        cell.nameLabel.alpha=0.0f;
        cell.settingLabel.text=@"";
        cell.contentLabel.text=@"";
        cell.settingImageView.alpha=1.0f;
        cell.iconLabel.text=@"头像";
        cell.imageIcon.image=self.image;
        cell.imageIcon.layer.cornerRadius=26.0f;
        cell.imageIcon.clipsToBounds=YES;
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    if(row==1)
    {
        cell.settingLabel.text=@"姓名";
        cell.iconLabel.text=@"";
        cell.imageIcon.image=nil;
        cell.contentLabel.text=self.name;
    }
    if(row==2)
    {
        cell.settingLabel.text=@"电话号码:";
        cell.iconLabel.text=@"";
        cell.contentLabel.text=self.telephoneNumber;
    }
    if(row==3)
    {
        cell.settingLabel.text=@"性别:";
        cell.iconLabel.text=@"";
        cell.contentLabel.text=self.gender;
        cell.contentLabel.tag=1;
    }
    if(row==4)
    {
        cell.settingLabel.text=@"地址:";
        cell.iconLabel.text=@"";
        cell.contentLabel.text=@"北京石景山";
    }
    if(row==5)
    {
        cell.settingLabel.text=@"日期:";
        cell.iconLabel.text=@"";
        cell.contentLabel.text=self.brithday;
    }
    if(row==6)
    {
        cell.settingLabel.text=@"身份证号：";
        cell.iconLabel.text=@"";
        cell.contentLabel.text=self.identifier;
    }
    if(row==7)
    {
       cell.settingLabel.text=@"QQ号：";
        cell.iconLabel.text=@"";
        cell.contentLabel.text=self.qqNumber;
    }
    
    if(row==8)
    {
        cell.settingLabel.text=@"学位：";
        cell.iconLabel.text=@"";
        cell.contentLabel.text=self.degree;
    }
    if(row==9)
    {
        cell.settingLabel.text=@"教龄：";
        cell.iconLabel.text=@"";
        cell.imageIcon.image=nil;
        cell.contentLabel.text=self.timeperiod;
    }
    
    if(row==10)
    {
         cell.settingLabel.text=@"教授对象：";
        cell.iconLabel.text=@"";
        cell.imageIcon.image=nil;
        cell.contentLabel.text=self.objectInfo;
    }
    if(row==11)
    {
      cell.settingLabel.text=@"教学科目：";
        cell.iconLabel.text=@"";
        cell.imageIcon.image=nil;
        cell.contentLabel.text=self.subjectInfo;
    }
    cell.settingLabel.font=[UIFont fontWithName:kYueYuanFont size:16.0f];
    cell.iconLabel.font=[UIFont fontWithName:kYueYuanFont size:16.0f];
    cell.contentLabel.font=[UIFont fontWithName:kYueYuanFont size:14.0f];
    return cell;
}
#pragma mark - TableView Delegate Method
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section]==0)
    {
        if([indexPath row]==0)
        {
            return 70.0f;
        }
    }
    return 44.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.settingDetail=[[EHETchSettingDetailViewController alloc]initWithNibName:nil bundle:nil];
    NSInteger row=[indexPath row];
    if(row==0)
    {

        self.settingDetail.image=self.image;
    }
    else if(row==1)
    {
        self.settingDetail.name=self.name;
    }
    else if(row==2)
    {
        self.settingDetail.telephoneNumber=@"18500813409";
        
    }
    else if(row==3)
    {
    }
    else if(row==4)
    {
        return;
    }
    else if(row==5)
    {
        self.settingDetail.birthDate=@"2000-01-01";
    }
    else if(row==6)
    {
        self.settingDetail.identifier=self.identifier;
    }
    else if(row==7)
    {
        self.settingDetail.qqNumber=self.qqNumber;
    }
    else if(row==8)
    {
        self.settingDetail.degree=self.degree;
    }
    else if(row==9)
    {
        self.settingDetail.timeperiod=self.timeperiod;
    }
    
    else if(row==10)
    {
        self.settingDetail.objectInfo=self.objectInfo;
    }
    
    self.settingDetail.type=[NSString stringWithFormat:@"%d",[indexPath row]];
    UITextField * textField=(UITextField *)[self.tableView viewWithTag:1];
    if([textField.text isEqualToString:@"男"])
    {
        self.settingDetail.currentIndexPath=0;
    }
    else if([textField.text isEqualToString:@"女"])
    {
        self.settingDetail.currentIndexPath=1;
    }
    self.settingDetail.personView=self;
    [self.navigationController pushViewController:self.settingDetail animated:YES];
}
@end
