//
//  EHETchSettingDetailViewController.h
//  EHomeEducation_Tch
//
//  Created by MacBook Pro on 14-12-3.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EHETchPersonalViewController;
@interface EHETchSettingDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(strong,nonatomic)NSString * type;
@property(strong,nonatomic)UITableView * tableView;
@property(strong,nonatomic)NSArray * sexArray;
@property(strong,nonatomic)UIImageView * studentImageView;
@property(strong,nonatomic)UIImage * image;
@property(strong,nonatomic)EHETchPersonalViewController * personView;
@property(nonatomic)NSInteger currentIndexPath;
@property(strong,nonatomic)IBOutlet UIDatePicker * datePicker;
@property(strong,nonatomic) UIImagePickerController * imagePickerController;
@property(strong,nonatomic)NSString * name;
@property(strong,nonatomic)NSString * telephoneNumber;
@property(strong,nonatomic)NSString * birthDate;
@property(strong,nonatomic)NSString * address;
-(IBAction)dataPickerValueChanged:(id)sender;

@end
