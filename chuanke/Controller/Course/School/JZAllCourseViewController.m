//
//  JZAllCourseViewController.m
//  chuanke
//
//  Created by jinzelu on 15/7/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZAllCourseViewController.h"
#import "NetworkSingleton.h"
#import "JZAllCourseModel.h"
#import "MJExtension.h"
#import "JZAllCourseCell.h"
#import "JZCourseDetailViewController.h"


@interface JZAllCourseViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSourceArray;/**< 数据源 */
}

@end

@implementation JZAllCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataSourceArray = [[NSMutableArray alloc] init];
    
    [self setNav];
    [self initTableview];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getAllCourseData];
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
    titleLabel.text = @"学校课程";
    [backView addSubview:titleLabel];
    
    //收藏
//    UIButton *collectBtn = [UIButton buttonWithType: UIButtonTypeCustom];
//    collectBtn.frame = CGRectMake(screen_width-40, 20, 40, 40);
//    [collectBtn setImage:[UIImage imageNamed:@"course_info_bg_collect"] forState:UIControlStateNormal];
//    [collectBtn setImage:[UIImage imageNamed:@"course_info_bg_collected"] forState:UIControlStateSelected];
//    [collectBtn addTarget:self action:@selector(OnTapCollectBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [backView addSubview:collectBtn];
}


//
-(void)OnTapBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)OnTapCollectBtn:(UIButton *)sender{
    
}

-(void)initTableview{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

-(void)getAllCourseData{
    __weak typeof(self) weakself = self;
    NSString *urlStr = [NSString stringWithFormat:@"http://pop.client.chuanke.com/?mod=school&act=info&do=%@&sid=%@&uid=%@",self.DO,self.SID,UID];
    [[NetworkSingleton sharedManager] getDataResult:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"请求所有课程成功");
        NSMutableArray *dataArray = responseBody;
        for (int i = 0; i < dataArray.count; i++) {
            JZAllCourseModel *jzAllCourseM = [JZAllCourseModel objectWithKeyValues:dataArray[i]];
            [_dataSourceArray addObject:jzAllCourseM];
        }
        
        [weakself.tableView reloadData];
        
    } failureBlock:^(NSString *error){
        NSLog(@"请求所有课程失败：%@",error);        
    }];
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        static NSString *cellIndentifier = @"allcourseCell";
        JZAllCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[JZAllCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            //下划线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 73.5, screen_width, 0.5)];
            lineView.backgroundColor = separaterColor;
            [cell addSubview:lineView];
        }
        
        JZAllCourseModel *jzAllCourseM = _dataSourceArray[indexPath.row];
        [cell setJzAllCourseM:jzAllCourseM];
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
//    if ([self.DO isEqualToString:@"courseList"]) {//所有课程
//        
//    }else{//所有直播课程
//    
//    }
    
}



#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JZAllCourseModel *jzAllCourseM = _dataSourceArray[indexPath.row];
    JZCourseDetailViewController *jzCourseDVC = [[JZCourseDetailViewController alloc] init];
    jzCourseDVC.SID = self.SID;
    jzCourseDVC.courseId = jzAllCourseM.CourseID;
    [self.navigationController pushViewController:jzCourseDVC animated:YES];
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
