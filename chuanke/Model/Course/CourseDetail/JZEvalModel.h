//
//  JZEvalModel.h
//  chuanke
//
//  Created by jinzelu on 15/7/28.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZEvalModel : NSObject

@property(nonatomic, strong) NSString *VoteID;
@property(nonatomic, strong) NSString *SID;
@property(nonatomic, strong) NSString *CourseID;
@property(nonatomic, strong) NSString *CourseName;
@property(nonatomic, strong) NSString *OID;

@property(nonatomic, strong) NSString *_UID;
@property(nonatomic, strong) NSString *Appraise;
@property(nonatomic, strong) NSString *VoteText;
@property(nonatomic, strong) NSString *CreateTime;
@property(nonatomic, strong) NSString *ReplayText;

@property(nonatomic, strong) NSString *ReplayTime;
@property(nonatomic, strong) NSString *ReplayIP;
@property(nonatomic, strong) NSString *IsAnoy;
@property(nonatomic, strong) NSString *AddVoteText;////
@property(nonatomic, strong) NSString *AddVoteTime;

@property(nonatomic, strong) NSString *UpdateTime;
@property(nonatomic, strong) NSString *NickName;
@property(nonatomic, strong) NSString *Avatar;


@property(nonatomic, strong) NSString *CreateTimeToDate;/**< 格式化的时间 */
@property(nonatomic, assign) float voteTextHeight;/**< 评论高度 */

@end
