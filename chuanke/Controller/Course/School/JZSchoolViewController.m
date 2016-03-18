//
//  JZSchoolViewController.m
//  chuanke
//
//  Created by jinzelu on 15/7/28.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZSchoolViewController.h"
#import "NetworkSingleton.h"
#import "JZSchoolModel.h"
#import "MJExtension.h"
#import "NSString+Size.h"
#import "UIImageView+WebCache.h"
#import "JZSchoolCell.h"
#import "JZAllCourseViewController.h"

#import "UMSocial.h"

@interface JZSchoolViewController ()<UITableViewDataSource,UITableViewDelegate,JZSchoolDelegate>
{
    JZSchoolModel *_jzSchoolM;
}

@end

@implementation JZSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    [self initTableview];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getSchoolData];
    });
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
    titleLabel.text = @"课程详情";
    [backView addSubview:titleLabel];
    
    //收藏
    UIButton *collectBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(screen_width-40, 20, 40, 40);
    [collectBtn setImage:[UIImage imageNamed:@"course_info_bg_collect"] forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"course_info_bg_collected"] forState:UIControlStateSelected];
    [collectBtn addTarget:self action:@selector(OnTapCollectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:collectBtn];
}

-(void)initTableview{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

//
-(void)OnTapBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)OnTapCollectBtn:(UIButton *)sender{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:UMAPPKEY shareText:@"在美国被禁的网站，请偷偷看" shareImage:[UIImage imageNamed:@"channel_icon_foreign_unpre"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatTimeline,UMShareToWechatSession, nil] delegate:self];
}

-(void)getSchoolData{
    __weak typeof(self) weakself = self;
    NSString *urlStr = [NSString stringWithFormat:@"http://pop.client.chuanke.com/?mod=school&act=info&mode=&sid=%@&uid=%@",self.SID,UID];
    [[NetworkSingleton sharedManager] getDataResult:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"请求学校数据成功");
        
        _jzSchoolM = [JZSchoolModel objectWithKeyValues:responseBody];
        
        [weakself.tableView reloadData];
    } failureBlock:^(NSString *error){
        NSLog(@"请求学校数据失败：%@",error);
    }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_jzSchoolM != nil) {
        return 4;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        if (_jzSchoolM.TeacherList.count>3) {
            return 5;
        }else{
            return 1+_jzSchoolM.TeacherList.count;
        }
    }else{
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 266;
    }else if (indexPath.section == 1){
        CGSize labelSize = [_jzSchoolM.Notice boundingRectWithSize:CGSizeMake(screen_width-20, 0) withFont:13];
        return labelSize.height+10;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            return 40;
        }else if (indexPath.row == 4){
            return 30;
        }else{
            return 70;
        }
    }else{
        if (indexPath.row == 0) {
            CGSize labelSize = [_jzSchoolM.Brief boundingRectWithSize:CGSizeMake(screen_width-20, 0) withFont:13];
            return labelSize.height+30 +10;
        }else{
            return 30;
        }
    }
    return 60;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 10)];
//    headerView.backgroundColor = [UIColor redColor];
//    
//    return headerView;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 10)];
//    footerView.backgroundColor = [UIColor greenColor];
//    
//    return footerView;
//}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellIndentifier = @"schoolCell0";
        JZSchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[JZSchoolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        if (_jzSchoolM != nil) {
            [cell setJzSchoolM:_jzSchoolM];
        }
        
        
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellIndentifier = @"schoolCel1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            //提示
            UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, screen_width-20, 20)];
            noticeLabel.tag = 100;
            noticeLabel.font = [UIFont systemFontOfSize:13];
            noticeLabel.textColor = [UIColor lightGrayColor];
            noticeLabel.numberOfLines = 0;
            [cell addSubview:noticeLabel];
        }
        
        CGSize labelSize = [_jzSchoolM.Notice boundingRectWithSize:CGSizeMake(screen_width-20, 0) withFont:13];
        UILabel *noticeLabel = (UILabel *)[cell viewWithTag:100];
        noticeLabel.text = _jzSchoolM.Notice;
        noticeLabel.frame = CGRectMake(10, 5, screen_width-20, labelSize.height);
        
        
        
        
        return cell;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            static NSString *cellIndentifier = @"schoolCell20";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            cell.textLabel.text = @"学校老师";
            
            return cell;
        }else if (indexPath.row == 4){
            static NSString *cellIndentifier = @"schoolCell24";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
            }
            
            cell.detailTextLabel.text = @"更多";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
        }
        static NSString *cellIndentifier = @"schoolCell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            //头像
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 25;
            imageView.tag = 200;
            [cell addSubview:imageView];
            //昵称
            UILabel *nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, screen_width-10-70, 30)];
            nickNameLabel.textColor = navigationBarColor;
            nickNameLabel.font = [UIFont systemFontOfSize:15];
            nickNameLabel.tag = 201;
            [cell addSubview:nickNameLabel];
            //说说
            UILabel *BriefLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 35, screen_width-10-70, 30)];
            BriefLabel.font = [UIFont systemFontOfSize:13];
            BriefLabel.textColor = [UIColor lightGrayColor];
            BriefLabel.tag = 202;
            [cell addSubview:BriefLabel];
        }
        //
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:200];
        UILabel *nickNameLabel = (UILabel *)[cell viewWithTag:201];
        UILabel *briefLabel = (UILabel *)[cell viewWithTag:202];
        NSDictionary *dic = _jzSchoolM.TeacherList[indexPath.row-1];
        nickNameLabel.text = [dic objectForKey:@"TeacherName"];
        briefLabel.text = [dic objectForKey:@"Brief"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"Avatar"]] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
        
        
        
        
        return cell;
    }else{
        if (indexPath.row == 0) {
            static NSString *cellIndentifier = @"schoolCell30";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
                //学校介绍
                UILabel *schoolInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 25)];
                schoolInfoLabel.text = @"学校介绍";
                [cell addSubview:schoolInfoLabel];
                //内容
                UILabel *briefLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, screen_width-20, 20)];
                briefLabel.font = [UIFont systemFontOfSize:13];
                briefLabel.textColor = [UIColor lightGrayColor];
                briefLabel.numberOfLines = 0;
                briefLabel.tag = 110;
                [cell addSubview:briefLabel];
            }
            
            CGSize labelSize = [_jzSchoolM.Brief boundingRectWithSize:CGSizeMake(screen_width-20, 0) withFont:13];
            UILabel *briefLabel = (UILabel *)[cell viewWithTag:110];
            briefLabel.text = _jzSchoolM.Brief;
            briefLabel.frame = CGRectMake(10, 35, screen_width-20, labelSize.height);
            
            
            return cell;
        }else{
            static NSString *cellIndentifier = @"schoolCell31";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
            }
            
            cell.detailTextLabel.text = @"更多";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
        }
        
    }
    
    
    
    static NSString *cellIndentifier = @"schoolCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    return cell;
}




#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - JZSchoolDelegate
-(void)didSelectedAtIndex:(NSInteger)index{
    NSLog(@"index:%ld",index);
    if (index == 0) {
        JZAllCourseViewController *jzAllCourseVC = [[JZAllCourseViewController alloc] init];
        jzAllCourseVC.DO = @"courseList";
        jzAllCourseVC.SID = self.SID;
        [self.navigationController pushViewController:jzAllCourseVC animated:YES];
    }else if(index == 1){
        JZAllCourseViewController *jzAllCourseVC = [[JZAllCourseViewController alloc] init];
        jzAllCourseVC.DO = @"prelectList";
        jzAllCourseVC.SID = self.SID;
        [self.navigationController pushViewController:jzAllCourseVC animated:YES];
    }else if (index == 2){
        [UMSocialSnsService presentSnsIconSheetView:self appKey:UMAPPKEY shareText:@"在美国被禁的网站，请偷偷看" shareImage:[UIImage imageNamed:@"channel_icon_foreign_unpre"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatTimeline,UMShareToWechatSession, nil] delegate:self];
    }
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
