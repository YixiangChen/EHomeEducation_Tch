//
//  EHETchSearchingViewController.m
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/2/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//
#import "Defines.h"
#import "EHETchSearchingViewController.h"
#import "EHETchOrderDetailViewController.h"
#import "EHETchCommunicationManager.h"
#import "EHETchBookingManagerViewController.h"

#import "FPPopoverView.h"
#import "FPPopoverController.h"
#import "FPTouchView.h"
#import "EHETchLoginViewController.h"
#import "MJRefresh.h"

@interface EHETchSearchingViewController ()
@property(strong,nonatomic)UILabel * titleLabel;
@end

@implementation EHETchSearchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.coreDataManager = [EHETchCoreDataManager getInstance];
    self.allOrders = [[NSMutableArray alloc] initWithArray:[self.coreDataManager fetchOrdersWithStatus:0]];
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    [self setExtraCellLineHidden:self.tableView];
    [self setupFilterView];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self.tableView headerBeginRefreshing];
}
-(void) headerRefreshing {
    bool refreshSuccess;
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * teacherid=[userDefaults objectForKey:@"teacherid"];
    NSLog(@"teacherid=%@",teacherid);
    refreshSuccess = [[EHETchCommunicationManager getInstance] loadOrdersWithTeacherId:teacherid.intValue andOrderStatus:-1];
    [self.allOrders removeAllObjects];
    self.allOrders = [[NSMutableArray alloc] initWithArray:[self.coreDataManager fetchOrdersWithStatus:0]];
    for (EHEOrder *order in self.allOrders) {
        NSLog(@"orderid= %@, orderstatus = %@",order.orderid, order.orderstatus);
    }
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
    if (refreshSuccess) {
        NSLog(@"更新成功");
    }else {
        NSLog(@"更新失败");
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * userName=[userDefaults objectForKey:@"userName"];
    NSString * password=[userDefaults objectForKey:@"passWord"];
    if(userName==nil||password==nil)
    {
        EHETchLoginViewController * loginViewController=[[EHETchLoginViewController alloc]initWithNibName:nil bundle:nil];
        [self presentViewController:loginViewController animated:NO completion:nil];
    }
    else
    {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(138, 5, 100, 30)];
        [self.titleLabel setText:@"首页"];
        [self.titleLabel setTextColor:kGreenForTabbaritem];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:22]];
        [self.navigationController.navigationBar addSubview:self.titleLabel];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.titleLabel removeFromSuperview];
}
-(void) setupFilterView {
    UIButton *filterDistanceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 79, 20)];
    [filterDistanceBtn setTitle:@"距离" forState:UIControlStateNormal];
    [filterDistanceBtn.titleLabel setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:15.0]];
    [filterDistanceBtn setBackgroundColor:kLightGreenForMainColor];
    [filterDistanceBtn addTarget:self action:@selector(popFilterView:) forControlEvents:UIControlEventTouchUpInside];
    [filterDistanceBtn setTag:0];
    
    UIButton *filterSubjectBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 0, 79, 20)];
    [filterSubjectBtn setTitle:@"科目" forState:UIControlStateNormal];
    [filterSubjectBtn.titleLabel setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:15.0]];
    [filterSubjectBtn setBackgroundColor:kLightGreenForMainColor];
    [filterSubjectBtn addTarget:self action:@selector(popFilterView:) forControlEvents:UIControlEventTouchUpInside];
    [filterSubjectBtn setTag:1];
    
    UIButton *filterGradeBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, 0, 79, 20)];
    [filterGradeBtn setTitle:@"年级" forState:UIControlStateNormal];
    [filterGradeBtn.titleLabel setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:15.0]];
    [filterGradeBtn setBackgroundColor:kLightGreenForMainColor];
    [filterGradeBtn addTarget:self action:@selector(popFilterView:) forControlEvents:UIControlEventTouchUpInside];
    [filterGradeBtn setTag:2];
    
    
    UIButton *filterRankBtn = [[UIButton alloc] initWithFrame:CGRectMake(240, 0, 79, 20)];
    [filterRankBtn setTitle:@"评价" forState:UIControlStateNormal];
    [filterRankBtn.titleLabel setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:15.0]];
    [filterRankBtn setBackgroundColor:kLightGreenForMainColor];
    [filterRankBtn addTarget:self action:@selector(popFilterView:) forControlEvents:UIControlEventTouchUpInside];
    [filterRankBtn setTag:3];
    
    [self.filterView addSubview:filterDistanceBtn];
    [self.filterView addSubview:filterSubjectBtn];
    [self.filterView addSubview:filterGradeBtn];
    [self.filterView addSubview:filterRankBtn]; 
}

- (void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    [tableView setTableHeaderView:view];
    
}

-(void) popFilterView:(id) sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == 0) {
        if (self.filterByDistanceController == nil) {
            self.filterByDistanceController= [[EHETchFilterByDistanceViewController alloc] initWithNibName:nil bundle:nil];
        }
        FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:self.filterByDistanceController];
        popover.contentSize = CGSizeMake(220, 95);
        self.filterByDistanceController.popController = popover;
        [popover presentPopoverFromView:btn];
        
    }
    
    if (btn.tag == 1) {
        if (self.filterBySubjectsController == nil) {
            self.filterBySubjectsController= [[EHETchFilterBySubjectViewController alloc] initWithNibName:nil bundle:nil];
        }
        FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:self.filterBySubjectsController];
        popover.contentSize = CGSizeMake(230, 230);
        self.filterBySubjectsController.popController = popover;
        [popover presentPopoverFromView:btn];
        
    }
    
    if (btn.tag == 2) {
        if (self.filterByGradeController == nil) {
            self.filterByGradeController= [[EHETchFilterByGradeViewController alloc] initWithNibName:nil bundle:nil];
        }
        FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:self.filterByGradeController];
        popover.contentSize = CGSizeMake(140, 200);
        self.filterByGradeController.popController = popover;
        [popover presentPopoverFromView:btn];
        
    }
    
    if (btn.tag == 3) {
        if (self.filterByEvaluationController == nil) {
            self.filterByEvaluationController= [[EHETchFilterByEvaluationViewController alloc] initWithNibName:nil bundle:nil];
        }
        FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:self.filterByEvaluationController];
        popover.contentSize = CGSizeMake(150, 300);
        self.filterByEvaluationController.popController = popover;
        [popover presentPopoverFromView:btn];
        
    }
    

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//-(void) selectedSegmentChanged:(UISegmentedControl *) seg {
//    if(seg.selectedSegmentIndex==0)
//    {
//        self.mapSearching.mapView=nil;//在父视图中删除地图的时候，要给百度地图赋值为nil以免内存泄露
//        [self.mapSearching.view removeFromSuperview];
//        self.tableView.scrollEnabled=YES;
//    }
//    else
//    {
//        NSLog(@"这是地图");
//        self.tableView.scrollEnabled=NO;
//        [self.view addSubview: self.mapSearching.view];
//    }
//    
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return [self.allOrders count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"Cell";
    EHETchOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = (EHETchOrderTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"EHETchOrderTableViewCell" owner:self options:nil][0];

    }
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    EHEOrder * order = [self.allOrders objectAtIndex:indexPath.row];
    [cell setContent:order];
    return cell;
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    EHETchOrderDetailViewController *detailViewController = [[EHETchOrderDetailViewController alloc] initWithNibName:nil bundle:nil];
    EHEOrder * order = [self.allOrders objectAtIndex:indexPath.row];
    
    detailViewController.order = order;
    
    [[EHETchCommunicationManager getInstance] loadCustomerDetailWithCustomerI:[order.customerid intValue]];
    detailViewController.customer = [[EHETchCoreDataManager getInstance] fetchCustomerWithCustomerId:[order.customerid intValue]];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] init];
    [leftBarButtonItem setTitle:@"返回列表"];
    [leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
    [leftBarButtonItem setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor greenColor]}  forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem = leftBarButtonItem;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)updateOrderStatusForOrder:(EHEOrder *)order {

    NSArray *tempArray = [[NSArray alloc] initWithArray:self.allOrders];
    for (EHEOrder * oldOrder in tempArray) {
        if (oldOrder.orderid.intValue ==  order.orderid.intValue) {
            [self.allOrders removeObject:oldOrder];
        }
    }
    
    [self.tableView reloadData];
}


@end
