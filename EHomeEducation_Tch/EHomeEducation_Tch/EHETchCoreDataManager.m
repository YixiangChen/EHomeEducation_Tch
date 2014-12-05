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
    
    if ([self fetchOrderWithOrderId:[[dictOrder objectForKey:@"orderid"] intValue]] == nil) {
        NSLog(@"order does not exist");
    EHEOrder *order = [NSEntityDescription insertNewObjectForEntityForName:@"EHEOrder" inManagedObjectContext:self.context];
    order.customerid = [NSNumber numberWithInt:[[dictOrder objectForKey:@"customerid"] intValue ]];
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
        NSLog(@"saving encounted problem");
    return NO;
    }
    }
    NSLog(@"order already exist");
    return YES;
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

-(EHECustomer *)fetchCustomerWithCustomerId:(int)customerId {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"EHECustomer"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"customerid = %d", customerId];
    fetchRequest.predicate = predicate;
    
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"customerid" ascending:NO];
    NSArray *sorts = [[NSArray alloc] initWithObjects:sortByName, nil];
    fetchRequest.sortDescriptors = sorts;
    
    NSError *error;
    NSArray *customers = [self.context executeFetchRequest:fetchRequest error:&error];
    
    if (error)
    {
        return nil;
    }
    else if (customers.count > 0)
    {
        return customers[0];
    }
    return nil;
}

-(BOOL)saveCustomerInfos:(NSDictionary *)dictCustomer {
    if ([self fetchCustomerWithCustomerId:[[dictCustomer objectForKey:@"customerid"] intValue]] == nil) {
        EHECustomer *customer = [NSEntityDescription insertNewObjectForEntityForName:@"EHECustomer" inManagedObjectContext:self.context];
        customer.customerid = [NSNumber numberWithInt:[[dictCustomer objectForKey:@"customerid"] intValue]];
        customer.latitude = [NSNumber numberWithFloat:[[dictCustomer objectForKey:@"latitude"] floatValue]];
        customer.longitude = [NSNumber numberWithFloat:[[dictCustomer objectForKey:@"longitude"] floatValue]];
        customer.name = [dictCustomer objectForKey:@"name"];
        customer.majoraddress = [dictCustomer objectForKey:@"majoraddress"];
        customer.usericon = [dictCustomer objectForKey:@"usericon"];
        customer.telephone = [dictCustomer objectForKey:@"telephone"];
        customer.memo = [dictCustomer objectForKey:@"memo"];
        customer.qq = [dictCustomer objectForKey:@"qq"];
        customer.sinaweibo = [dictCustomer objectForKey:@"sinaweibo"];
        customer.rank1 = [NSNumber numberWithInt:[[[dictCustomer objectForKey:@"rank"] objectForKey:@"rank1"] intValue]];
        customer.rank2 = [NSNumber numberWithInt:[[[dictCustomer objectForKey:@"rank"] objectForKey:@"rank2"] intValue]];
        customer.rank3 = [NSNumber numberWithInt:[[[dictCustomer objectForKey:@"rank"] objectForKey:@"rank3"] intValue]];
        customer.rank4 = [NSNumber numberWithInt:[[[dictCustomer objectForKey:@"rank"] objectForKey:@"rank4"] intValue]];
        customer.rank5 = [NSNumber numberWithInt:[[[dictCustomer objectForKey:@"rank"] objectForKey:@"rank5"] intValue]];
        
        int rank = [[[dictCustomer objectForKey:@"rank"] objectForKey:@"rank1"] intValue]*1 + [[[dictCustomer objectForKey:@"rank"] objectForKey:@"rank2"] intValue]*2 + [[[dictCustomer objectForKey:@"rank"] objectForKey:@"rank3"] intValue]*3 + [[[dictCustomer objectForKey:@"rank"] objectForKey:@"rank4"] intValue]*4 + [[[dictCustomer objectForKey:@"rank"] objectForKey:@"rank5"] intValue]*5;
        customer.rank = [NSNumber numberWithInt:rank/5];
        
        NSError *error;
        [self.context save:&error];
        if (error == nil) {
            return YES;
        } else {
            return NO;
        }
    }
    NSLog(@"Customer Id %d exists", [[dictCustomer objectForKey:@"customerid"] intValue]);
    return YES;
    

}
@end
