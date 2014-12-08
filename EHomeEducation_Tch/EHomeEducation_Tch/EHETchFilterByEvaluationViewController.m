//
//  EHETchFilterByEvaluationViewController.m
//  EHomeEduTeacher
//
//  Created by Yixiang Chen on 12/6/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//
#import "Defines.h"
#import "EHETchFilterByEvaluationViewController.h"

@interface EHETchFilterByEvaluationViewController ()

@end

@implementation EHETchFilterByEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if (indexPath.row == 5) {
        UIButton *btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(50, 12, 30, 20)];
        [btnSearch addTarget:self action:@selector(applyFilter) forControlEvents:UIControlEventTouchUpInside];
        [btnSearch setTitle:@"查找" forState:UIControlStateNormal];
        [btnSearch setTitleColor:kLightGreenForMainColor forState:UIControlStateNormal];
        [btnSearch.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:14] ];
        [btnSearch.titleLabel setTextColor:kGreenForTabbaritem];
        [cell addSubview:btnSearch];
    } else {
    cell.textLabel.text = [NSString stringWithFormat:@"%d星以上",indexPath.row +1];
        [cell.textLabel setTintColor:kLightGreenForMainColor];
    [cell.textLabel setFont:[UIFont fontWithName:kYueYuanFont size:16]];
    }
    if (indexPath.row == self.selectedIndex &&indexPath.row != 5) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [cell setBackgroundColor:kLightGreenForMainColor];
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    return cell;
}

- (void) applyFilter {
    [self.popController dismissPopoverAnimated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
    UITableViewCell * selectedCell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
    [selectedCell setSelected:YES animated:YES];
    self.selectedIndex = indexPath.row;
    [self.tableView reloadData];
    
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
