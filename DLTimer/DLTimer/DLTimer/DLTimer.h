//
//  DLTimer.h
//  DLTimer
//
//  Created by Dalang on 16/8/11.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 *  DLTimer与NSTimer相似，但是不会引起target的retain。DLTimer使用GCD实现，你可以在随意的队列中执行或不执行它。
 */
@interface DLTimer : NSObject
/**
 *  在定时器开始时间之后设置一个允许的延时时间段，定时器可以在指定的时间内开始计时
 */
@property (atomic, assign) NSTimeInterval tolerance;

/**
 *  用指定参数创建一个定时器，然后调用schedule来开始计时。返回的对象和target对于retain来说是安全的
 *
 *  @param timeInterval  target频繁调用selector的时间肩而过。如果定时器不会重复，它只会被调用一次，在你调用这个方法之后大约timeInterval秒执行selector
 *  @param target        调用方法者
 *  @param selector      执行方法
 *  @param userInfo      用户自定义信息
 *  @param repeats       如果为YES,selector将会被target调用，知道DLTimer对象被释放或调用invalidate方法。如果为NO，它只会被调用一次。
 *  @param dispatchQueue selector被分发的队列。它可以是串行或并行的队列。
 *
 *  @return DLTimer对象
 */
- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval
                              target:(id)target
                            selector:(SEL)selector
                            userInfo:(id)userInfo
                             repeats:(BOOL)repeats
                       dispatchQueue:(dispatch_queue_t)dispatchQueue;
/**
 *  创建一个DLTimer对象并且立即开始计时
 */
+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                        target:(id)target
                                      selector:(SEL)selector
                                      userInfo:(id)userInfo
                                       repeats:(BOOL)repeats
                                 dispatchQueue:(dispatch_queue_t)dispatchQueue;

/**
 *  如果定期器没有开始，通过调用schedule开始定时器。如果定时器已经计时开始再调用它，结果是未被定义的行为
 */
- (void)schedule;
/**
 *  造成定期器在执行方法的队列中被同步执行一次。你可以使用这个方法在不打断其正常执行过程的情况下执行一次方法。如果定repeats为NO，它会在执行之后自动‘incalidate’，即使他的执行时间还没到。
 */
- (void)fire;
/**
 *  停止执行重复执行的定时器
 */
- (void)invalidate;
/**
 *  返回用户自定义信息
 */
- (id)userInfo;

@end
