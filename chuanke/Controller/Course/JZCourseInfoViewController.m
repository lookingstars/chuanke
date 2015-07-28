//
//  JZCourseInfoViewController.m
//  chuanke
//
//  Created by jinzelu on 15/7/28.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZCourseInfoViewController.h"
#import "NSString+Size.h"

@interface JZCourseInfoViewController ()

@end

@implementation JZCourseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self setNav];
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setNav{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor = navigationBarColor;
    [self.view addSubview:backView];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"file_tital_back_but"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backBtn];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/2-60, 20, 120, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"课程简介";
    [backView addSubview:titleLabel];
    
    //收藏
//    UIButton *collectBtn = [UIButton buttonWithType: UIButtonTypeCustom];
//    collectBtn.frame = CGRectMake(screen_width-40, 20, 40, 40);
//    [collectBtn setImage:[UIImage imageNamed:@"course_info_bg_collect"] forState:UIControlStateNormal];
//    [collectBtn setImage:[UIImage imageNamed:@"course_info_bg_collected"] forState:UIControlStateSelected];
//    [collectBtn addTarget:self action:@selector(OnTapCollectBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [backView addSubview:collectBtn];
}


-(void)OnTapBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)initViews{
    CGSize labelSize = [self.Brief boundingRectWithSize:CGSizeMake(screen_width-20, 0) withFont:15];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 64+10, labelSize.width, labelSize.height)];
    textLabel.font = [UIFont systemFontOfSize:15];
    textLabel.text = self.Brief;
    textLabel.numberOfLines = 0;
    [self.view addSubview:textLabel];
}










/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
