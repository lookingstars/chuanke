//
//  JZAllCourseViewController.h
//  chuanke
//
//  Created by jinzelu on 15/7/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZAllCourseViewController : UIViewController


@property(nonatomic, strong) NSString *DO;/**< 用来表示查询的是直播课程(prelectList)，或者是所有非直播课程(courseList) */
@property(nonatomic, strong) NSString *SID;/**< 学校ID */

@property(nonatomic, strong) UITableView *tableView;

@end
