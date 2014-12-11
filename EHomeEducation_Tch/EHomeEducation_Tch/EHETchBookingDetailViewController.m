//
//  EHETchBookingDetailViewController.m
//  EHomeEduTeacher
//
//  Created by MacBook Pro on 14-12-10.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHETchBookingDetailViewController.h"
#import "EHECustomerImageCell.h"
#import "EHETchBookingHeaderCell.h"
#import "EHETchOrderRegularCell.h"
#import "EHETchCommunicationManager.h"
#import "Defines.h"
#import "EHETchCoreDataManager.h"
@interface EHETchBookingDetailViewController ()
@property (strong, nonatomic) UIButton *cancel_btn;
@property (strong, nonatomic) UIButton *confirm_btn;

@property(strong,nonatomic)UIButton * leftBarButton;
@property(strong,nonatomic)UILabel * titleLabel;

@end

@implementation EHETchBookingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 440) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
    
    [self.tabBarController.tabBar setHidden:YES];
    
    [self configureTabbar];
    
    NSLog(@"self.orderID=%@",self.order.orderstatus);
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.leftBarButtonItem=nil;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(3, 8, 80, 30)];
    [self.leftBarButton setTitle:@"< 我的" forState:UIControlStateNormal];
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
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 100, 30)];
    [self.titleLabel setText:@"订单详情"];
    [self.titleLabel setTextColor:kGreenForTabbaritem];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:22]];
    [self.navigationController.navigationBar addSubview:self.titleLabel];
}
-(void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) configureTabbar {
    UIImageView *imgView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"lightgreen.png"]];
    
    imgView.frame = CGRectMake(0, 425, imgView.image.size.width, 60);
    
    imgView.userInteractionEnabled = YES;
    
    [self.view addSubview:imgView];
    
    
    //创建按钮
    NSString * orderStatue=[NSString stringWithFormat:@"%@",self.order
                            .orderstatus];
    UIButton *btn_Confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Confirm.frame = CGRectMake(110,10, 105 , 30);
    [btn_Confirm setBackgroundColor:kLightGreenForMainColor];
    //判断订单状态
    if([orderStatue isEqualToString:@"1"])
    {
        [btn_Confirm setTitle:@"授课完成" forState:UIControlStateNormal];
        [btn_Confirm addTarget:self action:@selector(finishTeaching) forControlEvents:UIControlEventTouchUpInside];
    }
    else if([orderStatue isEqualToString:@"2"]||[orderStatue isEqualToString:@"3"]||[orderStatue isEqualToString:@"6"])
    {
         [btn_Confirm setTitle:@"删除订单" forState:UIControlStateNormal];
        [btn_Confirm addTarget:self action:@selector(deleteOrder) forControlEvents:UIControlEventTouchUpInside];
    }
    else if([orderStatue isEqualToString:@"4"])
    {
        [btn_Confirm setTitle:@"请您确认" forState:UIControlStateNormal];
        [btn_Confirm setEnabled:NO];
    }
    else if([orderStatue isEqualToString:@"5"])
    {
        [btn_Confirm setTitle:@"等待确认" forState:UIControlStateNormal];
        [btn_Confirm setEnabled:NO];
    }
    [btn_Confirm.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:20]];
    CALayer * layer_confirmBtn =  [btn_Confirm layer];
    [layer_confirmBtn setMasksToBounds:YES];
    [layer_confirmBtn setCornerRadius:10.0];
    [layer_confirmBtn setBorderWidth:2.0];
    [layer_confirmBtn setBorderColor:[[UIColor whiteColor] CGColor]];
    self.confirm_btn = btn_Confirm;
    [imgView addSubview:self.confirm_btn];
    [self.view addSubview:imgView];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.titleLabel removeFromSuperview];
    [self.leftBarButton removeFromSuperview];
    [self.tabBarController.tabBar setHidden:NO];
}
-(void) finishTeaching
{
  EHETchCommunicationManager * commucationManager=[EHETchCommunicationManager getInstance];
   BOOL check= [commucationManager completeOrderWithOrderId:self.order.orderid.intValue];
    if(check)
    {
        
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
        label1.text=@"确认成功";
        label1.font=[UIFont fontWithName:kFangZhengKaTongFont size:15.0f];
        [blackView addSubview:label1];
        
        [UIView animateWithDuration:1.0 animations:^{
            blackView.alpha=0.8f;
        }];
        [UIView animateWithDuration:2.5 animations:^{
            blackView.alpha=0.0f;
        }];
    }
    else
    {
      NSLog(@"确认失败！");
    }
}
-(void)deleteOrder
{
    EHETchCommunicationManager * commucationManager=[EHETchCommunicationManager getInstance];
    NSLog(@"orderId=%@,orderStatue=%@",self.order.orderid,self.order.orderstatus);
    BOOL ifDeleteOrder= [commucationManager removeOrderFromServerWithOrderId:self.order.orderid.intValue];
    if(ifDeleteOrder)
    {
        EHETchCoreDataManager *coreManager=[EHETchCoreDataManager getInstance];
        [coreManager removeOrderWithOrderId:self.order.orderid.intValue];
        
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
        label1.text=@"删除成功";
        label1.font=[UIFont fontWithName:kFangZhengKaTongFont size:15.0f];
        [blackView addSubview:label1];
        
        [UIView animateWithDuration:1.0 animations:^{
            blackView.alpha=0.8f;
        }];
        [UIView animateWithDuration:2.5 animations:^{
            blackView.alpha=0.0f;
        }];
        
    }
    else
    {
        NSLog(@"删除失败！");
    }
}
-(void)finishOrder
{

}
#pragma mark - TableView DataSource And Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    
    static NSString *headerCell = @"header";
    static NSString *bgCell = @"bgCell";
    static NSString *regularCell = @"regular";
    
    if (indexPath.row == 0) {
        EHECustomerImageCell *cell = [tableView dequeueReusableCellWithIdentifier:bgCell];
        if (cell == nil) {
            cell = (EHECustomerImageCell *)[[NSBundle mainBundle] loadNibNamed:@"EHECustomerImageCell" owner:self options:nil][0] ;
        }
        
        cell.lblEvaluation.text = [NSString stringWithFormat:@"评价: %@",self.customer.rank];
        cell.lblName.text = self.order.customername;
        
        cell.imageViewCustomerIcon.image = nil;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *imageName = [NSString stringWithFormat:@"image_for_customer_%d",[self.customer.customerid intValue]];
        NSData *data = [defaults objectForKey:imageName];
        UIImage * imageForCustomer = [[UIImage alloc] initWithData:data];
        
        if (imageForCustomer == nil)
        {
            if ([self.customer.gender isEqualToString:@"男"]) {
                imageForCustomer = [UIImage imageNamed:@"male_tablecell"];
            }else {
                imageForCustomer = [UIImage imageNamed:@"female_tablecell"];
            }
            cell.imageViewCustomerIcon.image = imageForCustomer;
            
            [[EHETchCommunicationManager getInstance] loadCustomerIconForCustomer:self.customer completionBlock:^(NSString * status)
             {
                 if ([status isEqualToString:kConnectionSuccess])
                 {
                     NSData * image_data = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"image_for_customer_%@",self.customer.customerid]];
                     UIImage *image = [[UIImage alloc] initWithData:image_data];
                     cell.imageViewCustomerIcon.image = image;
                 }
             }];
        }
        else
        {
            cell.imageViewCustomerIcon.image = imageForCustomer;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return  cell;
    }
    
    if (indexPath.row == 1) {
        EHETchBookingHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerCell];
        if (cell == nil) {
            cell = (EHETchBookingHeaderCell *) [[NSBundle mainBundle] loadNibNamed:@"EHETchBookingHeaderCell" owner:self options:nil][0];
        }
        cell.bookingDetailViewController=self;
        [cell setContent:self.order];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5) {
        
        EHETchOrderRegularCell *cell = [tableView dequeueReusableCellWithIdentifier:regularCell];
        if (cell == nil) {
            cell = (EHETchOrderRegularCell *) [[NSBundle mainBundle ] loadNibNamed:@"EHETchOrderRegularCell" owner:self options:nil][0];
        }
        
        [cell setContent:self.order withRowIndex:indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = @" ";
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 145;
    }
    
    if(indexPath.row == 1) {
        return 30;
    }
    return 44;
}
@end
