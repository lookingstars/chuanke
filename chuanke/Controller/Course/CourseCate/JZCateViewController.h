//
//  JZCateViewController.h
//  chuanke
//
//  Created by jinzelu on 15/7/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZCateViewController : UIViewController

@property(nonatomic, strong) UITableView *tableView;


//zhibo 和 feizhibo    时必须传的参数
@property(nonatomic, strong) NSString *cateType;/**< 课程类型 @"zhibo";@"feizhibo"*/

//feizhibo  时必须传的参数
@property(nonatomic, strong) NSMutableArray *cateNameArray;/**< 课程名数组 */
@property(nonatomic, strong) NSMutableArray *cateIDArray;/**< 课程ID数组 */

@end
