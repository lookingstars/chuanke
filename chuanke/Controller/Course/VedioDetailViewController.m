//
//  VedioDetailViewController.m
//  aoyouHH
//
//  Created by jinzelu on 15/5/20.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "VedioDetailViewController.h"
#import "JZVideoPlayerView.h"

#import "AppDelegate.h"

@interface VedioDetailViewController ()<JZPlayerViewDelegate>
{
    JZVideoPlayerView *_jzPlayer;
}

@end

@implementation VedioDetailViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self initPlayer];
        [self initJZPlayer];
    });
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.isFullScreen = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.isFullScreen = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)initJZPlayer{
    NSURL *url = [NSURL URLWithString:self.FileUrl];
    _jzPlayer = [[JZVideoPlayerView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 300) contentURL:url];
    _jzPlayer.delegate = self;
    [self.view addSubview:_jzPlayer];
    [_jzPlayer play];
}


//屏幕旋转
-(BOOL)shouldAutorotate{
    return YES;
}
//支持旋转的方向
//一开始的屏幕旋转方向
//支持旋转的方向
//一开始的屏幕旋转方向
- (NSUInteger)supportedInterfaceOrientations
{
    NSLog(@"11222111111");

    return UIInterfaceOrientationLandscapeLeft;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"11111111");
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0 animations:^{
        if (UIDeviceOrientationIsLandscape(toInterfaceOrientation)) {
            _jzPlayer.frame = CGRectMake(0, 0, weakself.view.frame.size.height, weakself.view.frame.size.width);
        }else{
            _jzPlayer.frame = CGRectMake(0, 0, weakself.view.frame.size.height, 300);
        }
    } completion:^(BOOL finished){
        
    }];
}



-(void)playerViewZoomButtonClicked:(JZVideoPlayerView *)view{
    //强制横屏
    NSLog(@"222222");
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        
        if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:[UIDevice currentDevice]];
            int val = UIInterfaceOrientationPortrait;//
            [invocation setArgument:&val atIndex:2];
            [invocation invoke];
        }else{
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:[UIDevice currentDevice]];
            int val = UIInterfaceOrientationLandscapeRight;//
            [invocation setArgument:&val atIndex:2];
            [invocation invoke];
        }
    }
}

#pragma mark - JZPlayerViewDelegate
-(void)JZOnBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
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
