//
//  EHETchBookingManagerViewController.m
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/2/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//
#import "Defines.h"
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
    
    self.ordersDictionary=[[NSMutableDictionary alloc]initWithCapacity:4];
    [self fetchOrders];
    self.orderTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-120) style:UITableViewStyleGrouped];
    self.orderTableView.dataSource=self;
    self.orderTableView.delegate=self;
    self.orderTableView.separatorStyle= UITableViewCellSeparatorStyleSingleLine;
    self.orderTableView.backgroundColor = [UIColor clearColor];
    self.orderTableView.sectionFooterHeight = 0.0;
    [self.view addSubview:self.orderTableView];
    [self.orderTableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.orderTableView headerBeginRefreshing];
}
-(void)fetchOrders
{
    EHETchCoreDataManager * coreData=[EHETchCoreDataManager getInstance];

    self.confirmedOrders = [[NSMutableArray alloc] initWithArray:[coreData fetchOrdersWithStatus:1]];
    self.canceledOrders = [[NSMutableArray alloc] init];
    [self.canceledOrders addObjectsFromArray:[coreData fetchOrdersWithStatus:2]];
    [self.canceledOrders addObjectsFromArray:[coreData fetchOrdersWithStatus:3]];
    self.unfinsihedOrders = [[NSMutableArray alloc] init];
    [self.unfinsihedOrders addObjectsFromArray:[coreData fetchOrdersWithStatus:4]];
    [self.unfinsihedOrders addObjectsFromArray:[coreData fetchOrdersWithStatus:5]];
    self.finishedOrders = [[NSMutableArray alloc] initWithArray:[coreData fetchOrdersWithStatus:6]];
    [self.ordersDictionary removeAllObjects];
    [self.ordersDictionary setObject:self.confirmedOrders forKey:@"已确定的订单"];
    [self.ordersDictionary setObject:self.canceledOrders forKey:@"已取消的订单"];
    [self.ordersDictionary setObject:self.unfinsihedOrders forKey:@"未完成的订单"];
    [self.ordersDictionary setObject:self.finishedOrders forKey:@"已完成的订单"];
}

-(void) headerRefreshing {
    bool refreshSuccess;
    refreshSuccess = [[EHETchCommunicationManager getInstance] loadOrdersWithTeacherId:135 andOrderStatus:-1];
    [self fetchOrders];
    [self.orderTableView reloadData];
    [self.orderTableView headerEndRefreshing];
    if (refreshSuccess) {
        NSLog(@"更新成功");
    }else {
        NSLog(@"更新失败");
    }
    
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 25.0)];
    customView.backgroundColor = kLightGreenForMainColor;
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont fontWithName:kFangZhengKaTongFont size:17];
    headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 20.0);
    
    NSArray * allKeys=[self.ordersDictionary allKeys];
    NSArray * orders=[self.ordersDictionary objectForKey:[allKeys objectAtIndex:section]];
    NSString * groupHeaderString=[NSString stringWithFormat:@"%@",[allKeys objectAtIndex:section]];
    if([orders count]==0)
    {
        headerLabel.text = [NSString stringWithFormat:@"%@(数量为空)",groupHeaderString];
    }
    else
    {
        headerLabel.text = groupHeaderString;
        
    }

    [customView addSubview:headerLabel];
    return customView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}


@end
