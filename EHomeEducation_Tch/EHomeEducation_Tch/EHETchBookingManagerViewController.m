//
//  EHETchBookingManagerViewController.m
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/2/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHETchBookingManagerViewController.h"
#import "EHETchCoreDataManager.h"
#import "EHETchCommunicationManager.h"
#import "EHEOrder.h"
#import "EHETchBookingCell.h"
@interface EHETchBookingManagerViewController ()

@end

@implementation EHETchBookingManagerViewController

- (void)viewDidLoad {
    self.title=@"我的订单";
    [super viewDidLoad];
    self.certainOrders=[[NSMutableArray alloc]initWithCapacity:[self.allOrdersArray count]];
    self.cancledOrders=[[NSMutableArray alloc]initWithCapacity:[self.allOrdersArray count]];
    self.unfinsihedOrders=[[NSMutableArray alloc]initWithCapacity:[self.allOrdersArray count]];
    self.finishedOrders=[[NSMutableArray alloc]initWithCapacity:[self.allOrdersArray count]];
    self.ordersDictionary=[[NSMutableDictionary alloc]initWithCapacity:4];
    [self loadOrders];
    
    self.orderTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-120) style:UITableViewStyleGrouped];
    self.orderTableView.dataSource=self;
    self.orderTableView.delegate=self;
    self.orderTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.orderTableView];

    // Do any additional setup after loading the view from its nib.
}
-(void)loadOrders
{
    EHETchCoreDataManager * coreData=[EHETchCoreDataManager getInstance];
    self.allOrdersArray=[coreData fetchAllOrders];
    NSLog(@"%@",self.allOrdersArray);
    for(EHEOrder *orders in self.allOrdersArray)
    {
        NSLog(@"orderStatus=%d",orders.orderstatus.intValue);
    }
    for(EHEOrder * order in self.allOrdersArray)
    {
      if(order.orderstatus.intValue==1)
      {
          [self.certainOrders addObject:order];
      }
      else if(order.orderstatus.intValue==2||order.orderstatus.intValue==3)
      {
          [self.cancledOrders addObject:order];
      }
      else if(order.orderstatus.intValue==4||order.orderstatus.intValue==5)
      {
          [self.unfinsihedOrders addObject:order];
      }
      else if(order.orderstatus.intValue==6)
      {
          [self.finishedOrders addObject:order];
      }
    }
    
    [self.ordersDictionary setObject:self.certainOrders forKey:@"已确定的订单"];
    [self.ordersDictionary setObject:self.cancledOrders forKey:@"已取消的订单"];
    [self.ordersDictionary setObject:self.unfinsihedOrders forKey:@"未完成的订单"];
    [self.ordersDictionary setObject:self.finishedOrders forKey:@"已完成的订单"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-TableView DataSource Method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.ordersDictionary.allKeys count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * allKeys=[self.ordersDictionary allKeys];
    NSArray * allValues=[self.ordersDictionary objectForKey:[allKeys objectAtIndex:section]];
    if([allValues count]==0)
    {
        return 1;
    }
    else
    {
    return [allValues count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString * Identifier=@"Identifier";
    EHETchBookingCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(!cell)
    {
        cell=[[EHETchBookingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    NSArray * allKeys=[self.ordersDictionary allKeys];
    NSArray * orders=[self.ordersDictionary objectForKey:[allKeys objectAtIndex:[indexPath section]]];
    if([orders count]==0)
    {
    
    }
    else
    {
    EHEOrder * order=[orders objectAtIndex:[indexPath row]];
    cell.studentNameLabel.text=order.customername;
    cell.orderDataLabel.text=[NSString stringWithFormat:@"预约时间:  %@",order.orderdate];
    cell.subjectLabel.text=[NSString stringWithFormat:@"科目:%@",order.subjectinfo];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
#pragma mark - TableView Delegate Method
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0f;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray * allKeys=[self.ordersDictionary allKeys];
    NSArray * orders=[self.ordersDictionary objectForKey:[allKeys objectAtIndex:section]];
    NSString * groupHeaderString=[NSString stringWithFormat:@"%@",[allKeys objectAtIndex:section]];
    if([orders count]==0)
    {
        return [NSString stringWithFormat:@"%@(数量为空)",groupHeaderString];
    }
    else
    {
    return groupHeaderString;

    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];;
}

@end
