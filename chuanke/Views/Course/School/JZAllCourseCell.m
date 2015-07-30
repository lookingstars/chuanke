//
//  JZAllCourseCell.m
//  chuanke
//
//  Created by jinzelu on 15/7/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZAllCourseCell.h"
#import "UIImageView+WebCache.h"

@interface JZAllCourseCell ()
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_classNumLabel;
    UILabel *_studentNumLabel;
    UILabel *_priceLabel;
    
    UIImageView *_classImagev;
    UIImageView *_studentImagev;
}

@end

@implementation JZAllCourseCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //图片
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 72, 55)];
        [self addSubview:_imageView];
        //课程名
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, screen_width-10-90, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_titleLabel];
        //课时头像
        _classImagev = [[UIImageView alloc] initWithFrame:CGRectMake(90, 33, 12, 12)];
        [_classImagev setImage:[UIImage imageNamed:@"course_class_nums_icon"]];
        [self addSubview:_classImagev];
        //课时
        _classNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 30, screen_width-10-120, 20)];
        _classNumLabel.font = [UIFont systemFontOfSize:13];
        _classNumLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_classNumLabel];
        //人数头像
        _studentImagev = [[UIImageView alloc] initWithFrame:CGRectMake(90, 53, 12, 12)];
        [_studentImagev setImage:[UIImage imageNamed:@"course_studs_nums_green"]];
        [self addSubview:_studentImagev];
        //人数
        _studentNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 50, screen_width-10-50, 20)];
        _studentNumLabel.font = [UIFont systemFontOfSize:13];
        _studentNumLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_studentNumLabel];
        //价格
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-10-70, 30, 70, 25)];
        _priceLabel.layer.borderWidth = 1;
        _priceLabel.layer.borderColor = [[UIColor orangeColor] CGColor];
        _priceLabel.layer.cornerRadius = 5;
        _priceLabel.textColor = [UIColor orangeColor];
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.text = @"￥199.00";
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_priceLabel];
        
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

/**< 学校查看所有课程模块传参时用 */
-(void)setJzAllCourseM:(JZAllCourseModel *)jzAllCourseM{
    _jzAllCourseM = jzAllCourseM;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:jzAllCourseM.PhotoURL] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
    _titleLabel.text = jzAllCourseM.CourseName;
    _classNumLabel.text = [NSString stringWithFormat:@"%@课时",jzAllCourseM.ClassNumber];
    _studentNumLabel.text = [NSString stringWithFormat:@"%@人",jzAllCourseM.StudentNumber];
    if ([jzAllCourseM.Cost isEqualToString:@"0"]) {
        _priceLabel.hidden = YES;
    }else{
        NSInteger cost = [jzAllCourseM.Cost integerValue];
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",cost/100.0];
        _priceLabel.hidden = NO;
    }
}


/**< 课程分类模块传参时用 */
-(void)setJzCateM:(JZCateModel *)jzCateM{
    _jzCateM = jzCateM;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:jzCateM.PhotoURL] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
    _titleLabel.text = jzCateM.CourseName;
    _classNumLabel.text = [NSString stringWithFormat:@"%@课时",jzCateM.ClassNumber];
    _studentNumLabel.text = jzCateM.SchoolName;
    
    if ([jzCateM.Cost isEqualToString:@"0"]) {
        _priceLabel.hidden = YES;
    }else{
        NSInteger cost = [jzCateM.Cost integerValue];
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",cost/100.0];
        _priceLabel.hidden = NO;
    }
    
//    [_studentImagev setImage:[UIImage imageNamed:@""]];
    
    
    
    
    
    
}

@end
