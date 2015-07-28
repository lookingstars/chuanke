//
//  JZEvalCell.m
//  chuanke
//
//  Created by jinzelu on 15/7/28.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZEvalCell.h"
#import "UIImageView+WebCache.h"

#define MARGIN 5

@interface JZEvalCell ()
{
    UIImageView *_imageView;/**< 头像 */
    UILabel *_nickNameLabel;/**< 昵称 */
    UILabel *_voteTextLabel;/**< 内容 */
    UILabel *_createTimeLabel;/**< 时间 */
    
    UIView *_lineView;
}

@end

@implementation JZEvalCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 30;
        [self addSubview:_imageView];
        
        //昵称 10+20
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+10, 10, screen_width-10-10-CGRectGetMaxX(_imageView.frame), 20)];
        _nickNameLabel.textColor = navigationBarColor;
        _nickNameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_nickNameLabel];
        
        //评论 5+H
        _voteTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+10, CGRectGetMaxY(_nickNameLabel.frame)+MARGIN, screen_width-10-10-CGRectGetMaxX(_imageView.frame), 20)];
        _voteTextLabel.font = [UIFont systemFontOfSize:13];
        _voteTextLabel.textColor = [UIColor lightGrayColor];
        _voteTextLabel.numberOfLines = 0;
        [self addSubview:_voteTextLabel];
        //时间 5+20
        _createTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+10, CGRectGetMaxY(_voteTextLabel.frame)+MARGIN, screen_width-10-10-CGRectGetMaxX(_imageView.frame), 20)];
        _createTimeLabel.textColor = [UIColor lightGrayColor];
        _createTimeLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_createTimeLabel];
        
        //下划线 +5
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(_createTimeLabel.frame)+MARGIN-0.5, screen_width-70, 0.5)];
        _lineView.backgroundColor = separaterColor;
        [self addSubview:_lineView];
        
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




-(void)setJzEvalM:(JZEvalModel *)jzEvalM{
    _jzEvalM = jzEvalM;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:jzEvalM.Avatar] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
    if ([jzEvalM.NickName isEqualToString:@""]) {
        _nickNameLabel.text = @"匿名";
    }else{
        _nickNameLabel.text = [NSString stringWithFormat:@"%@",jzEvalM.NickName];
    }
    
    
    _voteTextLabel.text = jzEvalM.VoteText;
    _createTimeLabel.text = [NSString stringWithFormat:@"发布时间:%@",jzEvalM.CreateTimeToDate];
    
    _voteTextLabel.frame = CGRectMake(80, 30+5, screen_width-80-10, jzEvalM.voteTextHeight);
    _createTimeLabel.frame = CGRectMake(80, CGRectGetMaxY(_voteTextLabel.frame)+MARGIN, screen_width-80-10, 20);
    _lineView.frame = CGRectMake(80, CGRectGetMaxY(_createTimeLabel.frame)+MARGIN-0.5, screen_width-80, 0.5);
}

@end
