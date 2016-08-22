//
//  ViewController.m
//  TouchID
//
//  Created by Dalang on 16/8/22.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)touchIDAuthentication:(id)sender {
    
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"通过Home键验证已有手机指纹" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"success!");
            } else {
                switch (error.code) {
                    case LAErrorAuthenticationFailed:
                        [self showTouchIDAuthenticationrResult:@"指纹校验失败"];
                        break;
                    case LAErrorUserCancel:
                        [self showTouchIDAuthenticationrResult:@"用户取消验证"];
                        break;
                    case LAErrorUserFallback:
                        [self showTouchIDAuthenticationrResult:@"用户回退"];
                        break;
                    case LAErrorSystemCancel:
                        [self showTouchIDAuthenticationrResult:@"系统取消验证"];
                        break;
                        
                    default:
                        break;
                }
            }
        }];
        
    } else {
        switch (error.code) {
            case LAErrorPasscodeNotSet:
                [self showTouchIDAuthenticationrResult:@"未设置密码"];
                break;
            case LAErrorTouchIDNotAvailable:
                [self showTouchIDAuthenticationrResult:@"指纹错误"];
                break;
            case LAErrorTouchIDNotEnrolled:
                [self showTouchIDAuthenticationrResult:@"尚未录入指纹"];
                break;
            case LAErrorTouchIDLockout:
                [self showTouchIDAuthenticationrResult:@"TouchID被锁定"];
                break;
            case LAErrorAppCancel:
                [self showTouchIDAuthenticationrResult:@"App取消验证"];
                break;
            case LAErrorInvalidContext:
                [self showTouchIDAuthenticationrResult:@"context无效"];
                break;
                
            default:
                break;
        }
    }
    
}

- (void)showTouchIDAuthenticationrResult:(NSString *)result
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:result preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
