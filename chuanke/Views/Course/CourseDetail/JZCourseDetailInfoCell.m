//
//  JZCourseDetailInfoCell.m
//  chuanke
//
//  Created by jinzelu on 15/7/27.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZCourseDetailInfoCell.h"
#import "UIImageView+WebCache.h"

@interface JZCourseDetailInfoCell ()
{
    UIImageView *_imageView;/**< 图 */
    UILabel *_courseNameLabel;/**< 课程名 */
    UILabel *_priceLabel;/**< 价格 */
    UIImageView *_numsImageView;/**< 头像 */
    UILabel *_numsLabel;/**< 人数 */
    UILabel *_schoolNameLabel;/**< 学校名 */
}

@end

@implementation JZCourseDetailInfoCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = navigationBarColor;
        [self initViews];
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

-(void)initViews{
    //图
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 52)];
    [self addSubview:_imageView];
    //课程名
    _courseNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, screen_width-100, 30)];
    _courseNameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_courseNameLabel];
    //价格
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_imageView.frame)+10, 80, 30)];
    _priceLabel.textColor = [UIColor whiteColor];
    _priceLabel.font = [UIFont systemFontOfSize:15];
    _priceLabel.text = @"￥免费";
    [self addSubview:_priceLabel];
    //人数头像
    _numsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_priceLabel.frame)+10, CGRectGetMaxY(_imageView.frame)+15, 18, 18)];
    [_numsImageView setImage:[UIImage imageNamed:@"course_studs_nums"]];
    [self addSubview:_numsImageView];
    //人数
    _numsLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_numsImageView.frame)+5, CGRectGetMaxY(_imageView.frame)+10, 50, 30)];
    _numsLabel.textColor = [UIColor whiteColor];
    _numsLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_numsLabel];
    
    //学校
    _schoolNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-20-130, CGRectGetMaxY(_imageView.frame)+10, 130, 25)];
    _schoolNameLabel.textColor = [UIColor whiteColor];
    _schoolNameLabel.layer.cornerRadius = 3;
    _schoolNameLabel.layer.masksToBounds = YES;
    _schoolNameLabel.layer.borderWidth = 1;
    _schoolNameLabel.font = [UIFont systemFontOfSize:13];
    _schoolNameLabel.layer.borderColor = [RGB(46, 158, 138) CGColor];
    [self addSubview:_schoolNameLabel];
    _schoolNameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapSchoolLabel)];
    [_schoolNameLabel addGestureRecognizer:tap];
    
    
    //
    UIImageView *arrowImageview = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_schoolNameLabel.frame)-13, CGRectGetMinY(_schoolNameLabel.frame), 13, 25)];
    [arrowImageview setImage:[UIImage imageNamed:@"course_school_classify_icon"]];
    [self addSubview:arrowImageview];
    
    
    
    
}

-(void)setJzCourseDM:(JZCourseDetailModel *)jzCourseDM{
    _jzCourseDM = jzCourseDM;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:jzCourseDM.PhotoURL] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
    
    _courseNameLabel.text = jzCourseDM.CourseName;
    _numsLabel.text = [NSString stringWithFormat:@"%@人",jzCourseDM.StudentNumber];
    _schoolNameLabel.text = [NSString stringWithFormat:@"  %@",jzCourseDM.SchoolName];
    if ([jzCourseDM.Cost isEqualToString:@"0"]) {
        _priceLabel.text = @"￥免费";
    }else{
        int cost = [jzCourseDM.Cost intValue];
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",cost/100.0];
    }
}

-(void)OnTapSchoolLabel{
    [self.delegate didSelectedSchool];
}








@end
