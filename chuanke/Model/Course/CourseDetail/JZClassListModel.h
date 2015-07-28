//
//  JZClassListModel.h
//  chuanke
//
//  Created by jinzelu on 15/7/27.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZClassListModel : NSObject

@property(nonatomic, strong) NSString *CID;
@property(nonatomic, strong) NSString *ClassIndex;
@property(nonatomic, strong) NSString *StudyType;
@property(nonatomic, strong) NSString *TrailFlag;
@property(nonatomic, strong) NSString *PrelectStatus;

@property(nonatomic, strong) NSString *VideoStatus;
@property(nonatomic, strong) NSString *PrelectStartTime;
@property(nonatomic, strong) NSString *PrelectTimeLength;
@property(nonatomic, strong) NSString *VideoTimeLength;
@property(nonatomic, strong) NSString *TeacherUID;

@property(nonatomic, strong) NSString *TeacherName;
@property(nonatomic, strong) NSString *ClassName;
@property(nonatomic, strong) NSString *Brief;
@property(nonatomic, strong) NSString *VideoID;
@property(nonatomic, strong) NSString *Courseware;

@property(nonatomic, strong) NSString *OffLineID;
@property(nonatomic, strong) NSMutableArray *VideoUrl;
@property(nonatomic, strong) NSMutableArray *QuizList;

@property(nonatomic, strong) NSString *isLast;
@property(nonatomic, strong) NSString *index;

@end
