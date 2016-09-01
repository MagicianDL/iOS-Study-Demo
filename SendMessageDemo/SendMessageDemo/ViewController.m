//
//  ViewController.m
//  SendMessageDemo
//
//  Created by Dalang on 16/6/5.
//  Copyright © 2016年 Dalang. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>


@interface ViewController ()<MFMessageComposeViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)sendMessageButtonClick:(id)sender {
    
    //方法一 应用内直接发送短信
    BOOL canSendMessage = [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://13964273305"]];
    if (!canSendMessage) {
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"该设备不支持短信功能" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertViewController addAction:action];
        [self presentViewController:alertViewController animated:YES completion:^{
            
        }];
    }
    
    // 方法二 调用系统功能
//    [self showMessageView:[NSArray arrayWithObjects:@"13964273305",@"13964273306", nil] title:@"test" body:@"土豪，我们做朋友吧！"];
    
}
// MARK: 调用系统短信
-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"该设备不支持短信功能" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertViewController addAction:action];
        [self presentViewController:alertViewController animated:YES completion:^{
            
        }];
    }
}

// MARK:  MFMessageComposeViewControllerDelegate
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
