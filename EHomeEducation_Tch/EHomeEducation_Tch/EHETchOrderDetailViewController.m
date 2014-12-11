//
//  EHETchOrderDetailViewController.m
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/2/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "Defines.h"
#import "EHETchOrderDetailViewController.h"
#import "EHECustomerImageCell.h"
#import "EHETchOrderHeaderCell.h"
#import "EHETchOrderRegularCell.h"
#import "EHETchCommunicationManager.h"

@interface EHETchOrderDetailViewController ()

@property (strong, nonatomic) UIButton *cancel_btn;
@property (strong, nonatomic) UIButton *confirm_btn;
@property(strong,nonatomic)UIButton * leftBarButton;
@property(strong,nonatomic)UILabel * titleLabel;

@end

@implementation EHETchOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect bounds = self.view.bounds;
    
    self.tableView.backgroundView = nil;
    self.tableView.frame = bounds;
    [self.tabBarController.tabBar setHidden:YES];
    
    [self configureTabbar];
    
    NSLog(@"customer %@",self.customer);
    
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.leftBarButtonItem=nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.titleLabel removeFromSuperview];
    [self.leftBarButton removeFromSuperview];
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(3, 8, 80, 30)];
    [self.leftBarButton setTitle:@"< 首页" forState:UIControlStateNormal];
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

        return  cell;
    }
    
    if (indexPath.row == 1) {
        EHETchOrderHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerCell];
        if (cell == nil) {
            cell = (EHETchOrderHeaderCell *) [[NSBundle mainBundle] loadNibNamed:@"EHETchOrderHeaderCell" owner:self options:nil][0];
        }
        cell.orderDetailViewController = self;
        [cell setContent:self.order];
        return cell;
    }
    
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5) {
    
        EHETchOrderRegularCell *cell = [tableView dequeueReusableCellWithIdentifier:regularCell];
        if (cell == nil) {
            cell = (EHETchOrderRegularCell *) [[NSBundle mainBundle ] loadNibNamed:@"EHETchOrderRegularCell" owner:self options:nil][0];
         }
        
        [cell setContent:self.order withRowIndex:indexPath.row];
        
        return cell;
    }

    

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = @" ";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) configureTabbar {
    UIImageView *imgView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"lightgreen.png"]];
    
    imgView.frame = CGRectMake(0, 425, imgView.image.size.width, 60);
    
    imgView.userInteractionEnabled = YES;
    
    [self.view addSubview:imgView];
    
    
    //创建按钮
        
    UIButton *btn_Confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Confirm.frame = CGRectMake(185,10, 105 , 30);
    [btn_Confirm setBackgroundColor:kLightGreenForMainColor];
    [btn_Confirm setTitle:@"愉快接受" forState:UIControlStateNormal];
    [btn_Confirm.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:20]];
    [btn_Confirm addTarget:self action:@selector(confirmOrder) forControlEvents:UIControlEventTouchUpInside];
    CALayer * layer_confirmBtn =  [btn_Confirm layer];
    [layer_confirmBtn setMasksToBounds:YES];
    [layer_confirmBtn setCornerRadius:10.0];
    [layer_confirmBtn setBorderWidth:2.0];
    [layer_confirmBtn setBorderColor:[[UIColor whiteColor] CGColor]];
    self.confirm_btn = btn_Confirm;
    [imgView addSubview:self.confirm_btn];
    


    
    UIButton *btn_Cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Cancel.frame = CGRectMake(30,10, 105 , 30);
    [btn_Cancel setBackgroundColor:[UIColor redColor]];
    [btn_Cancel setTitle:@"残忍拒绝" forState:UIControlStateNormal];
    [btn_Cancel.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:20]];
    [btn_Cancel addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];
    btn_Cancel.tag = 0;
    CALayer * layer_cancelBtn =  [btn_Cancel layer];
    [layer_cancelBtn setMasksToBounds:YES];
    [layer_cancelBtn setCornerRadius:10.0];
    [layer_cancelBtn setBorderWidth:2.0];
    [layer_cancelBtn setBorderColor:[[UIColor whiteColor] CGColor]];
    self.cancel_btn = btn_Cancel;
    [imgView addSubview:self.cancel_btn];
    
    [self.view addSubview:imgView];
}

-(void) cancelOrder {
    if ([[EHETchCommunicationManager getInstance] cancelOrderWithOrderId:[self.order.orderid intValue] withReason:@"您太远了"]) {
        NSLog(@"取消成功");
        
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
        label1.text=@"取消成功";
        label1.font=[UIFont fontWithName:kFangZhengKaTongFont size:15.0f];
        [blackView addSubview:label1];
        
        [UIView animateWithDuration:1.0 animations:^{
            blackView.alpha=0.8f;
        }];
        [UIView animateWithDuration:2.5 animations:^{
            blackView.alpha=0.0f;
        }];
        
        [self.cancel_btn setBackgroundColor:[UIColor lightGrayColor]];
    } else {
        NSLog(@"取消失败");
    }
}

-(void) confirmOrder {
    if ([[EHETchCommunicationManager getInstance] confirmOrderWithOrderId:[self.order.orderid intValue]]) {
        NSLog(@"确认成功");
        
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
        
        [self.confirm_btn setBackgroundColor:[UIColor lightGrayColor]];
    } else {
        NSLog(@"确认失败");
    }
}




@end
