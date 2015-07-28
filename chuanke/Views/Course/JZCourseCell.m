//
//  JZCourseCell.m
//  chuanke
//
//  Created by jinzelu on 15/7/23.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZCourseCell.h"
#import "UIImageView+WebCache.h"

@interface JZCourseCell ()
{
    UIImageView *_imageView;/**< 图 */
    UILabel *_titleLabel;/**< 大标题 */
    UILabel *_subtitleLabel;/**< 小标题 */
}

@end

@implementation JZCourseCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 52)];
    [self addSubview:_imageView];
    //
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, screen_width-100, 30)];
    [self addSubview:_titleLabel];
    //
    _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, screen_width-100, 40)];
    _subtitleLabel.font = [UIFont systemFontOfSize:13];
    _subtitleLabel.textColor = [UIColor lightGrayColor];
    _subtitleLabel.numberOfLines = 2;
    [self addSubview:_subtitleLabel];
}

-(void)setJzCourseM:(JZCourseListModel *)jzCourseM{
    _jzCourseM = jzCourseM;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:jzCourseM.PhotoURL] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
    _titleLabel.text = jzCourseM.CourseName;
    _subtitleLabel.text = jzCourseM.Brief;
}

@end
