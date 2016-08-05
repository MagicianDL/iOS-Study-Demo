//
//  ViewController.m
//  DLShineLabel
//
//  Created by Dalang on 16/8/5.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import "ViewController.h"
#import "DLShineLabel.h"

@interface ViewController ()

@property (nonatomic, strong) DLShineLabel *shineLabel;
@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, assign) NSUInteger textIndex;
@property (nonatomic, strong) UIImageView *wallpaper1;
@property (nonatomic, strong) UIImageView *wallpaper2;

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _textArray = @[
                       @"For something this complicated, it’s really hard to design products by focus groups. A lot of times, people don’t know what they want until you show it to them.",
                       @"我了个大草~~~~~~",
                       @"We’re just enthusiastic about what we do.",
                       @"窗前明月光，\n疑是地上霜。\n举头望明月，\n低头思故乡。",
                       @"We made the buttons on the screen look so good you’ll want to lick them.",
                       @"我们是共产主义接班人。"
                       ];
        _textIndex  = 0;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    self.wallpaper1 = ({
        UIImageView *imageView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = bounds;
        imageView;
    });
    [self.view addSubview:self.wallpaper1];
    
    self.wallpaper2 = ({
        UIImageView *imageView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.jpg"]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = bounds;
        imageView.alpha = 0;
        imageView;
    });
    [self.view addSubview:self.wallpaper2];
    
    self.shineLabel = ({
        DLShineLabel *label = [[DLShineLabel alloc] initWithFrame:CGRectMake(16, 16, CGRectGetWidth(bounds) - 32, CGRectGetHeight(bounds) - 16)];
        label.numberOfLines = 0;
        label.text = [self.textArray objectAtIndex:self.textIndex];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0];
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        label.center = self.view.center;
        label;
    });
    [self.view addSubview:self.shineLabel];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.shineLabel shine];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (self.shineLabel.isVisible) {
        [self.shineLabel fadeOutWithCompletion:^{
            [self changeText];
            [UIView animateWithDuration:2.5 animations:^{
                if (self.wallpaper1.alpha > 0.1) {
                    self.wallpaper1.alpha = 0;
                    self.wallpaper2.alpha = 1;
                }
                else {
                    self.wallpaper1.alpha = 1;
                    self.wallpaper2.alpha = 0;
                }
            }];
            [self.shineLabel shine];
        }];
    }
    else {
        [self.shineLabel shine];
    }
}

- (void)changeText
{
    self.shineLabel.text = self.textArray[(++self.textIndex) % self.textArray.count];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
