//
//  EHETchSettingViewController.m
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/2/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHETchSettingViewController.h"
#import "EHETchSettingCell.h"
#import "EHETchPersonalViewController.h"
@interface EHETchSettingViewController ()

@end

@implementation EHETchSettingViewController

- (void)viewDidLoad {
    self.title=@"设置";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.settingTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-120) style:UITableViewStyleGrouped];
    self.settingTableView.dataSource=self;
    self.settingTableView.delegate=self;
    self.settingTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.settingTableView];
    
    self.personalInfomationArray=[NSArray arrayWithObjects:@"头像",@"评论",nil];
    
    self.systemSettingArray=[NSArray arrayWithObjects:@"系统设置",@"退出登录",nil];
    self.connectAndShareArray=[NSArray arrayWithObjects:@"分享",@"联系我们", nil];
    
    self.check=NO;
    self.testArray=[[NSArray alloc]initWithObjects:@"",@"",@"男",@"18500813409",@"1989-11-24", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -TableView DataSource Method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return [self.personalInfomationArray count];
    }
    else if(section==1)
    {
        return [self.systemSettingArray count];
    }
    else
    {
        return [self.connectAndShareArray count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * Identifier=@"Identifier";
    EHETchSettingCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(!cell)
    {
        cell=[[EHETchSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    //第一个分组
    if(section==0)
    {
        if(row==0)//第一分组 第一行
        {
            //cell.settingLabel.text=[self.personalInfomationArray objectAtIndex:0];
            if(self.check==NO)//更改姓名 字段的高度，只改一次
            {
                CGRect frames=cell.settingLabel.frame;
                frames.size.height+=26;
                cell.settingLabel.frame=frames;
                self.check=YES;
                cell.contentLabel.alpha=0.0f;
            }
            cell.nameLabel.text=@"易中天";
            
            cell.settingImageView.image=[UIImage imageNamed:@"male_tablecell"];
            
            cell.settingImageView.layer.cornerRadius = 26;
            cell.settingImageView.layer.masksToBounds = YES;
            [cell.settingImageView.layer setBorderWidth:5];
            [cell.settingImageView.layer setBorderColor:[UIColor colorWithRed:192.0 / 256.0 green:233 / 256.0 blue:189 / 256.0 alpha:0.8].CGColor];
        }
        else
        {
            cell.settingLabel.text=[self.personalInfomationArray objectAtIndex:row];
            cell.nameLabel.alpha=0.0f;
        }
        cell.contentLabel.text=[self.testArray objectAtIndex:row];
    }
    else if(section==1)//第二个分组
    {
        cell.settingLabel.text=[self.systemSettingArray objectAtIndex:row];
        cell.nameLabel.alpha=0.0f;
        if([indexPath row]==1)
        {
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
    }
    else//第三个分组
    {
        cell.settingLabel.text=[self.connectAndShareArray objectAtIndex:row];
        cell.nameLabel.alpha=0.0f;
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark- TableView Delegate Method
//对每个分组的说明和描述
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return @"个人资料";
    }
    else  if(section==1)
    {
        return @"系统设置";
    }
    else
    {
        return @"联系我们";
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 10)];
    headerView.backgroundColor=[UIColor clearColor];
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(20, 3, 100, 20)];
    CGRect labelFrame=label.frame;
    if(section==0)
    {
        label.text=@"个人资料";
        labelFrame.origin.y+=20;
        label.frame=labelFrame;
    }
    else  if(section==1)
    {
        label.text= @"系统设置";
    }
    else
    {
        label.text= @"联系我们";
    }
    label.textColor=[UIColor blackColor];
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:14.0f];
    [headerView addSubview:label];
    return headerView;
}
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
    if([indexPath section]==0)
    {
        if([indexPath row]==0)
        {
            EHETchPersonalViewController * personal=[[EHETchPersonalViewController alloc]initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:personal animated:YES];
        }
    }
}
@end
