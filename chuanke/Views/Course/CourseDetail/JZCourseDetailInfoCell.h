//
//  JZCourseDetailInfoCell.h
//  chuanke
//
//  Created by jinzelu on 15/7/27.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZCourseDetailModel.h"

@protocol JZCourseDetailInfoDelegate <NSObject>

@optional
-(void)didSelectedSchool;

@end

@interface JZCourseDetailInfoCell : UITableViewCell

@property(nonatomic, strong) JZCourseDetailModel *jzCourseDM;/**< 数据 */

@property(nonatomic, assign) id<JZCourseDetailInfoDelegate> delegate;

@end
