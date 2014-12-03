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
@interface EHETchPersonalViewController ()

@end

@implementation EHETchPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320,self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem * sendButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(sendInfomation)];
    self.navigationItem.rightBarButtonItem=sendButtonItem;
    
    self.image=[UIImage imageNamed:@"male_tablecell"];
    self.gender=@"男";
}
-(void)sendInfomation
{
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
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
        return 6;
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
    if(row==0)
    {
        cell.nameLabel.alpha=0.0f;
        cell.settingImageView.alpha=1.0f;
        cell.iconLabel.text=@"头像";
        cell.imageIcon.image=self.image;
        cell.imageIcon.layer.cornerRadius=26.0f;
        cell.imageIcon.clipsToBounds=YES;
    }
    else if(row==1)
    {
        cell.settingLabel.text=@"姓名";
        cell.contentLabel.text=self.name;
    }
    else if(row==2)
    {
        cell.settingLabel.text=@"电话号码:";
        cell.contentLabel.text=self.telephoneNumber;
    }
    else if(row==3)
    {
        cell.settingLabel.text=@"性别:";
        cell.contentLabel.text=self.gender;
        cell.contentLabel.tag=1;
    }
    else if(row==4)
    {
        cell.settingLabel.text=@"地址:";
        cell.contentLabel.text=@"北京石景山";
    }
    else
    {
        cell.settingLabel.text=@"日期:";
        cell.contentLabel.text=self.brithday;
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
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
        self.settingDetail.type=@"0";
        self.settingDetail.image=self.image;
    }
    else if(row==1)
    {
        self.settingDetail.type=@"1";
        self.settingDetail.name=self.name;
    }
    else if(row==2)
    {
        self.settingDetail.type=@"3";
        self.settingDetail.telephoneNumber=@"18500813409";
        
    }
    else if(row==3)
    {
        self.settingDetail.type=@"2";
    }
    else if(row==4)
    {
        return;
    }
    else
    {
        self.settingDetail.type=@"4";
        self.settingDetail.birthDate=@"2000-01-01";
    }
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
