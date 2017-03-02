//
//  ViewController.m
//  SystemAudioDemo
//
//  Created by Dalang on 2016/12/28.
//  Copyright © 2016年 Dalang. All rights reserved.
//

#import "ViewController.h"

#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@end

@implementation ViewController
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - 播放系统声音并震动
- (IBAction)playSystemSoundAndShake:(id)sender {
    // 系统声音
    AudioServicesPlaySystemSound(1007);
    // 震动 只有iPhone才能震动而且还得在设置里开启震动才行,其他的如touch就没有震动功能
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

#pragma mark - 播放自定义声音
- (IBAction)playCustomSound:(id)sender {
    
    // 获取音频文件路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"in.caf" withExtension:nil];
    
    // 加载音效文件并创建 SoundID
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    
    // 设置播放完成回调
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    // 播放音效
    // 带有震动
//    AudioServicesPlayAlertSound(_soundID);
    // 无振动
    AudioServicesPlaySystemSound(soundID);
    
    // 销毁 SoundID
//    AudioServicesDisposeSystemSoundID(_soundID);
    
    
}

#pragma mark - 播放完成之后执行的函数
void soundCompleteCallback()
{
    NSLog(@"播放完成");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
