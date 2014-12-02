//
//  EHECustomer.h
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/2/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EHECustomer : NSManagedObject

@property (nonatomic, retain) NSNumber * customerid;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * majoraddress;
@property (nonatomic, retain) NSString * usericon;
@property (nonatomic, retain) NSString * telephone;
@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSString * qq;
@property (nonatomic, retain) NSString * sinaweibo;
@property (nonatomic, retain) NSNumber * rank;
@property (nonatomic, retain) NSNumber * rank1;
@property (nonatomic, retain) NSNumber * rank2;
@property (nonatomic, retain) NSNumber * rank3;
@property (nonatomic, retain) NSNumber * rank4;
@property (nonatomic, retain) NSNumber * rank5;

@end
