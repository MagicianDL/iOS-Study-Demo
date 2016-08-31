//
//  UICountingLabel.h
//  UICountingLabel
//
//  Created by Dalang on 16/8/30.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UICountingLabel;
typedef NS_ENUM(NSInteger, UILabelCountingMethod) {
    UILabelCountingMethodEaseInOut,
    UILabelCountingMethodEaseIn,
    UILabelCountingMethodEaseOut,
    UILabelCountingMethodLinear
};

typedef NSString* (^UICountingLabelFormatBlock)(CGFloat value);
typedef NSAttributedString* (^UICountingLabelAttributedFormatBlock)(CGFloat value);
typedef void(^UICountingLabelCompletionBlock)(UICountingLabel *countingLabel);
typedef void(^UICountingLabelCurrentValueBlock)(UICountingLabel *countingLabel, CGFloat currentValue);


@interface UICountingLabel : UILabel

@property (nonatomic, strong) NSString *format;
@property (nonatomic, strong) NSString *positiveFormat;//如果浮点数需要千分位分隔符,须使用@"###,##0.00"进行控制样式

@property (nonatomic, assign) UILabelCountingMethod method;
@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, copy) UICountingLabelFormatBlock formatBlock;
@property (nonatomic, copy) UICountingLabelAttributedFormatBlock attributedFormatBlock;
@property (nonatomic, copy) UICountingLabelCompletionBlock completionBlock;
@property (nonatomic, copy) UICountingLabelCurrentValueBlock currentValueBlock;

- (void)countFrom:(CGFloat)startValue to:(CGFloat)endValue;
- (void)countFrom:(CGFloat)startValue to:(CGFloat)endValue duration:(NSTimeInterval)duration;

- (void)countFromCurrentValueTo:(CGFloat)endValue;
- (void)countFromCurrentValueTo:(CGFloat)endValue duration:(NSTimeInterval)duration;

- (void)countFromZeroTo:(CGFloat)endValue;
- (void)countFromZeroTo:(CGFloat)endValue duration:(NSTimeInterval)duration;

- (CGFloat)currentValue;


@end
