//
//  JZCateModel.h
//  chuanke
//
//  Created by jinzelu on 15/7/30.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZCateModel : NSObject

@property(nonatomic, strong) NSString *CourseID;
@property(nonatomic, strong) NSString *CourseName;
@property(nonatomic, strong) NSString *SID;
@property(nonatomic, strong) NSString *SchoolName;
@property(nonatomic, strong) NSNumber *PrelectStartTime;

@property(nonatomic, strong) NSNumber *ClassNumber;
@property(nonatomic, strong) NSString *ExpiryTime;
@property(nonatomic, strong) NSString *PayEndTime;
@property(nonatomic, strong) NSString *Cost;
@property(nonatomic, strong) NSString *PhotoURL;

@property(nonatomic, strong) NSString *Brief;
@property(nonatomic, strong) NSString *StudentNumber;
@property(nonatomic, strong) NSString *PayStudentLimit;



@end
