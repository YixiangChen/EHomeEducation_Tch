//
//  EHETchCoreDataManager.m
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/1/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHETchCoreDataManager.h"
#import "AppDelegate.h"

@implementation EHETchCoreDataManager

+ (EHETchCoreDataManager *) getInstance
{
    static EHETchCoreDataManager *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
        {
            sharedSingleton = [[EHETchCoreDataManager alloc] init];
        }
        
        return sharedSingleton;
    }
}

-(id)init
{
    if(self = [super init]){
        id delegate = [UIApplication sharedApplication].delegate;
        self->_context = [delegate valueForKey:@"managedObjectContext"];
    }
    return self;
}

-(BOOL)saveOrders:(NSDictionary *)dictOrder {
    
    
    EHEOrder *order = [NSEntityDescription insertNewObjectForEntityForName:@"EHEOrder" inManagedObjectContext:self.context];
    order.customername = [dictOrder objectForKey:@"customername"];
    order.finishDate = [dictOrder objectForKey:@"finishDate"];
    order.orderid = [NSNumber numberWithInt:[[dictOrder objectForKey:@"orderid"] intValue]];
    order.latitude = [NSNumber numberWithFloat:[[dictOrder objectForKey:@"latitude"] floatValue]] ;
    order.longitude = [NSNumber numberWithFloat:[[dictOrder objectForKey:@"longitude"] floatValue]];
    order.orderstatus = [dictOrder objectForKey:@"orderstatus"];
    order.serviceaddress = [dictOrder objectForKey:@"serviceaddress"];
    order.orderdate = [dictOrder objectForKey:@"orderdate"];
    order.teachername = [dictOrder objectForKey:@"teachername"];
    order.memo = [dictOrder objectForKey:@"memo"];
    order.objectinfo = [dictOrder objectForKey:@"objectinfo"];
    order.orderstatus = [NSNumber numberWithInt:[[dictOrder objectForKey:@"orderstatus"] intValue]];
    order.subjectinfo = [dictOrder objectForKey:@"subjectinfo"];
    order.teacherid = [dictOrder objectForKey:@"teacherid"];
    order.timeperiod = [dictOrder objectForKey:@"timeperiod"];
    
    NSError *error;
    [self.context save:&error];
    if (error == nil) {
        return YES;
    } else {
    return NO;
    }
}

-(NSArray *)fetchAllOrders {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"EHEOrder"];
    NSPredicate * predicate = nil;
    fetchRequest.predicate = predicate;
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"orderid" ascending:NO];
    NSArray *sorts = [[NSArray alloc] initWithObjects:sortByName, nil];
    fetchRequest.sortDescriptors = sorts;
    
    NSError *error;
    NSArray *orders = [self.context executeFetchRequest:fetchRequest error:&error];
    
    if (error)
    {
        return nil;
    }
    else if (orders.count > 0)
    {
        return orders;
    }
    return nil;
}

-(EHEOrder *)fetchOrderWithOrderId:(int)orderId {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"EHEOrder"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"orderid = %d", orderId];
    fetchRequest.predicate = predicate;
    
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"orderid" ascending:NO];
    NSArray *sorts = [[NSArray alloc] initWithObjects:sortByName, nil];
    fetchRequest.sortDescriptors = sorts;
    
    NSError *error;
    NSArray *orders = [self.context executeFetchRequest:fetchRequest error:&error];
    
    if (error)
    {
        return nil;
    }
    else if (orders.count > 0)
    {
        return orders[0];
    }
    return nil;
}

-(BOOL)removeAllOrdersFromCoreData {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EHEOrder" inManagedObjectContext:self.context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:entity];
    NSError *error = nil;
    NSArray *datas = [self.context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [self.context deleteObject:obj];
        }
        if (![self.context save:&error])
        {
            NSLog(@"error:%@",error);
            return NO;
        }
        return YES;
    }else {
        return NO;
    }
}
@end
