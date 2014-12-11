//
//  EHETchCommunicationManager.m
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/1/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//
#import "Defines.h"
#import "EHETchCommunicationManager.h"
#import "AFHTTPRequestOperation.h"
@implementation EHETchCommunicationManager

+ (EHETchCommunicationManager *) getInstance
{
    static EHETchCommunicationManager *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
        {
            sharedSingleton = [[EHETchCommunicationManager alloc] init];
        }
        
        return sharedSingleton;
    }
}

-(BOOL)registerWithName:(NSString *)name andPassword:(NSString *)password {
    
    NSString * postData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"password\":\"%@\"}",name,password];
    
    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLRegister];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
    
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if(responseData != nil && error == nil){
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        
        if([dict[@"code"] intValue] == 0 && dict[@"code"] != nil){
            
            NSLog(@"成功注册教师信息");
            return YES;

        }else{
            
            NSLog(@"注册教师信息失败");
            NSLog(@"%@",dict[@"message"]);
            return NO;
        }
    } else {
        return NO;
    }
    
}

-(BOOL)loginWithName:(NSString *)name andPassword:(NSString *) password {
    
    NSString * postData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"password\":\"%@\"}",name,password];
    
    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLLogin];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
    
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if(responseData != nil && error == nil){
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        
        if([dict[@"code"] intValue] == 0 && dict[@"code"] != nil){
            
            NSLog(@"登录成功");
            NSLog(@"%@", dict[@"teacherinfo"]);
            NSString * teacherid=[[dict objectForKey:@"teacherinfo"] objectForKey:@"teacherid"];
            NSString * teacherName=[[dict objectForKey:@"teacherinfo"] objectForKey:@"name"];
            NSString * gender=[[dict objectForKey:@"teacherinfo"] objectForKey:@"gender"];
            NSString * qqNumber=[[dict objectForKey:@"teacherinfo"] objectForKey:@"qq"];
            NSString * sinaweibo=[[dict objectForKey:@"teacherinfo"] objectForKey:@"sinaweibo"];
            NSString * telephone=[[dict objectForKey:@"teacherinfo"] objectForKey:@"telephone"];
            
            NSString * teacherIcon=[[dict objectForKey:@"teacherinfo"] objectForKey:@"teachericon"];
            NSLog(@"teacherIcon=%@",teacherIcon);
            NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
            [userDefaults setObject:teacherid forKey:@"teacherid"];
            NSLog(@"teacherName=%@",teacherName);
            [userDefaults setObject:teacherName forKey:@"name"];
            [userDefaults setObject:gender forKey:@"gender"];
            [userDefaults setObject:teacherIcon forKey:@"teacherIcon"];
            [userDefaults setObject:qqNumber forKey:@"qqNumber"];
            [userDefaults setObject:sinaweibo forKey:@"sinaWeibo"];
            [userDefaults setObject:telephone forKey:@"telephone"];
            [userDefaults synchronize];
            return YES;
            
        }else{
            
            NSLog(@"登录失败，用户名或密码有误");
            NSLog(@"%@",dict[@"message"]);
            return NO;
        }
    } else {
        return NO;
    }
    
}

-(BOOL)completeProfileWithInfodict:(NSDictionary *)dict {
    NSString * postData = [NSString stringWithFormat:@"{\"teacherid\":%@,\"name\":\"%@\",\"birthday\":\"%@\",\"gender\":\"%@\",\"identity\":\"%@\",\"qq\":\"%@\",\"sinaweibo\":\"%@\",\"telephone\":\"%@\",\"degree\":\"%@\",\"timeperiod\":\"%@\",\"objectinfo\":\"%@\",\"subjectinfo\":\"%@\",\"memo\":\"%@\",\"majoraddress\":\"%@\",\"latitude\":%@,\"longitude\":%@}",dict[@"teacherid"],dict[@"name"],dict[@"birthday"],dict[@"gender"],dict[@"identity"],dict[@"qq"],dict[@"sinaweibo"],dict[@"telephone"],dict[@"degree"],dict[@"timeperiod"],dict[@"objectinfo"],dict[@"subjectinfo"],dict[@"memo"],dict[@"majoraddress"],dict[@"latitude"],dict[@"longitude"]];
    
    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLAddOtherInfos];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
    
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if(responseData != nil && error == nil){
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        
        if([dict[@"code"] intValue] == 0 && dict[@"code"] != nil){
            
            NSLog(@"成功补充教师信息");
            return YES;
            
        }else{
            
            NSLog(@"补充教师信息失败");
            NSLog(@"%@",dict[@"message"]);
            return NO;
        }
    } else {
        return NO;
    }
}

-(BOOL)loadOrdersWithTeacherId:(int)teacherId andOrderStatus:(int)status {
    
    NSString * postData = [NSString stringWithFormat:@"{\"teacherid\":%d,\"orderstatus\":%d,\"page\":1,\"count\":20}",teacherId,status];
    
    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLFindOrderList];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
    
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if(error != nil ) {
        NSLog(@"error = %@", error);
    }
    
    NSMutableString *string = [[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"response string =  %@", string);
    
    if(responseData != nil && error == nil){
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        
        if([dict[@"code"] intValue] == 0 && dict[@"code"] != nil){
            
            NSLog(@"成功获取订单列表");
            NSArray *orderList = dict[@"ordersinfo"];
            if (orderList.count > 0) {
                [[EHETchCoreDataManager getInstance] removeAllOrdersFromCoreData];
                for (NSDictionary *dictOrder in orderList) {
                    NSLog(@"订单id为 ＝＝ %d",[dictOrder[@"orderid"] intValue]);
                    [[EHETchCommunicationManager getInstance] loadOrderDetailWithOrderId:[dictOrder[@"orderid"] intValue]];
                }
                
            }
            return YES;
            
        }else{
            
            NSLog(@"获取订单信息失败");
            NSLog(@"%@",dict[@"message"]);
            return NO;
        }
    } else {
        NSLog(@"获取订单信息失败");
        return NO;
    }
    
}

-(BOOL)loadOrderDetailWithOrderId:(int)orderId {
    NSString * postData = [NSString stringWithFormat:@"{\"orderid\":\"%d\"}",orderId];
    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLFindOrderDetail];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if(responseData != nil && error == nil){
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
        NSDictionary *dictOrderInfo = dict[@"orderinfo"];
        if([dict[@"code"] intValue] == 0){
            NSLog(@"-----------------获取订单详情成功----------------");
            NSLog(@"%@",dictOrderInfo);
            [[EHETchCoreDataManager getInstance] removeOrderWithOrderId:[[dictOrderInfo objectForKey:@"orderid"] intValue]];
            return [[EHETchCoreDataManager getInstance] saveOrders:dictOrderInfo];

            }else{
            NSLog(@"%@",dict[@"message"]);
                return  NO;
            }
    }else {
        return NO;
    }
}

-(BOOL)confirmOrderWithOrderId:(int)orderId {
    
    NSString * postData = [NSString stringWithFormat:@"{\"orderid\":%d,\"orderstatus\":1,\"apptype\":2}",orderId];
    
    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLConfirmOrder];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
    
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if(responseData != nil && error == nil){
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        
        if([dict[@"code"] intValue] == 0 && dict[@"code"] != nil){
            
            NSLog(@"确认了订单信息 订单状态改为");
            NSLog(@"%@",dict[@"orderstatus"]);
            return YES;
            
        }else{
            
            NSLog(@"订单没能确认，请稍候再试");
            NSLog(@"%@",dict[@"message"]);
            return NO;
        }
    } else {
        return NO;
    }
    
}

-(BOOL)cancelOrderWithOrderId:(int)orderId withReason:(NSString *)reason {
    NSString * postData = [NSString stringWithFormat:@"{\"orderid\":%d,\"orderstatus\":2,\"memo\":\"%@\",\"apptype\":2}",orderId,reason];
    
    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLCancelOrder];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
    
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if(responseData != nil && error == nil){
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        
        if([dict[@"code"] intValue] == 0 && dict[@"code"] != nil){
            
            NSLog(@"成功取消订单号为%d 订单状态改为",orderId);
            NSLog(@"%@",dict[@"orderstatus"]);
            NSLog(@"%@",dict[@"message"]);
            return YES;
            
        }else{
            
            NSLog(@"订单没能取消，请稍候再试");
            NSLog(@"%@",dict[@"message"]);
            return NO;
        }
    } else {
        return NO;
    }
}

-(BOOL)completeOrderWithOrderId:(int)orderId {
    NSString * postData = [NSString stringWithFormat:@"{\"orderid\":%d,\"orderstatus\":5}",orderId];
    
    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLCompleteOrder];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
    
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if(responseData != nil && error == nil){
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        
        if([dict[@"code"] intValue] == 0 && dict[@"code"] != nil){
            
            NSLog(@"订单已经完成 订单状态改为");
            NSLog(@"%@",dict[@"orderstatus"]);
            return YES;
            
        }else{
            
            NSLog(@"订单尚未完成，请重新再试");
            NSLog(@"%@",dict[@"message"]);
            return NO;
        }
    } else {
        return NO;
    }
}

-(BOOL)commentCustomerWithCustomerId:(int)customerId andTeacherId:(int)teacherId andRand:(int) rank andComment:(NSString *) comment{
    
    NSString * postData = [NSString stringWithFormat:@"{\"teacherid\":%d,\"customerid\":%d,\"rank\":%d,\"commenttype\":0,\"content\":\"%@\"}",teacherId,customerId,rank,comment];
    
    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLCommentCustomer];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
    
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if(responseData != nil && error == nil){
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        
        if([dict[@"code"] intValue] == 0 && dict[@"code"] != nil){
            
            NSLog(@"评价成功");
            return YES;
            
        }else{
            
            NSLog(@"评价失败");
            NSLog(@"%@",dict[@"message"]);
            return NO;
        }
    } else {
        return NO;
    }
    
}

-(BOOL)loadCommentsWithCustomerId:(int)customerId {
    NSString * postData = [NSString stringWithFormat:@"{\"customerid\":%d,\"commenttype\":0,\"page\":1,\"count\":20}",customerId];
    
    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLFindCustomerComments];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
    
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if(responseData != nil && error == nil){
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        
        if([dict[@"code"] intValue] == 0 && dict[@"code"] != nil){
            
            NSLog(@"成功获取评价，评价详情如下");
            NSLog(@"%@",[[dict[@"comments"] objectAtIndex:0] objectForKey:@"content"]);
            return YES;
            
        }else{
            
            NSLog(@"获取用户评价失败");
            NSLog(@"%@",dict[@"message"]);
            return NO;
        }
    } else {
        return NO;
    }
}

-(BOOL)loadCustomerDetailWithCustomerI:(int)customerId {
    NSString * postData = [NSString stringWithFormat:@"{\"customerid\":\"%d\"}",customerId];
    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLFindCustomerDetail];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSMutableString * string = [[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
    
    if(responseData != nil && error == nil){
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"dict ------ %@",dict);
        NSDictionary *dictCustomerInfo = dict[@"customerinfo"];
        if([dict[@"code"] intValue] == 0 && dict != nil){
            NSLog(@"-----------------获取用户详情成功----------------");
            NSLog(@"%@",dictCustomerInfo);
            return [[EHETchCoreDataManager getInstance] saveCustomerInfos:dictCustomerInfo];
            
        }else{
            NSLog(@"%@",dict[@"message"]);
            return  NO;
        }
    }else {
        return NO;
    }
}

-(void)loadCustomerIconForCustomer:(EHECustomer *)customer completionBlock:(void (^)(NSString *))completionBlock {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://218.249.130.194:8080/ehomeedu%@",customer.usericon]];
    
    if (url == nil)
    {
        NSLog(@"图片URL 为空");
        return;
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
             NSLog(@"发送请求发生错误 %@",error);
         }
         else
         {
             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
             if (httpResponse.statusCode == 200)
             {
                 UIImage *image = [[UIImage alloc] initWithData:data];
                 NSData * image_data = UIImagePNGRepresentation(image);
                 
                 // save image to cache directory
                 [[NSUserDefaults standardUserDefaults] setObject:image_data forKey:[NSString stringWithFormat:@"image_for_customer_%@",customer.customerid]];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 completionBlock(kConnectionSuccess);
             }
             else
             {
                 NSLog(@"Communication status code not 200 --> %ld", (long)httpResponse.statusCode);
                 completionBlock(kConnectionFailure);
             }
         }
     }];
}

-(void) loadTeacherIconForTeacher:(NSString *) teacherIcon completionBlock:(void(^)(NSString*))completionBlock
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://218.249.130.194:8080/ehomeedu%@",teacherIcon]];
    
    if (url == nil)
    {
        NSLog(@"图片URL 为空");
        return;
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
             NSLog(@"发送请求发生错误 %@",error);
         }
         else
         {
             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
             if (httpResponse.statusCode == 200)
             {
                 UIImage *image = [[UIImage alloc] initWithData:data];
                 NSData * image_data = UIImagePNGRepresentation(image);
                 NSLog(@"image=%@",image);
                 // save image to cache directory
                 [[NSUserDefaults standardUserDefaults] setObject:image_data forKey:@"teacherIconImage"];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 completionBlock(kConnectionSuccess);
             }
             else
             {
                 NSLog(@"Communication status code not 200 --> %ld", (long)httpResponse.statusCode);
                 completionBlock(kConnectionFailure);
             }
         }
     }];
}
-(BOOL)uploadTeacherIconWithTeacherid:(NSString *)teacherid andImage:(UIImage*) myImage
{
    __block BOOL check;
    NSString * path = @"http://218.249.130.194:8080/ehomeedu/api/teacher/teachericonupload.action";
    AFHTTPRequestSerializer * serializer = [[AFHTTPRequestSerializer alloc]init];

    NSMutableURLRequest * request = [serializer multipartFormRequestWithMethod:@"POST" URLString:path parameters:@{@"teacherid":teacherid} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(myImage, 0.3) name:@"teachericon" fileName:@"png-0001.jpg" mimeType:@"image/jpeg"];
        
    } error:nil];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //上传成功，
        NSLog(@"success;%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
        check=YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //上传失败，
        NSLog(@"error:%@",error);
        check=NO;
    }];
    NSLog(@"hahhaah-----------------");
    [operation start];//开始上传
    return check;
}
-(BOOL)removeOrderFromServerWithOrderId:(int)orderId
{
    BOOL check;
    NSString * postData = [NSString stringWithFormat:@"{\"orderid\":\"%d\"}",orderId];
    
    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLDeleteOrder];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSLog(@"responseData=%@",responseData);
    NSMutableString * stringData=[[NSMutableString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"ResponseString=%@",stringData);
    if(responseData != nil && error == nil){
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"获取到的dict=%@",dict);
        if([dict[@"code"] intValue] == 0){
            NSLog(@"订单删除成功");
            check=YES;
        }else{
            NSLog(@"订单删除失败");
            check=NO;
            NSLog(@"%@",dict[@"message"]);
        }
    }
    return check;
}
//-(void)loadDataWithTeacherID:(int) teacherId {
//    
//    NSString * postData = [NSString stringWithFormat:@"{\"teacherid\":\"%d\"}",teacherId];
//    
//    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLFindTeacherDetail];
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
//    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
//    
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSError *error = nil;
//    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
//    
//    if(responseData != nil && error == nil){
//        
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
//        NSDictionary *dictTeacherInfo = dict[@"teacherinfo"];
//        
//        if([dict[@"code"] intValue] == 0){
//            NSLog(@"获取教师具体信息成功");
//            [[EHECoreDataManager getInstance] updateDetailInfos:dictTeacherInfo withTeacherId:teacherId];
//        }else{
//            NSLog(@"%@",dict[@"message"]);
//        }
//    }
//    
//}
//
//-(void)loadOrderInfosWithCustomerID:(int)customerID andOrderStatus:(int)status {
//    
//    /*  status含义：
//     -1: 所有状态订单
//     0：客户发出订单
//     1：教师确认订单
//     2：教师拒绝订单
//     3：客户取消订单
//     4：客户确认完成
//     5：教师确认完成
//     6：双方确认完成
//     */
//    
//    NSString * postData = [NSString stringWithFormat:@"{\"customerid\":\"%d\",\"orderstatus\":\"%d\",\"page\":\"1\",\"count\":\"10\"}",customerID,status];
//    
//    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLFindOrderList];
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
//    
//    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSError *error = nil;
//    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
//    
//    if(responseData != nil && error == nil){
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
//        NSArray *arrayOrders = dict[@"ordersinfo"];
//        if([dict[@"code"] intValue] == 0){
//            NSLog(@"获取订单信息成功");
//            NSLog(@"orderinfo=%@",arrayOrders);
//            [[EHECoreDataManager getInstance] saveOrderInfos:arrayOrders];
//        }else{
//            NSLog(@"%@",dict[@"message"]);
//        }
//    }
//}
//
//-(void)loadOrderDetailWithOrderID:(int)orderID {
//    
//    NSString * postData = [NSString stringWithFormat:@"{\"orderid\":\"%d\"}",orderID];
//    
//    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLFindOrderDetail];
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
//    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
//    
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSError *error = nil;
//    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
//    
//    if(responseData != nil && error == nil){
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
//        NSDictionary *dictOrderInfo = dict[@"orderinfo"];
//        if([dict[@"code"] intValue] == 0){
//            NSLog(@"-----------------获取订单详情成功----------------");
//            [[EHECoreDataManager getInstance] upDateOrderDetail:dictOrderInfo withOrderId:orderID];
//        }else{
//            NSLog(@"%@",dict[@"message"]);
//        }
//    }
//}
//
//
//
//-(void)sendOrder:(NSDictionary *)dictOrder {
//    
//    NSLog(@"以下是发送的订单详情 %@",dictOrder);
//    NSString * postData = [NSString stringWithFormat:@"{\"customerid\":%@,\"latitude\":39.000000,\"longitude\":116.998877,\"serviceaddress\":\"%@\",\"teacherid\":%@,\"orderdate\":\"%@\",\"timeperiod\":\"%@\",\"objectinfo\":\"%@\",\"subjectinfo\":\"%@\",\"memo\":\"%@\",\"orderstatus\":%@,\"apptype\":%d}",[dictOrder objectForKey:@"customerid"],[dictOrder objectForKey:@"serviceaddress"],[dictOrder objectForKey:@"teacherid"],[dictOrder objectForKey:@"orderdate"],[dictOrder objectForKey:@"timeperiod"],[dictOrder objectForKey:@"objectinfo"],[dictOrder objectForKey:@"subjectinfo"],[dictOrder objectForKey:@"memo"], [dictOrder objectForKey:@"orderstatus"],3];
//    
//    NSLog(@"postData=%@",postData);
//    
//    
//    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLReserveTeacher];
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
//    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSError *error = nil;
//    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
//    if(responseData != nil && error == nil){
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
//        if([dict[@"code"] intValue] == 0){
//            NSLog(@"发送订单成功");
//        }else{
//            NSLog(@"%@",dict[@"message"]);
//        }
//    }
//}
//-(void)sendOtherInfo:(NSDictionary *)dictOtherInfo {
//    
//    NSString * postData = [NSString stringWithFormat:@"{\"customerid\":\"%@\",\"name\":\"%@\",\"gender\":\"%@\",\"telephone\":\"%@\",\"latitude\":\"%@\",\"longitude\":\"%@\",\"majoraddress\":\"%@\",\"memo\":\"%@\"}",[dictOtherInfo objectForKey:@"customerid"],[dictOtherInfo objectForKey:@"name"],[dictOtherInfo objectForKey:@"gender"],[dictOtherInfo objectForKey:@"telephone"],[dictOtherInfo objectForKey:@"latitude"],[dictOtherInfo objectForKey:@"longitude"],[dictOtherInfo objectForKey:@"majoraddress"],[dictOtherInfo objectForKey:@"memo"]];
//    
//    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLUserOtherInfo];
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
//    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSError *error = nil;
//    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
//    if(responseData != nil && error == nil){
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
//        if([dict[@"code"] intValue] == 0){
//            NSLog(@"dict=%@",dict);
//            NSLog(@"发送补充个人信息成功");
//            //[[EHECoreDataManager getInstance] savePersonalData:dictOtherInfo];
//        }else{
//            NSLog(@"%@",dict[@"message"]);
//        }
//    }
//}
//
//-(void)cancelOrderWithOrderId:(int)orderId withReason:(NSString *)memo {
//    NSString * postData = [NSString stringWithFormat:@"{\"orderid\":\"%d\",\"orderstatus\":\"3\",\"memo\":\"%@\",\"apptype\":3}",orderId,memo];
//    NSLog(@"postData:%@",postData);
//    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLCancelOrder];
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
//    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSError *error = nil;
//    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
//    NSMutableString * stringResponse=[[NSMutableString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
//    NSLog(@"responseData=%@",stringResponse);
//    if(responseData != nil && error == nil){
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
//        NSLog(@"返回的dict:%@",dict);
//        if([dict[@"code"] intValue] == 0){
//            NSLog(@"订单状态改为%@",dict[@"orderstatus"]);
//            NSLog(@"orderstatus:如果返回3，证明取消成功，如果返回的是4，5，6则表明订单处于不可取消状态，-1为重复取消订单，不允许取消已经取消的订单");
//        }else{
//            NSLog(@"%@",dict[@"message"]);
//        }
//    }
//}
//
//-(void)confirmOrderWithOrderId:(int)orderId {
//    NSString * postData = [NSString stringWithFormat:@"{\"orderid\":\"%d\",\"orderstatus\":\"4\"}",orderId];
//    
//    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLCompleteOrder];
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
//    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSError *error = nil;
//    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
//    if(responseData != nil && error == nil){
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
//        if([dict[@"code"] intValue] == 0){
//            NSLog(@"订单状态改为%@",dict[@"orderstatus"]);
//            NSLog(@"orderstatus:证明确认成功，可能返回的是4，6中的一个。-1是失败，具体原因看提示信息");
//        }else{
//            NSLog(@"%@",dict[@"message"]);
//        }
//    }
//}
//
//-(void)uploadUserIconWithCustomerId:(int)customerId andImage:(NSData *)myImage {
//    
//    
//    NSString * path = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLUploadIcon];
//    AFHTTPRequestSerializer * serializer = [[AFHTTPRequestSerializer alloc]init];
//    
//    
//    NSMutableURLRequest * request = [serializer multipartFormRequestWithMethod:@"POST" URLString:path parameters:@{@"customerid":@(customerId)} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        //UIImage * image = [UIImage imageNamed:@"female_tablecell.png"];//这里可以使用照相机照一张，或者从图片库中选一张。具体代码自己参考之前讲的内容。
//        
//        //第一个参数：将要上传的图片变为NSData
//        //第二个参数：name必须为@"usericond",
//        //第三个参数fileName：@"任意的名字，例如下面的例子"。
//        //第四个参数：mimeType：如果是png:@"image/png",如果是jpg：@"image/jpeg".服务器接收好像两种png和jpg格式的图片
//        UIImage * image=[UIImage imageWithData:myImage];
//        NSLog(@"要传送的image=%@",image);
//        [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"usericon" fileName:[NSString stringWithFormat:@"image_customerid_%d",customerId] mimeType:@"image/png"];
//        
//    } error:nil];
//    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //上传成功
//        NSLog(@"头像上传成功！");
//        NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"头像上传失败");
//    }];
//    [operation start];//开始上传
//    
//}
//
//-(void)commentTeacherWithTeacherId:(int)teacherId fromCustomerWithCustomerId:(int) customerId withRank:(int)rank andContent:(NSString *)content {
//    NSString * postData = [NSString stringWithFormat:@"{\"teacherid\":\"%d\",\"customerid\":\"%d\",\"rank\":\"%d\",\"commenttype\":\"1\",\"content\":\"%@\"}",teacherId,customerId,rank,content];
//    
//    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLCommentTeacher];
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
//    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSError *error = nil;
//    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
//    if(responseData != nil && error == nil){
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
//        if([dict[@"code"] intValue] == 0){
//            NSLog(@"评价成功");
//        }else{
//            NSLog(@"评价失败");
//            NSLog(@"%@",dict[@"message"]);
//        }
//    }
//}
//
//-(void)loadRankWithTeacherId:(int)teacherId {
//    
//    NSString * postData = [NSString stringWithFormat:@"{\"teacherid\":\"%d\",\"commenttype\":\"1\",\"page\":\"1\",\"count\":\"10\"}",teacherId];
//    
//    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLFindTeacherComments];
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
//    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSError *error = nil;
//    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
//    if(responseData != nil && error == nil){
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
//        if([dict[@"code"] intValue] == 0){
//            NSLog(@"得到的评价是%@",dict[@"comments"]);
//        }else{
//            NSLog(@"获取评价失败");
//            NSLog(@"%@",dict[@"message"]);
//        }
//    }
//    
//}
//
//-(void)removeOrderFromServerWithOrderId:(int)orderId {
//    NSString * postData = [NSString stringWithFormat:@"{\"orderid\":\"%d\"}",orderId];
//    
//    NSString *stringForURL = [NSString stringWithFormat:@"%@",kURLDeleteOrder];
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
//    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSError *error = nil;
//    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
//    
//    NSMutableString * stringData=[[NSMutableString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
//    NSLog(@"ResponseString=%@",stringData);
//    if(responseData != nil && error == nil){
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
//        NSLog(@"获取到的dict=%@",dict);
//        if([dict[@"code"] intValue] == 0){
//            NSLog(@"订单删除成功");
//        }else{
//            NSLog(@"订单删除失败");
//            NSLog(@"%@",dict[@"message"]);
//        }
//    }
//    
//}

@end
