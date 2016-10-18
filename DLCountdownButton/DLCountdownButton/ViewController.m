//
//  ViewController.m
//  DLCountdownButton
//
//  Created by Dalang on 2016/10/18.
//  Copyright © 2016年 Dalang. All rights reserved.
//

#import "ViewController.h"

#import "DLCountdownButton.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet DLCountdownButton *countdownButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _countdownButton.totalSeconds = 30;
    _countdownButton.nomalBackgroundColor = [UIColor whiteColor];
    _countdownButton.disableBackgroundColor = [UIColor whiteColor];
    _countdownButton.nomalTitleColor = [UIColor blueColor];
    _countdownButton.disableTitleColor = [UIColor lightGrayColor];
    
    _countdownButton.layer.cornerRadius = 5.f;
    _countdownButton.layer.masksToBounds = YES;
    _countdownButton.layer.borderColor = [UIColor blueColor].CGColor;
    _countdownButton.layer.borderWidth = .5f;
    
    _countdownButton.title = @"获取验证码";
    
    [_countdownButton countdownProcess:^(NSInteger second) {
        _countdownButton.title = [NSString stringWithFormat:@"%lds", (long)second];
    } completion:^{
        _countdownButton.title = @"重新获取";
    }];

    
    
}

- (IBAction)countbuttonPressed:(id)sender {
    
    [_countdownButton startTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
