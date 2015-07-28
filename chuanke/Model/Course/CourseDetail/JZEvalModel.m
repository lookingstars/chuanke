//
//  JZEvalModel.m
//  chuanke
//
//  Created by jinzelu on 15/7/28.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZEvalModel.h"
#import "MJExtension.h"
#import "NSString+Size.h"

@implementation JZEvalModel

+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"_UID":@"UID"};
}

-(void)setCreateTime:(NSString *)CreateTime{
    _CreateTime = CreateTime;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[CreateTime integerValue]];
//    NSLog(@"时间：%ld",[CreateTime integerValue]);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
//    NSLog(@"str:%@",confromTimespStr);
    
    _CreateTimeToDate = confromTimespStr;
}

-(void)setVoteText:(NSString *)VoteText{
    _VoteText = VoteText;
    
    CGSize labelsize = [VoteText boundingRectWithSize:CGSizeMake(screen_width-10-70, 0) withFont:13];
    _voteTextHeight = labelsize.height;
//    NSLog(@"votetext:%@",VoteText);
//    NSLog(@"宽:%f  高:%f",labelsize.width,labelsize.height);
}



@end
