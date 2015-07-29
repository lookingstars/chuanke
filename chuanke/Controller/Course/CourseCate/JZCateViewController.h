//
//  JZCateViewController.h
//  chuanke
//
//  Created by jinzelu on 15/7/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZCateViewController : UIViewController

@property(nonatomic, strong) NSString *cateType;/**< 课程类型 */
@property(nonatomic, strong) NSMutableArray *cateArray;/**< 课程 */
@property(nonatomic, strong) UITableView *tableView;


@end
