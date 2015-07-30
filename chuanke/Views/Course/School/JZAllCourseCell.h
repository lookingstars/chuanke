//
//  JZAllCourseCell.h
//  chuanke
//
//  Created by jinzelu on 15/7/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZAllCourseModel.h"

#import "JZCateModel.h"

@interface JZAllCourseCell : UITableViewCell

@property(nonatomic, strong) JZAllCourseModel *jzAllCourseM;/**< 学校查看所有课程模块传参时用 */


@property(nonatomic, strong) JZCateModel *jzCateM;/**< 课程分类模块传参时用 */



@end
