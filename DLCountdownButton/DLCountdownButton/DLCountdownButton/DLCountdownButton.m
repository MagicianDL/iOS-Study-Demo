//
//  DLCountdownButton.m
//  DLCountdownButton
//
//  Created by Dalang on 2016/10/18.
//  Copyright © 2016年 Dalang. All rights reserved.
//

#import "DLCountdownButton.h"

@interface DLCountdownButton ()

@property (nonatomic, assign) NSInteger second;

@property (nonatomic, copy) void(^processBlock)(NSUInteger second);

@property (nonatomic, copy) void(^completionBlock)();

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DLCountdownButton

+ (instancetype)countdownButton
{
    DLCountdownButton *button = [self buttonWithType:UIButtonTypeCustom];
    
    button.nomalBackgroundColor = [UIColor whiteColor];
    button.nomalTitleColor = [UIColor blackColor];
    button.disableBackgroundColor = [UIColor whiteColor];
    button.disableTitleColor = [UIColor lightGrayColor];
    
    [button setBackgroundColor:button.nomalBackgroundColor];
    [button setTitleColor:button.nomalTitleColor forState:UIControlStateNormal];
    
    return button;
}

- (void)countdownProcess:(void (^)(NSInteger second))process completion:(void (^)())completion
{
    self.processBlock = [process copy];
    self.completionBlock = [completion copy];
}

- (void)startTimer
{
    self.second = self.totalSeconds;
    
    self.userInteractionEnabled = NO;
    
    self.backgroundColor = self.disableBackgroundColor;
    
    [self setTitleColor:self.disableTitleColor forState:UIControlStateNormal];
    
    self.processBlock ? self.processBlock(self.second) : nil;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(fireTimer) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)stopTimer
{
    if (self.timer) {
        if ([self.timer respondsToSelector:@selector(isValid)]){
            if ([self.timer isValid]){
                [self.timer invalidate];
                self.second = self.totalSeconds;
                self.userInteractionEnabled = YES;
                self.backgroundColor = self.nomalBackgroundColor;
                [self setTitleColor:self.nomalTitleColor forState:UIControlStateNormal];
            }
        }
    }
    
}

#pragma mark - Private

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.nomalBackgroundColor = [UIColor whiteColor];
    self.nomalTitleColor = [UIColor blackColor];
    self.disableBackgroundColor = [UIColor whiteColor];
    self.disableTitleColor = [UIColor lightGrayColor];
    
    [self setBackgroundColor:self.nomalBackgroundColor];
    [self setTitleColor:self.nomalTitleColor forState:UIControlStateNormal];
}


- (void)fireTimer
{
    self.second --;
    
    self.processBlock ? self.processBlock(self.second) : nil;
    if (self.second <= 0) {
        [self stopTimer];
        self.completionBlock ? self.completionBlock() : nil;
    }
    
}

#pragma mark - Setters

- (void)setTotalSeconds:(NSInteger)totalSeconds
{
    _totalSeconds = totalSeconds;
}

- (void)setNomalBackgroundColor:(UIColor *)nomalBackgroundColor
{
    _nomalBackgroundColor = nomalBackgroundColor;
    [self setBackgroundColor:nomalBackgroundColor];
}

- (void)setNomalTitleColor:(UIColor *)nomalTitleColor
{
    _nomalTitleColor = nomalTitleColor;
    [self setTitleColor:nomalTitleColor forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self.titleLabel setFont:font];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
