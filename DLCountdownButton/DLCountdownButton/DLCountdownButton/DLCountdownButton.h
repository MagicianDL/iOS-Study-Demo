//
//  DLCountdownButton.h
//  DLCountdownButton
//
//  Created by Dalang on 2016/10/18.
//  Copyright © 2016年 Dalang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLCountdownButton : UIButton

@property (nonatomic, assign) NSInteger totalSeconds;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *nomalBackgroundColor;

@property (nonatomic, strong) UIColor *nomalTitleColor;

@property (nonatomic, strong) UIColor *disableBackgroundColor;

@property (nonatomic, strong) UIColor *disableTitleColor;

@property (nonatomic, strong) UIFont *font;

+ (instancetype)countdownButton;

- (void)countdownProcess:(void (^)(NSInteger second))process completion:(void (^)())completion;

- (void)startTimer;

- (void)stopTimer;

@end
