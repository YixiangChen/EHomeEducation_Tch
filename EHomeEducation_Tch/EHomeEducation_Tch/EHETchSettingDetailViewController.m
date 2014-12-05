//
//  EHETchSettingDetailViewController.m
//  EHomeEducation_Tch
//
//  Created by MacBook Pro on 14-12-3.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHETchSettingDetailViewController.h"
#import "EHETchSettingDetailCell2.h"
#import "EHETchPersonalViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface EHETchSettingDetailViewController ()

@end

@implementation EHETchSettingDetailViewController

- (void)viewDidLoad {
    self.title=@"详细设置";
    [super viewDidLoad];
    //对type的值进行判断，来显示设置类型
    //type=0:选择头像;type=1:选择姓名;type=2:选择性别;type=3:选择联系电话;type=4:选择出生日期
    if([self.type isEqualToString:@"1"]||[self.type isEqualToString:@"3"]||[self.type isEqualToString:@"4"])
    {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(-15, 0, self.view.frame.size.width+15, 150) style:UITableViewStylePlain];
    }
    else if([self.type isEqualToString:@"2"])
    {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(-15, 0, self.view.frame.size.width+15, 188) style:UITableViewStylePlain];
        self.sexArray=[[NSArray alloc]initWithObjects:@"男",@"女", nil];
        self.navigationItem.hidesBackButton =YES;
    }
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.bounces=NO;
    self.tableView.scrollEnabled=NO;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    if([self.type isEqualToString:@"0"])
    {
        self.view.backgroundColor=[UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1.0f];
        self.studentImageView=[[UIImageView alloc]initWithFrame:CGRectMake(85,90, 150, 150)];
        self.studentImageView.image=self.image;
        
        [self.studentImageView.layer setBorderColor: [[UIColor grayColor] CGColor]];//边框灰色
        [self.studentImageView.layer setBorderWidth: 1.0];//宽度为1
        [self.studentImageView.layer setCornerRadius:8.0f];//圆角
        [self.studentImageView.layer setMasksToBounds:YES];
        
        [self.view addSubview:self.studentImageView];
        
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,300, self.view.frame.size.width, 88)];
        self.tableView.dataSource=self;
        self.tableView.delegate=self;
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        self.tableView.bounces=NO;
        [self.view addSubview:self.tableView];
    }
    
    NSLog(@"studentName=%@",self.name);
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    UITextField * nameText=(UITextField *)[self.tableView viewWithTag:1];
    NSLog(@"personInfo=%@",self.personView);
    if([self.type isEqualToString:@"1"])
    {
        self.personView.name=nameText.text;
    }
    else if([self.type isEqualToString:@"3"])
    {
        self.personView.telephoneNumber=nameText.text;
    }
    else if([self.type isEqualToString:@"2"])
    {
        self.personView.gender=[self.sexArray objectAtIndex:self.currentIndexPath];
    }
    else if([self.type isEqualToString:@"4"])
    {
        self.personView.brithday=nameText.text;
    }
    else if([self.type isEqualToString:@"0"])
    {
        self.personView.image=self.image;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)saveButtonItemClicked:(id)sender
{
    if([self.type isEqualToString:@"2"])
    {
        NSLog(@"%@",[self.sexArray objectAtIndex:self.currentIndexPath]);
    }
}
#pragma mark- TableView DataSource Method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.type isEqualToString:@"1"]||[self.type isEqualToString:@"3"]||[self.type isEqualToString:@"4"])
    {
        return 1;
    }
    else if([self.type isEqualToString:@"0"])
    {
        return 2;
    }
    else
    {
        return 2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * Identifier=@"Identifier";
    EHETchSettingDetailCell2 * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(!cell)
    {
        cell=[[EHETchSettingDetailCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.detailTextField.tag=1;
    if([self.type isEqualToString:@"1"])
    {
        cell.detailTextsLabel.text=@"姓名";
        cell.detailTextField.text=self.name;
        [cell.detailTextField becomeFirstResponder];
        cell.userInteractionEnabled=NO;
    }
    else if([self.type isEqualToString:@"2"])
    {
        cell.detailTextsLabel.text=[self.sexArray objectAtIndex:[indexPath row]];
        cell.detailTextField.hidden=YES;
        if([indexPath row]==self.currentIndexPath)
        {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
        //cell.userInteractionEnabled=NO;
    }
    else if([self.type isEqualToString:@"3"])
    {
        cell.detailTextsLabel.text=@"电话";
        cell.detailTextField.keyboardType=UIKeyboardTypeNumberPad;
        cell.detailTextField.text=self.telephoneNumber;
        [cell.detailTextField becomeFirstResponder];
        cell.userInteractionEnabled=NO;
    }
    else if([self.type isEqualToString:@"4"])
    {
        cell.detailTextsLabel.text=@"日期";
        cell.detailTextField.inputView=self.datePicker;
        //cell.detailTextField.tag=1;
        cell.detailTextField.text=self.birthDate;
        [cell.detailTextField becomeFirstResponder];
        cell.userInteractionEnabled=NO;
    }
    else if([self.type isEqualToString:@"0"])
    {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextField.hidden=YES;
        cell.detailTextsLabel.hidden=YES;
        if([indexPath row]==0)
        {
            cell.textLabel.text=@"从相册选一张";
        }
        else
        {
            cell.textLabel.text=@"拍一张照片";
        }
    }
    
    return cell;
}
#pragma mark - DatePickerView ValueChanged Method
-(IBAction)dataPickerValueChanged:(id)sender
{
    UIDatePicker * datePicker=(UIDatePicker *)sender;
    UITextField * textField=(UITextField *)[self.tableView viewWithTag:1];
    NSString * brithDate=[NSString stringWithFormat:@"%@",[datePicker date]];
    NSString * realBirthDate=[brithDate substringWithRange:NSMakeRange(0, 10)];
    textField.text=realBirthDate;
}
#pragma mark -TableView Delegate Method
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if([self.type isEqualToString:@"2"])
    {
        self.currentIndexPath=[indexPath row];
        [self.navigationController popViewControllerAnimated:YES];
    }
    if([self.type isEqualToString:@"0"])
    {
        if([indexPath row]==0)
        {
            if(self.imagePickerController == nil){
                self.imagePickerController = [[UIImagePickerController alloc]init];
                self.imagePickerController.delegate = self;
            }
            //设定资源的来源类型
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //设定选择后是否能够进行编辑
            self.imagePickerController.allowsEditing = YES;
            //打开这个controller
            [self presentViewController:self.imagePickerController animated:YES completion:nil];
        }
        else if([indexPath row]==1)
        {
            if(self.imagePickerController == nil){
                //
                self.imagePickerController = [[UIImagePickerController alloc]init];
                //设定委托对象
                self.imagePickerController.delegate = self;
            }
            //设定参数
            //设定来源为照相机
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            //允许编辑
            //self.imagePickerController.allowsEditing = YES;
            //打开前置摄像头,默认是后置摄像头
            //    self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            //打开闪光灯设置,为开模式
            //self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
            //设定捕获模式，是视频还是图片。但是必须先指定又这种媒体类型，mediaTypes的属性需要设置
            self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
            self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            [self presentViewController:self.imagePickerController animated:YES completion:nil];
        }
    }
}
#pragma mark -ImagePickerView Delegate Method
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"finish selected");
    //如果是来源为照片库
    if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        //做将选择的图片显示到imageView组件上。
        _image = nil;
        if(picker.allowsEditing != YES){
            //选取原始图片
            _image = info[UIImagePickerControllerOriginalImage];
        }else{
            //选取编辑后的图片
            _image = info[UIImagePickerControllerEditedImage];
        }
        //可以根据实际图片大小来调整imageView组件的高宽比。
        self.studentImageView.image = _image;
        [self.studentImageView.layer setCornerRadius:50];
    }else if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        if(picker.cameraCaptureMode == UIImagePickerControllerCameraCaptureModePhoto){
            //做将选择的图片显示到imageView组件上。
            _image = nil;
            if(picker.allowsEditing != YES){
                //选取原始图片
                _image = info[UIImagePickerControllerOriginalImage];
            }else{
                //选取编辑后的图片
                _image = info[UIImagePickerControllerEditedImage];
            }
            //可以根据实际图片大小来调整imageView组件的高宽比。
            //来源为照相机，将原始的照片存入照片库
            //建立相册
            UIImageWriteToSavedPhotosAlbum(info[UIImagePickerControllerOriginalImage], nil, nil,NULL);
            self.studentImageView.image = _image;
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel");
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end