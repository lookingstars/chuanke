//
//  JZCourseDetailViewController.h
//  chuanke
//
//  Created by jinzelu on 15/7/23.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JZCourseDetailViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString    *SID;/**< 接收传参 */
@property (nonatomic, strong) NSString    *courseId;/**< 接收传参 */

@end
