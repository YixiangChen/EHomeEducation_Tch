//
//  EHEOrder.h
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/2/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EHEOrder : NSManagedObject

@property (nonatomic, retain) NSNumber * customerid;
@property (nonatomic, retain) NSString * customername;
@property (nonatomic, retain) NSString * finishDate;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSString * objectinfo;
@property (nonatomic, retain) NSString * orderdate;
@property (nonatomic, retain) NSNumber * orderid;
@property (nonatomic, retain) NSNumber * orderstatus;
@property (nonatomic, retain) NSString * serviceaddress;
@property (nonatomic, retain) NSString * subjectinfo;
@property (nonatomic, retain) NSNumber * teacherid;
@property (nonatomic, retain) NSString * teachername;
@property (nonatomic, retain) NSString * timeperiod;

@end
