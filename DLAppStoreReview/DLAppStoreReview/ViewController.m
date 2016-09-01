//
//  ViewController.m
//  DLAppStoreReview
//
//  Created by 张洪岩 on 16/5/19.
//  Copyright © 2016年 Dalang. All rights reserved.
//

#import "ViewController.h"
#import "DLAppStoreReview.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    DLAppStoreReview *appStoreReview = [[DLAppStoreReview alloc] init];
    appStoreReview.appID = @"1067787090";
    [appStoreReview gotoAppStore:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
