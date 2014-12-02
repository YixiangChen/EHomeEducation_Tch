//
//  EHETchCoreDataManager.h
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/1/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHEOrder.h"

@interface EHETchCoreDataManager : NSObject
@property(strong, nonatomic) NSManagedObjectContext *context;

//获取单例
+ (EHETchCoreDataManager *) getInstance;

//获取订单列表
- (BOOL) saveOrders:(NSDictionary *) dictOrder;

//获取所有订单列表
-(NSArray *) fetchAllOrders;

//获取订单详细信息
- (EHEOrder *) fetchOrderWithOrderId:(int)orderId;

//删除所有订单信息
- (BOOL) removeAllOrdersFromCoreData;

@end
