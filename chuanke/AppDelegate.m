//
//  AppDelegate.m
//  chuanke
//
//  Created by jinzelu on 15/7/22.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "AppDelegate.h"
#import "JZCourseViewController.h"
#import "iflyMSC/iflyMSC.h"
#import "MineViewController.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "MobClick.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)initRootVC{
    //此处一定要给window一个frame，添加广告image时这个必须要。
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];//添加这句后，在播放视频时，播放界面横屏失败。
    
    //1.
    JZCourseViewController *VC1 = [[JZCourseViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:VC1];
    MineViewController *VC2 = [[MineViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:VC2];
    UIViewController *VC3 = [[UIViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:VC3];
    VC1.title = @"课程推荐";
    VC2.title = @"我的传课";
    VC3.title = @"离线下载";
    //2.
    NSArray *viewCtrs = @[nav1,nav2,nav3];
    //3.
    self.rootTabbarCtr = [[UITabBarController alloc] init];
    [self.rootTabbarCtr setViewControllers:viewCtrs animated:YES];
    //4.
    self.window.rootViewController = self.rootTabbarCtr;
    
    //5.
    UITabBar *tabbar = self.rootTabbarCtr.tabBar;
    UITabBarItem *item0 = [tabbar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabbar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabbar.items objectAtIndex:2];
    
    item0.selectedImage = [[UIImage imageNamed:@"bottom_tab1_pre"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.image = [[UIImage imageNamed:@"bottom_tab1_unpre"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.selectedImage = [[UIImage imageNamed:@"bottom_tab2_pre"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"bottom_tab2_unpre"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"bottom_tab3_pre"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"bottom_tab3_unpre"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //改变UITabBarItem字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:navigationBarColor,UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //科大讯飞语音初始化
        //创建语音配置,appid必须要传入，仅执行一次则可
        NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"55b19e88"];
        
        //所有服务启动前，需要确保执行createUtility
        [IFlySpeechUtility createUtility:initString];
    });
    
    
    //友盟统计
    [MobClick startWithAppkey:UMAPPKEY reportPolicy:BATCH   channelId:@"GitHub"];
    
    //友盟初始化
    [UMSocialData setAppKey:UMAPPKEY];
    [UMSocialWechatHandler setWXAppId:@"wx0e3e603965a187d4" appSecret:@"299d15c8b4d1fdb218fd49a0b8eaa4e2" url:@"http://www.fityun.cn/"];
    
    //友盟初始化，对未安装QQ，微信的平台进行隐藏
    //    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToWechatSession,UMShareToWechatTimeline]];
    
    
    
    
    
    [self.window makeKeyAndVisible];
}





- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initRootVC];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if ([[url scheme] isEqualToString:@"openchuankekkiphone"]) {
        [application setApplicationIconBadgeNumber:10];
        return YES;
    }
    return NO;
}

//禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (_isFullScreen) {
        return UIInterfaceOrientationMaskAll;
        return UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskPortrait;
}

@end
/**
 *  作者：ljz
 *  QQ：  863784757
 *  github：https://github.com/lookingstars/chuanke
 *  申明：转载请注明出处，不可用于其他商业用途，不可用于不合法用途。
 */
