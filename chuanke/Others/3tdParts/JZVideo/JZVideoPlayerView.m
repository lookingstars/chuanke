//
//  JZVideoPlayerView.m
//  aoyouHH
//
//  Created by jinzelu on 15/5/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZVideoPlayerView.h"

//// 2.获得RGB颜色
//#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
//#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)
//
//#define navigationBarColor RGB(56, 184, 80)
//
//
//// 3.是否为4inch
//#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)
//
//// 4.屏幕大小尺寸
//#define screen_width [UIScreen mainScreen].bounds.size.width
//#define screen_height [UIScreen mainScreen].bounds.size.height

@interface JZVideoPlayerView ()
{
    id playbackObserver;
    
    UIView *loadView;
    UIActivityIndicatorView *activityIndicatorView;
    NSTimer *timer;
    BOOL viewIsShowing;
}

@end

@implementation JZVideoPlayerView

-(id)initWithFrame:(CGRect)frame contentURL:(NSURL *)contentURL{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        self.playerItem = [AVPlayerItem playerItemWithURL:contentURL];
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.frame = frame;
        [self.layer addSublayer:self.playerLayer];
        
        
        [self initLoadingView];
        [self initControlView];
        viewIsShowing = YES;
        //添加监听
        [self addNotification];
        [self addObserverToPlayerItem:self.playerItem];
        [self addProgressObserver];
        
    }
    return self;
}

-(void)dealloc{
    [self removeObserverToPlayerItem:self.playerItem];
    [self.player removeTimeObserver:playbackObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.playerLayer setFrame:frame];
}

-(void)setIsFullScreen:(BOOL)isFullScreen{
    _isFullScreen = isFullScreen;
    if (isFullScreen) {
        //
    }else{
        //
    }
}

-(void)play{
    [self.player play];
    self.isPlaying = YES;
    [self.playBtn setSelected:YES];
}

-(void)pause{
    [self.player pause];
    self.isPlaying = NO;
    [self.playBtn setSelected:NO];
}

-(void)stop{
    
}

-(void)initLoadingView{
    loadView = [[UIView alloc] initWithFrame:self.playerLayer.frame];
    NSLog(@"playerLayer:=====%f   %f",self.playerLayer.frame.size.width,self.playerLayer.frame.size.height);
    loadView.backgroundColor = [UIColor clearColor];
    
    
    //
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [activityIndicatorView setCenter:loadView.center];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicatorView startAnimating];
    [loadView addSubview:activityIndicatorView];
    
    [self addSubview:loadView];
}
//初始化播放，进度条，时间等视图
-(void)initControlView{
    int frameWidth = self.frame.size.width;
    int frameHeight = self.frame.size.height;
    
    //上面的遮罩
    self.playerHUDTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, frameWidth, 44)];
    [self addSubview:self.playerHUDTopView];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(15, 0, 30, 30);
    [self.backBtn addTarget:self action:@selector(OnBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.playerHUDTopView addSubview:self.backBtn];
    
    //下面的遮罩
    self.playerHUDBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, frameHeight-44, frameWidth, 44)];
    self.playerHUDBottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self addSubview:self.playerHUDBottomView];
    //播放，暂停按钮
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtn.frame = CGRectMake(8, 10, 20, 20);
    [self.playBtn addTarget:self action:@selector(OnPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.playBtn setSelected:NO];
    [self.playBtn setBackgroundImage:[UIImage imageNamed:@"full_pause_icon"] forState:UIControlStateSelected];
    [self.playBtn setBackgroundImage:[UIImage imageNamed:@"full_play_icon"] forState:UIControlStateNormal];
    [self.playBtn setTintColor:[UIColor clearColor]];
    [self.playerHUDBottomView addSubview:self.playBtn];
    //全屏按钮
    self.zoomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zoomBtn.frame = CGRectMake(frameWidth-27, 10, 20, 20);
    [self.zoomBtn addTarget:self action:@selector(OnZoomBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.zoomBtn setSelected:NO];
    [self.zoomBtn setBackgroundImage:[UIImage imageNamed:@"zoomout1"] forState:UIControlStateSelected];
    [self.zoomBtn setBackgroundImage:[UIImage imageNamed:@"zoomin1"] forState:UIControlStateNormal];
    [self.zoomBtn setTintColor:[UIColor clearColor]];
    [self.playerHUDBottomView addSubview:self.zoomBtn];
    //缓冲进度条
    self.loadProgressView = [[UIProgressView alloc] init];
    self.loadProgressView.frame = CGRectMake(32, 17, frameWidth-60, 14);
    self.loadProgressView.progressViewStyle = UIProgressViewStyleBar;
    self.loadProgressView.progressTintColor = RGB(181, 181, 181);
    self.loadProgressView.backgroundColor = [UIColor greenColor];
    self.loadProgressView.progress = 0;
    [self.playerHUDBottomView addSubview:self.loadProgressView];
    //播放进度条
    self.progressBar = [[UISlider alloc] init];
    self.progressBar.frame = CGRectMake(30, 11, frameWidth-60, 14);
    [self.progressBar addTarget:self action:@selector(progressBarChanged:) forControlEvents:UIControlEventValueChanged];
    [self.progressBar addTarget:self action:@selector(progressBarChangeEnded:) forControlEvents:UIControlEventTouchUpInside];
    [self.progressBar setMinimumTrackTintColor:RGB(242, 96, 0)];
    [self.progressBar setMaximumTrackTintColor:[UIColor clearColor]]; //设置成透明
    //    [self.progressBar trackRectForBounds:CGRectMake(0, 0, frameWidth-60, 5)];
    [self.progressBar setThumbTintColor:[UIColor clearColor]];
    //滑块图片
    UIImage *thumbImage = [UIImage imageNamed:@"account_cache_isplay"];
    //注意这里要加UIControlStateHightlighted的状态，否则当拖动滑块时滑块将变成原生的控件
    [self.progressBar setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [self.progressBar setThumbImage:thumbImage forState:UIControlStateNormal];
    
    [self.playerHUDBottomView addSubview:self.progressBar];
    
    //播放时间
    self.playTime = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 200, 20)];
    self.playTime.text = @"00:00:00/00:00:00";
    self.playTime.font = [UIFont systemFontOfSize:13];
    self.playTime.textAlignment = NSTextAlignmentLeft;
    self.playTime.textColor = [UIColor whiteColor];
    [self.playerHUDBottomView addSubview:self.playTime];
    
}

-(void)initPlayTime{
    NSString *currentTime = [self getStringFromCMTime:self.player.currentTime];
    NSString *totalTime = [self getStringFromCMTime:self.player.currentItem.asset.duration];
    self.playTime.text = [NSString stringWithFormat:@"%@/%@",currentTime,totalTime];
    NSLog(@"totalTime:%@",totalTime);
}

//添加计时器，显示/隐藏播放栏
-(void)startTimer{
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(initHUDViewShowing:) userInfo:nil repeats:YES];
    }
}
-(void)stopTimer{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

-(void)initHUDViewShowing:(NSTimer *)timer{
    [self showHud:viewIsShowing];
}

-(void)showHud:(BOOL)showing{
    __weak __typeof(self) weakself = self;
    if (showing) {//隐藏
        viewIsShowing = !showing;
        weakself.playerHUDBottomView.hidden = YES;
        [weakself stopTimer];
    }else{//显示
        viewIsShowing = !showing;
        weakself.playerHUDBottomView.hidden = NO;
        [weakself startTimer];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    if (UIDeviceOrientationIsLandscape(deviceOrientation)) {
        NSLog(@"横屏");
        self.isFullScreen = YES;
        [self initLandscape];
    }else{
        NSLog(@"竖屏");
        self.isFullScreen = NO;
        [self initPortraint];
    }
}
//initLandscape与initPortraint里面一样
-(void)initLandscape{
    NSLog(@"====%f",self.playerLayer.frame.size.width);
    float frameWidth = self.frame.size.width;
    float frameHeight = self.frame.size.height;
    NSLog(@"横屏:width=%f   height=%f",frameWidth,frameHeight);
    self.playerHUDBottomView.frame = CGRectMake(0, frameHeight-44, frameWidth, 44);
    self.zoomBtn.frame = CGRectMake(frameWidth-27, 10, 20, 20);
    self.progressBar.frame = CGRectMake(30, 11, frameWidth-60, 14);
    self.loadProgressView.frame = CGRectMake(32, 17, frameWidth-60, 14);
}
//
-(void)initPortraint{
    float frameWidth = self.frame.size.width;
    float frameHeight = self.frame.size.height;
    NSLog(@"竖屏:width=%f   height=%f",frameWidth,frameHeight);
    self.playerHUDBottomView.frame = CGRectMake(0, frameHeight-44, frameWidth, 44);
    self.zoomBtn.frame = CGRectMake(frameWidth-27, 10, 20, 20);
    self.progressBar.frame = CGRectMake(30, 11, frameWidth-60, 14);
    self.loadProgressView.frame = CGRectMake(32, 17, frameWidth-60, 14);
}

//监听touch事件
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point = [(UITouch *)[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(self.playerLayer.frame, point)) {
        [self showHud:viewIsShowing];
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesMoved");
}

-(void)OnPlayBtn:(UIButton *)sender{
    if (self.isPlaying) {
        [self pause];
    }else{
        [self play];
    }
}

-(void)OnZoomBtn:(UIButton *)sender{
    NSLog(@"全屏/非全屏");
    self.isFullScreen = !self.isFullScreen;
    if (self.isFullScreen) {
        [self.zoomBtn setSelected:YES];
    }else{
        [self.zoomBtn setSelected:NO];
    }
    [self.delegate playerViewZoomButtonClicked:self];
}

-(void)OnBackBtn:(UIButton *)sender{
    if (self.isFullScreen) {
        self.isFullScreen = !self.isFullScreen;
        [self.delegate playerViewZoomButtonClicked:self];
    }else{
        [self.delegate JZOnBackBtn];
    }
}

-(void)progressBarChanged:(UISlider *)sender{
    if (self.isPlaying) {
        [self.player pause];
    }
    CMTime seekTime = CMTimeMakeWithSeconds(sender.value*(double)self.player.currentItem.asset.duration.value/(double)self.player.currentItem.asset.duration.timescale, self.player.currentTime.timescale);
    [self.player seekToTime:seekTime];
}

-(void)progressBarChangeEnded:(UISlider *)sender{
    [self startTimer];
    if (self.isPlaying) {
        [self.player play];
    }
}

//添加播放进度条更新
-(void)addProgressObserver{
    __weak __typeof(self) weakself = self;
    AVPlayerItem *playerItem = self.player.currentItem;
    NSLog(@"//添加播放进度条更新");
    playbackObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time){
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds(playerItem.duration);
//        NSLog(@"当前已经播放%.2fs。",current);
        //更新进度条
        float progress = current/total;
        weakself.progressBar.value = progress;
        NSString *currentTime = [weakself getStringFromCMTime:weakself.player.currentTime];
        NSString *totalTime = [weakself getStringFromCMTime:playerItem.duration];
        weakself.playTime.text = [NSString stringWithFormat:@"%@/%@",currentTime,totalTime];
    }];
}

-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成");
}

/**
 *  给AVPlayerItem添加监控
 *
 *  @param playerItem AVPlayerItem对象
 */
-(void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //监控缓冲区大小
    [playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    
    [self performSelectorInBackground:@selector(initPlayTime) withObject:nil];
}
/**
 *  移除KVO观察
 */
-(void)removeObserverToPlayerItem:(AVPlayerItem *)playerItem{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
}

#pragma mark - 观察视频播放各个监听触发
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {//播放状态
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        switch (status) {
            case AVPlayerStatusFailed:
                NSLog(@"播放失败");
                [loadView setHidden:NO];
                break;
            case AVPlayerStatusReadyToPlay:
                NSLog(@"正在播放...视频中长度为：%f",CMTimeGetSeconds(self.playerItem.duration));
                [loadView setHidden:YES];
                break;
            default:
                NSLog(@"default:");
                break;
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]){//缓冲
        NSArray *array = self.playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        
        float durationTime = CMTimeGetSeconds([[self.player currentItem] duration]);//总时间
//        NSLog(@"共缓冲：%.2f，总时长为:%f",totalBuffer,durationTime);
        [self.loadProgressView setProgress:totalBuffer/durationTime animated:YES];
        
        if (self.playerIsBuffering && self.isPlaying) {
            [self.player play];
            self.playerIsBuffering = NO;
        }
        
    }else if ([keyPath isEqualToString:@"playbackBufferEmpty"]){
        if(self.player.currentItem.playbackBufferEmpty){
            NSLog(@"缓冲区为空");
            self.playerIsBuffering = YES;
        }else{
            NSLog(@"缓冲区不为空======");
        }
    }else{
        NSLog(@"++++++++++");
    }
}


-(NSString*)getStringFromCMTime:(CMTime)time
{
    Float64 currentSeconds = CMTimeGetSeconds(time);
    int mins = currentSeconds/60.0;
    int hours = mins / 60.0f;
    int secs = fmodf(currentSeconds, 60.0);
    mins = fmodf(mins, 60.0f);
    
    NSString *hoursString = hours < 10 ? [NSString stringWithFormat:@"0%d", hours] : [NSString stringWithFormat:@"%d", hours];
    NSString *minsString = mins < 10 ? [NSString stringWithFormat:@"0%d", mins] : [NSString stringWithFormat:@"%d", mins];
    NSString *secsString = secs < 10 ? [NSString stringWithFormat:@"0%d", secs] : [NSString stringWithFormat:@"%d", secs];
    
    
    return [NSString stringWithFormat:@"%@:%@:%@", hoursString,minsString, secsString];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
