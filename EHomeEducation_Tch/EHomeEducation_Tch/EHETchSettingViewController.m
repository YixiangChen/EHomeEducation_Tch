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
#import <ShareSDK/ShareSDK.h>
#import "EHETchLoginViewController.h"
#import "Defines.h"
#import "EHETchCommunicationManager.h"
@interface EHETchSettingViewController ()
@property(strong,nonatomic)UILabel * titleLabel;
@end

@implementation EHETchSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if(screenWidth==320&&screenHeight==480)
    {
    self.settingTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-120) style:UITableViewStyleGrouped];
    }
    else if(screenWidth==320&&screenHeight==568)
    {
       self.settingTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStyleGrouped];
    }
    else if(screenWidth==375&&screenHeight==667)
    {
        self.settingTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 667) style:UITableViewStyleGrouped];
    }
    else if(screenWidth==414&&screenHeight==736)
    {
        self.settingTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 414, 697) style:UITableViewStyleGrouped];
    }
    
    
    self.settingTableView.dataSource=self;
    self.settingTableView.delegate=self;
    self.settingTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.settingTableView];
    
    self.personalInfomationArray=[NSArray arrayWithObjects:@"头像",@"评论",nil];
    
    self.systemSettingArray=[NSArray arrayWithObjects:@"系统设置",@"退出登录",nil];
    self.connectAndShareArray=[NSArray arrayWithObjects:@"分享",@"联系我们", nil];
    
    self.check=NO;
    self.testArray=[[NSArray alloc]initWithObjects:@"",@"",@"男",@"18500813409",@"1989-11-24", nil];
    
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.leftBarButtonItem=nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * teacherid=[userDefaults objectForKey:@"teacherid"];
    NSNumber * teacheridNumber=[[NSNumber alloc]initWithInt:teacherid.intValue];
    NSLog(@"teacherNumber=%@",teacheridNumber);
    self.teacherName=[userDefaults objectForKey:@"name"];
    NSData * teacherImageData=[userDefaults objectForKey:@"teacherIconImage"];
    self.teacherImage=[UIImage imageWithData:teacherImageData];
    [self.settingTableView reloadData];

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
       self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 5, 100, 30)];
    }
    else if(screenWidth==414&&screenHeight==736)
    {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(185, 5, 100, 30)];
    }
    [self.titleLabel setText:@"设置"];
    [self.titleLabel setTextColor:kGreenForTabbaritem];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:22]];
    [self.navigationController.navigationBar addSubview:self.titleLabel];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.titleLabel removeFromSuperview];
}
-(NSString *)getKey:(NSString *)para1 andTeacherid:(NSNumber*)para2
{
    return [NSString stringWithFormat:@"%@%@",para1,para2];
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
#pragma mark- LXActionSheet Delegate Method

- (void)didClickOnButtonIndex:(NSInteger *)buttonIndex
{
    if((int)buttonIndex==0)
    {
        NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:@"userName"];
        [userDefaults removeObjectForKey:@"passWord"];
        [userDefaults removeObjectForKey:@"name"];
        [userDefaults removeObjectForKey:@"teacherIconImage"];
        [userDefaults removeObjectForKey:@"teacherid"];
        [userDefaults removeObjectForKey:@"address"];
        [userDefaults synchronize];
        
        EHETchCoreDataManager * coreData=[EHETchCoreDataManager getInstance];
        [coreData removeAllOrdersFromCoreData];
        
        EHETchLoginViewController * loginViewController=[[EHETchLoginViewController alloc]initWithNibName:nil bundle:nil];
        [self presentViewController:loginViewController animated:NO completion:nil];
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
            cell.nameLabel.text=self.teacherName;
            
            cell.settingImageView.image=nil;
            NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
            NSData * teacherImageData=[userDefaults objectForKey:@"teacherIconImage"];
            UIImage * teacherImage=[UIImage imageWithData:teacherImageData];
            NSString * teacherIcon=[userDefaults objectForKey:@"teacherIcon"];
            if(teacherImage==nil)
            {
                cell.settingImageView.image=[UIImage imageNamed:@"male_tablecell"];
                EHETchCommunicationManager * communicationManager= [EHETchCommunicationManager getInstance];
                [communicationManager loadTeacherIconForTeacher:teacherIcon completionBlock:^(NSString * status) {
                    if ([status isEqualToString:kConnectionSuccess])
                    {
                        NSData * teacherImageData=[userDefaults objectForKey:@"teacherIconImage"];
                        cell.settingImageView.image=[UIImage imageWithData:teacherImageData];
                    }
                }];
            }
            else
            {
                cell.settingImageView.image=self.teacherImage;
            }
            
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
    if([indexPath section]==1)
    {
      if([indexPath row]==1)
      {
          LXActionSheet * actionSheet = [[LXActionSheet alloc]initWithTitle:@"确定要退出E家教吗" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles:nil];
          [actionSheet showInView:self.view];
      }
    }
    if([indexPath section]==2)
    {
      if([indexPath row]==0)
      {
          NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
          
          //构造分享内容
          id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                             defaultContent:@"默认分享内容，没内容时显示"
                                                      image:[ShareSDK imageWithPath:imagePath]
                                                      title:@"ShareSDK"
                                                        url:@"http://www.sharesdk.cn"
                                                description:@"这是一条测试信息"
                                                  mediaType:SSPublishContentMediaTypeNews];
          //创建分享信息后，分享成功与否的返回
          [ShareSDK showShareActionSheet:nil
                               shareList:nil
                                 content:publishContent
                           statusBarTips:YES
                             authOptions:nil
                            shareOptions: nil
                                  result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                      if (state == SSResponseStateSuccess)
                                      {
                                          NSLog(@"分享成功");
                                      }
                                      else if (state == SSResponseStateFail)
                                      {
                                          NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                                      }
                                  }];
      }
    }
}
@end
