//
//  EHETchCommunicationManager.h
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/1/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHETchCoreDataManager.h"
#import "EHEOrder.h"
#import <UIKit/UIKit.h>


@interface EHETchCommunicationManager : NSObject

+ (EHETchCommunicationManager *) getInstance;

//教师注册
-(BOOL) registerWithName:(NSString *) name andPassword:(NSString *) password;

//教师登录
-(BOOL) loginWithName:(NSString *) name andPassword:(NSString *) password;

//补充教师个人信息
-(BOOL) completeProfileWithInfodict:(NSDictionary *) dict;

//取得教师订单
-(BOOL) loadOrdersWithTeacherId:(int) teacherId andOrderStatus:(int) status;

//取得订单详情
-(BOOL) loadOrderDetailWithOrderId:(int) orderId;

//教师确认订单
-(BOOL) confirmOrderWithOrderId:(int) orderId;

//教师取消订单
-(BOOL) cancelOrderWithOrderId:(int) orderId withReason:(NSString *) reason;

//教师完成订单
-(BOOL) completeOrderWithOrderId:(int) orderId;

//教师评价用户
-(BOOL)commentCustomerWithCustomerId:(int)customerId andTeacherId:(int)teacherId andRand:(int) rank andComment:(NSString *) comment;

//查看用户评价
-(BOOL) loadCommentsWithCustomerId:(int) customerId;

//获取用户资料
-(BOOL) loadCustomerDetailWithCustomerI:(int) customerId;

//获取用户头像
-(void) loadCustomerIconForCustomer:(EHECustomer *) customer completionBlock:(void(^)(NSString*))completionBlock;

//获取教师头像
-(void) loadTeacherIconForTeacher:(NSString *) teacherIcon completionBlock:(void(^)(NSString*))completionBlock;
//上传教师头像
-(BOOL)uploadTeacherIconWithTeacherid:(NSString *)teacherid andImage:(UIImage *) myImage;
//从服务器删除订单
-(BOOL) removeOrderFromServerWithOrderId:(int) orderId;
@end
