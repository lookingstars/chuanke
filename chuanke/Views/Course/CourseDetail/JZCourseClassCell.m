//
//  JZCourseClassCell.m
//  chuanke
//
//  Created by jinzelu on 15/7/27.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZCourseClassCell.h"

@interface JZCourseClassCell ()
{
    UIImageView *_imageView;
    UILabel *_classNameLabel;/**< 课程名 */
    UILabel *_classHourseLabel;/**< 课程时长 */
}

@end

@implementation JZCourseClassCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(16, 0, 1, 64)];
        lineView.backgroundColor = navigationBarColor;
        [self addSubview:lineView];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 22, 20, 20)];
        _imageView.image = [UIImage imageNamed:@"course_class_study_status_not"];
        [self addSubview:_imageView];
        //课程名
        _classNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, screen_width-10-50, 30)];
        _classNameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_classNameLabel];
        //课程时长
        _classHourseLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, screen_width-10-50, 30)];
        _classHourseLabel.textColor = [UIColor lightGrayColor];
        _classHourseLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_classHourseLabel];
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

-(void)setJzClassM:(JZClassListModel *)jzClassM{
    _jzClassM = jzClassM;
    _classNameLabel.text = [NSString stringWithFormat:@"第%@节:%@",jzClassM.index,jzClassM.ClassName];
    
    int length = [jzClassM.VideoTimeLength intValue];
    _classHourseLabel.text = [NSString stringWithFormat:@"课程时长：%d分钟",length/60];
}



@end
