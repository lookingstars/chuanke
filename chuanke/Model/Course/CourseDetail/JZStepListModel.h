//
//  JZStepListModel.h
//  chuanke
//
//  Created by jinzelu on 15/7/27.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZStepListModel : NSObject

@property(nonatomic, strong) NSString *StepID;
@property(nonatomic, strong) NSString *StepIndex;
@property(nonatomic, strong) NSString *StepName;
@property(nonatomic, strong) NSMutableArray *ClassList;

@end
