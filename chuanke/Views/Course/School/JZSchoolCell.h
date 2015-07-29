//
//  JZSchoolCell.h
//  chuanke
//
//  Created by jinzelu on 15/7/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZSchoolModel.h"

@protocol JZSchoolDelegate <NSObject>

@optional
-(void)didSelectedAtIndex:(NSInteger)index;

@end

@interface JZSchoolCell : UITableViewCell

@property(nonatomic, strong) JZSchoolModel *jzSchoolM;/**< 传数据 */

@property(nonatomic, assign) id<JZSchoolDelegate> delegate;

@end
