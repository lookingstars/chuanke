//
//  JZAllCourseModel.h
//  chuanke
//
//  Created by jinzelu on 15/7/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZAllCourseModel : NSObject

@property(nonatomic, strong) NSString *CourseID;
@property(nonatomic, strong) NSString *PhotoURL;
@property(nonatomic, strong) NSString *Cost;
@property(nonatomic, strong) NSString *CourseName;
@property(nonatomic, strong) NSString *StudentNumber;

@property(nonatomic, strong) NSString *ClassNumber;
@property(nonatomic, strong) NSNumber *PrelectTime;

@end
