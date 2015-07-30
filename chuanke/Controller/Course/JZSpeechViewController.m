//
//  JZSpeechViewController.m
//  chuanke
//
//  Created by jinzelu on 15/7/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZSpeechViewController.h"


//包含头文件
//文字转语音
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"

//语音转文字
#import "iflyMSC/IFlySpeechRecognizer.h"
#import "iflyMSC/IFlySpeechRecognizerDelegate.h"

#import "ISRDataHelper.h"


@interface JZSpeechViewController ()<IFlySpeechSynthesizerDelegate,IFlySpeechRecognizerDelegate>
{
    IFlySpeechSynthesizer * _iFlySpeechSynthesizer;
    //不带界面的识别对象
    IFlySpeechRecognizer *_iFlySpeechRecognizer;
    
    UILabel *_textLabel;
    NSString *_resultStr;
}
@end

@implementation JZSpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    [self initIFly];
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initViews{
    UIButton *beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    beginBtn.frame = CGRectMake(10, 100, 80, 40);
    [beginBtn addTarget:self action:@selector(OnBeginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [beginBtn setTitle:@"开始录音" forState:UIControlStateNormal];
    [beginBtn setTitleColor:navigationBarColor forState:UIControlStateNormal];
    [self.view addSubview:beginBtn];
    
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    endBtn.frame = CGRectMake(100, 100, 80, 40);
    [endBtn addTarget:self action:@selector(OnEndBtn:) forControlEvents:UIControlEventTouchUpInside];
    [endBtn setTitle:@"结束录音" forState:UIControlStateNormal];
    [endBtn setTitleColor:navigationBarColor forState:UIControlStateNormal];
    [self.view addSubview:endBtn];
    
    //
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, screen_width-10, 100)];
    _textLabel.numberOfLines = 0;
    _textLabel.text = @"";
    _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _textLabel.textColor = navigationBarColor;
    [self.view addSubview:_textLabel];
    
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


//
-(void)OnTapBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)OnTapCollectBtn:(UIButton *)sender{
    [self speechRecognize];
}
-(void)OnBeginBtn:(UIButton *)sender{
//    [iFlySpeechRecognizer startListening];
    _textLabel.text = @"";
    
    [self speechRecognize];
}
-(void)OnEndBtn:(UIButton *)sender{
    [_iFlySpeechRecognizer stopListening];
}


//文字转语音
-(void)initIFly{
    //1.创建合成对象
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    _iFlySpeechSynthesizer.delegate = self;
    //2.设置合成参数
    //设置在线工作方式
    [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                  forKey:[IFlySpeechConstant ENGINE_TYPE]];
    //音量,取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]]; //发音人,默认为”xiaoyan”,可以设置的参数列表可参考“合成发音人列表”
    [_iFlySpeechSynthesizer setParameter:@"xiaoxin" forKey: [IFlySpeechConstant VOICE_NAME]]; //保存合成文件名,如不再需要,设置设置为nil或者为空表示取消,默认目录位于 library/cache下
    [_iFlySpeechSynthesizer setParameter:@"tts.pcm" forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    //3.启动合成会话
//    [_iFlySpeechSynthesizer startSpeaking: @"喜欢你，那双眼动人，笑声更迷人，愿再可，轻抚你。你好,我是科大讯飞的小燕"];
    [_iFlySpeechSynthesizer startSpeaking: @"我只是个小孩,干吗那么认真啊。不对,动感超人是这样笑的，5呼呼呼呼~~~~~~。"];
}
//听写
-(void)speechRecognize{
    //1.创建语音听写对象
    _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance]; //设置听写模式
    _iFlySpeechRecognizer.delegate = self;
    [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    //2.设置听写参数
    [_iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
    //asr_audio_path是录音文件名,设置value为nil或者为空取消保存,默认保存目录在 Library/cache下。
    [_iFlySpeechRecognizer setParameter:@"asrview.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    //3.启动识别服务
    [_iFlySpeechRecognizer startListening];//官网文档里有错误，不是start
}

#pragma mark - IFlySpeechSynthesizerDelegate
//结束代理
-(void)onCompleted:(IFlySpeechError *)error{
    NSLog(@"onCompleted");
}
//合成开始
- (void) onSpeakBegin{
    NSLog(@"onSpeakBegin");
}
//合成缓冲进度
- (void) onBufferProgress:(int) progress message:(NSString *)msg{
    NSLog(@"onBufferProgress");
}
//合成播放进度
- (void) onSpeakProgress:(int) progress{
//    NSLog(@"onSpeakProgress");
}


#pragma mark - IFlySpeechRecognizerDelegate
//识别结果返回代理
-(void)onResults:(NSArray *)results isLast:(BOOL)isLast{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [results objectAtIndex:0];
    for (NSString *key in dic)
    {
        [result appendFormat:@"%@",key];//合并结果
    }
    NSLog(@"识别成功:%@",result);
    _resultStr = [NSString stringWithFormat:@"%@%@",_textLabel.text,result];
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:result];
    _textLabel.text = [NSString stringWithFormat:@"%@%@", _textLabel.text,resultFromJson];
}

-(void)onError:(IFlySpeechError *)errorCode{
    NSLog(@"识别失败");
}

-(void)onEndOfSpeech{
    NSLog(@"停止录音");
}

-(void)onBeginOfSpeech{
    NSLog(@"开始录音");
}

-(void)onVolumeChanged:(int)volume{
//    NSLog(@"音量");
}






-(void)viewWillDisappear:(BOOL)animated{
    [_iFlySpeechSynthesizer stopSpeaking];
    [_iFlySpeechRecognizer stopListening];
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
