//
//  DLShineLabel.h
//  DLShineLabel
//
//  Created by Dalang on 16/8/5.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLShineLabel : UILabel
/**
 *  淡入动画持续时间， 默认2.5秒
 */
@property (nonatomic, assign, readwrite) CFTimeInterval shineDuration;
/**
 *  淡出动画持续时间， 默认2.5秒
 */
@property (nonatomic, assign, readwrite) CFTimeInterval fadeoutDuration;
/**
 *  自动开始动画，默认NO
 */
@property (nonatomic, assign, readwrite, getter = isAutoStart) BOOL autoStart;
/**
 *  检查动画是否结束
 */
@property (nonatomic, assign, readonly, getter = isShining) BOOL shining;
/**
 *  检查是否可见
 */
@property (nonatomic, assign, readonly, getter = isVisible) BOOL visible;


/**
 *  开始动画
 */
- (void)shine;
- (void)shineWithCompletion:(void (^)())completion;
/**
 *  结束动画
 */
- (void)fadeOut;
- (void)fadeOutWithCompletion:(void (^)())completion;


@end
