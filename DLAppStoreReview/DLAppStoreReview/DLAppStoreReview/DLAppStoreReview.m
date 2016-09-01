//
//  DLAppStoreReview.m
//  DLAppStoreReview
//
//  Created by 张洪岩 on 16/5/19.
//  Copyright © 2016年 Dalang. All rights reserved.
//

#import "DLAppStoreReview.h"

@implementation DLAppStoreReview
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
    UIAlertView *_alertView;
#else
    UIAlertController *_alertViewController;
#endif
}


- (void)gotoAppStore:(UIViewController *)vc
{
    // 当前软件的版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    float appVersion = [[infoDictionary objectForKey:@"CFBundleShortVersionString"] floatValue];
    // userDefaults里保存的天数
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int udTheDays = [[userDefaults objectForKey:@"theDays"] intValue];
    // userDefaults里保存的版本号
    float udAppVersion = [[userDefaults objectForKey:@"appVersion"] floatValue];
    // userDefaults里保存的上一次用户的选项
    int udUserChoose = [[userDefaults objectForKey:@"userOptChoose"] intValue];
    // 时间戳的天数
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    int daySeconds = 24 * 60 * 60;
    NSUInteger theDays = interval / daySeconds;
    
    // 版本升级之后的处理，全部规则清空，开始弹窗
    if (udAppVersion && appVersion > udAppVersion) {
        [userDefaults removeObjectForKey:@"theDays"];
        [userDefaults removeObjectForKey:@"appVersion"];
        [userDefaults removeObjectForKey:@"userOptChoose"];
        [self alertUserCommentView:vc];
    }
    //1,从来没弹出过的
    //2,用户选择😓我要吐槽，7天之后再弹出
    //3,用户选择😭残忍拒绝后，7天内，每过1天会弹一次
    //4,用户选择😭残忍拒绝的30天后，才会弹出
    else if (!udUserChoose || (udUserChoose == 2 && theDays - udTheDays > 7) || (udUserChoose >= 3 && theDays - udTheDays <= 7 && theDays -udTheDays>udUserChoose-3) || (udUserChoose >= 3 && theDays - udTheDays > 30)) {
        [self alertUserCommentView:vc];
    }
    
    
}

- (void)alertUserCommentView:(UIViewController *)vc
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        // 当前时间戳的天数
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        int daySeconds = 24 * 60 * 60;
        NSUInteger theDays = interval / daySeconds;
        // 当前软件的版本号
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        float appVersion = [[infoDictionary objectForKey:@"CFBundleShortVersionString"] floatValue];
        // userDefaults里保存的版本号
        float udAppVersion = [[userDefaults objectForKey:@"appVersion"] floatValue];
        // userDefaults里保存的上一次用户的选项
        int udUserChoose = [[userDefaults objectForKey:@"userOptChoose"] intValue];
        // userDefaults里保存的天数
        int udTheDays = [[userDefaults objectForKey:@"theDays"] intValue];
        if (appVersion > udAppVersion) {
            [userDefaults setObject:[NSString stringWithFormat:@"%f", appVersion] forKey:@"appVersion"];
        }
        
        _alertViewController = [UIAlertController alertControllerWithTitle:@"致开发者的一封信" message:@"有了您的支持才能更好的为您服务，提供更加优质的，更加适合您的App，当然您也可以直接反馈问题给到我们" preferredStyle:UIAlertControllerStyleAlert];
        // 拒绝
        UIAlertAction *refuseAction = [UIAlertAction actionWithTitle:@"😭残忍拒绝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [userDefaults setObject:@"1" forKey:@"userOptChoose"];
            [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)theDays] forKey:@"theDays"];

        }];
        // 好评
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"😄好评赞赏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [userDefaults setObject:@"2" forKey:@"userOptChoose"];
            [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)theDays] forKey:@"theDays"];
            
            NSString *str = [NSString stringWithFormat:
                             @"https://itunes.apple.com/cn/app/id%@?mt=8",
                             _appID];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }];
        // 吐槽
        UIAlertAction *showAction = [UIAlertAction actionWithTitle:@"😓我要吐槽" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
            if (udUserChoose<=3 || theDays-[[userDefaults objectForKey:@"theDays"] intValue]>30) {
                [userDefaults setObject:@"3" forKey:@"userOptChoose"];
                [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)theDays] forKey:@"theDays"];
            }else{
                [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)(theDays - udTheDays+3)] forKey:@"userOptChoose"];
            }
            NSString *str = [NSString stringWithFormat:
                             @"https://itunes.apple.com/cn/app/id%@?mt=8",
                             _appID];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }];
        
        [_alertViewController addAction:refuseAction];
        [_alertViewController addAction:okAction];
        [_alertViewController addAction:showAction];
        [vc presentViewController:_alertViewController animated:YES completion:^{
            
        }];
    } else {
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
        alertViewTest = [[UIAlertView alloc] initWithTitle:@"致开发者的一封信" message:@"有了您的支持才能更好的为您服务，提供更加优质的，更加适合您的App，当然您也可以直接反馈问题给到我们" delegate:self cancelButtonTitle:@"😭残忍拒绝" otherButtonTitles:@"😄好评赞赏",@"😓我要吐槽", nil];
        [alertViewTest show];
#endif
    }
    
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0

-  (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //当前时间戳的天数
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    int daySeconds = 24 * 60 * 60;
    NSInteger theDays = interval / daySeconds;
    //当前版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    float appVersion = [[infoDictionary objectForKey:@"CFBundleShortVersionString"] floatValue];
    //userDefaults里版本号
    float udAppVersion = [[userDefaults objectForKey:@"appVersion"] intValue];
    //userDefaults里用户选择项目
    int udUserChoose = [[userDefaults objectForKey:@"userOptChoose"] intValue];
    //userDefaults里用户天数
    int udtheDays = [[userDefaults objectForKey:@"theDays"] intValue];
    
    //当前版本比userDefaults里版本号高
    if (appVersion>udAppVersion) {
        [userDefaults setObject:[NSString stringWithFormat:@"%f",appVersion] forKey:@"appVersion"];
    }
    
    switch (buttonIndex) {
        case 0: //残忍的拒绝
            if (udUserChoose<=3 || theDays-[[userDefaults objectForKey:@"theDays"] intValue]>30) {
                [userDefaults setObject:@"3" forKey:@"userOptChoose"];
                [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)theDays] forKey:@"theDays"];
            }else{
                [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)(theDays-udtheDays+3)] forKey:@"userOptChoose"];
            }
            break;
        case 1:{ //好评
            [userDefaults setObject:@"1" forKey:@"userOptChoose"];
            [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)theDays] forKey:@"theDays"];
            NSString *str = [NSString stringWithFormat:
                             @"https://itunes.apple.com/cn/app/id%@?mt=8",
                             self.myAppID ];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
        case 2:{ //不好用，我要提意见
            [userDefaults setObject:@"2" forKey:@"userOptChoose"];
            [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)theDays] forKey:@"theDays"];
            NSString *str = [NSString stringWithFormat:
                             @"https://itunes.apple.com/cn/app/id%@?mt=8",
                             self.myAppID ];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
            
        default:
            break;
    }
    
}

#endif



@end
