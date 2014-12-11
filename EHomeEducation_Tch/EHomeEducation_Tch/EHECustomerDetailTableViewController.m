//
//  EHECustomerDetailTableViewController.m
//  EHomeEduTeacher
//
//  Created by Yixiang Chen on 12/5/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//
#import "Defines.h"
#import "EHECustomerDetailTableViewController.h"

@interface EHECustomerDetailTableViewController ()
@property(strong,nonatomic)UIButton * leftBarButton;
@property(strong,nonatomic)UILabel * titleLabel;
@end

@implementation EHECustomerDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setExtraCellLineHidden:self.tableView];
    [self.tableView setBackgroundColor:[UIColor lightGrayColor] ];
    
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.leftBarButtonItem=nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(3, 8, 80, 30)];
    [self.leftBarButton setTitle:@"<订单详情" forState:UIControlStateNormal];
    [self.leftBarButton.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:15]];
    [self.leftBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.leftBarButton setBackgroundColor:kGreenForTabbaritem];
    [self.leftBarButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    CALayer * leftBarButtonLayer =  [self.leftBarButton layer];
    [leftBarButtonLayer setMasksToBounds:YES];
    [leftBarButtonLayer setCornerRadius:5.0];
    [leftBarButtonLayer setBorderWidth:0.5];
    [leftBarButtonLayer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.navigationController.navigationBar addSubview:self.leftBarButton];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 100, 30)];
    [self.titleLabel setText:@"学生信息"];
    [self.titleLabel setTextColor:kGreenForTabbaritem];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:22]];
    [self.navigationController.navigationBar addSubview:self.titleLabel];
}
-(void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.leftBarButton removeFromSuperview];
    [self.titleLabel removeFromSuperview];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    [tableView setTableHeaderView:view];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 3;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    [cell.textLabel setFont:[UIFont fontWithName:kYueYuanFont size:18]];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"电话";
        cell.detailTextLabel.text = self.customer.telephone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.textLabel.text = @"微博";
        cell.detailTextLabel.text = self.customer.sinaweibo;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        cell.textLabel.text = @"QQ";
        cell.detailTextLabel.text = self.customer.qq;
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = @"个性签名";
        cell.detailTextLabel.text = self.customer.memo;
    }
    // Configure the cell...
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSLog(@"0000000");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"呼叫 %@",self.customer.telephone]
                                    
                                                            style:UIAlertActionStyleDefault
                                    
                                                          handler:^(UIAlertAction *action) {
                                                              
                                                              NSLog(@"这里加上呼叫方法");
                                                              
                                                          }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                    
                                                            style:UIAlertActionStyleCancel
                                    
                                                          handler:^(UIAlertAction *action) {
    
                                                              
                                                          }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        


    }
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
