//
//  ViewController.m
//  UICountingLabel
//
//  Created by Dalang on 16/8/30.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import "ViewController.h"
#import "UICountingLabel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICountingLabel *countLabel;
@property (weak, nonatomic) IBOutlet UICountingLabel *countLabel1;
@property (weak, nonatomic) IBOutlet UICountingLabel *countLabel2;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIFont *font = [UIFont fontWithName:@"Avenir Next" size:48];
    UIColor *textColor = [UIColor colorWithRed:236/255.0 green:66/255.0 blue:43/255.0 alpha:1];
    
    _countLabel.font = font;
    _countLabel.textColor = textColor;
    _countLabel.format = @"%d";
    
    _countLabel1.font = font;
    _countLabel1.textColor = textColor;
    _countLabel1.format = @"%.2f";
    
    _countLabel2.font = font;
    _countLabel2.textColor = textColor;
    _countLabel2.format = @"%.2f";
    _countLabel2.positiveFormat = @"###,##0.00";
    
}


- (IBAction)start:(id)sender {
    [_countLabel countFrom:0 to:100 duration:2.0f];
    [_countLabel1 countFrom:0.0 to:3198.23 duration:2.0f];
    [_countLabel2 countFrom:0.00 to:3048.64 duration:2.0f];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
