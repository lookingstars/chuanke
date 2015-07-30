//
//  JZSchoolCell.m
//  chuanke
//
//  Created by jinzelu on 15/7/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZSchoolCell.h"
#import "UIImageView+WebCache.h"

@interface JZSchoolCell ()
{
    UIImageView *_bigImageView;
    UIImageView *_smallImageView;
    
    UIView *_backView1;
    UIView *_backView2;
    UIView *_backView3;
    UIView *_backView4;
    
    UILabel *_kechengLabel;
    UILabel *_zhiboLabel;
}

@end

@implementation JZSchoolCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(246, 246, 246);
        //大图
        _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 210-screen_width, screen_width, screen_width)];
        [_bigImageView setImage:[UIImage imageNamed:@"school_pic9.jpg"]];
        [self addSubview:_bigImageView];
        
        //小图
        _smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 210-30, 60, 60)];
        _smallImageView.layer.masksToBounds = YES;
        _smallImageView.layer.cornerRadius = 5;
        [self addSubview:_smallImageView];
        
        
        
        float minx = 70;
        float width = (screen_width-minx)/4;
        //课程
        _backView1 = [[UIView alloc] initWithFrame:CGRectMake(minx, 210, width, 56)];
        [self addSubview:_backView1];
        
        //tap
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapCourse)];
        [_backView1 addGestureRecognizer:tap1];
        //
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, width, 20)];
        label1.textColor = [UIColor lightGrayColor];
        label1.font = [UIFont systemFontOfSize:11];
        label1.text = @"课程";
        label1.textAlignment = NSTextAlignmentCenter;
        [_backView1 addSubview:label1];
        
        //
        _kechengLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, width, 30)];
        _kechengLabel.textColor = [UIColor lightGrayColor];
        _kechengLabel.font = [UIFont systemFontOfSize:13];
        _kechengLabel.text = @"ke1";
        _kechengLabel.textAlignment = NSTextAlignmentCenter;
        [_backView1 addSubview:_kechengLabel];
        
        
        
        
        //直播
        _backView2 = [[UIView alloc] initWithFrame:CGRectMake(minx+width, 210, width, 56)];
        [self addSubview:_backView2];
        
        //
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapOnline)];
        [_backView2 addGestureRecognizer:tap2];
        
        //
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, width, 20)];
        label2.textColor = [UIColor lightGrayColor];
        label2.font = [UIFont systemFontOfSize:11];
        label2.text = @"直播";
        label2.textAlignment = NSTextAlignmentCenter;
        [_backView2 addSubview:label2];
        
        //
        _zhiboLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, width, 30)];
        _zhiboLabel.textColor = [UIColor lightGrayColor];
        _zhiboLabel.font = [UIFont systemFontOfSize:13];
        _zhiboLabel.text = @"直播1";
        _zhiboLabel.textAlignment = NSTextAlignmentCenter;
        [_backView2 addSubview:_zhiboLabel];
        
        
        
        
        //分享
        _backView3 = [[UIView alloc] initWithFrame:CGRectMake(minx+width*2, 210, width, 56)];
        [self addSubview:_backView3];
        
        //
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 36, width, 20)];
        label3.textColor = [UIColor lightGrayColor];
        label3.font = [UIFont systemFontOfSize:13];
        label3.text = @"分享";
//        [_backView3 addSubview:label3];
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(width/2-27, 0, 55, 55);
        [btn1 setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(OnTapBtn1) forControlEvents:UIControlEventTouchUpInside];
        [_backView3 addSubview:btn1];
        
        
        
        //桌面
        _backView4 = [[UIView alloc] initWithFrame:CGRectMake(minx+width*3, 210, width, 56)];
        [self addSubview:_backView4];
        
        //
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 36, width, 20)];
        label4.textColor = [UIColor lightGrayColor];
        label4.font = [UIFont systemFontOfSize:13];
        label4.text = @"放到桌面";
//        [_backView4 addSubview:label4];
        
        NSLog(@"width:%f",width);
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(width/2-27, 0, 55, 55);
        [btn2 setImage:[UIImage imageNamed:@"desktop"] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(OnTapBtn2) forControlEvents:UIControlEventTouchUpInside];
        [_backView4 addSubview:btn2];
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

-(void)setJzSchoolM:(JZSchoolModel *)jzSchoolM{
    _jzSchoolM = jzSchoolM;
    
    [_smallImageView sd_setImageWithURL:[NSURL URLWithString:_jzSchoolM.SchoolLogoUrl] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
    _kechengLabel.text = _jzSchoolM.CourseSaleNumber;
    _zhiboLabel.text = _jzSchoolM.PrelectNum;
    
}

-(void)OnTapCourse{
    [self.delegate didSelectedAtIndex:0];
}

-(void)OnTapOnline{
    if ([_jzSchoolM.PrelectNum isEqualToString:@"0"]) {
        return;
    }
    [self.delegate didSelectedAtIndex:1];
}

-(void)OnTapBtn1{
    [self.delegate didSelectedAtIndex:2];
}
-(void)OnTapBtn2{
    [self.delegate didSelectedAtIndex:3];
}

@end
