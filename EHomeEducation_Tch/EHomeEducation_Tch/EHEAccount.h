//
//  EHEAccount.h
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/2/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EHEAccount : NSManagedObject

@property (nonatomic, retain) NSString * birthday;
@property (nonatomic, retain) NSString * degree;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * identity;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * majorAdress;
@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * objectInfo;
@property (nonatomic, retain) NSString * qq;
@property (nonatomic, retain) NSNumber * rank;
@property (nonatomic, retain) NSString * sinaweibo;
@property (nonatomic, retain) NSString * subjectInfo;
@property (nonatomic, retain) NSString * teacherIcon;
@property (nonatomic, retain) NSNumber * teacherId;
@property (nonatomic, retain) NSString * telephone;
@property (nonatomic, retain) NSString * timePeriod;

@end
