//
//  UITableView+ReloadAnimation.h
//  UITableViewReloadAnimation
//
//  Created by Dalang on 16/8/23.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableView (ReloadAnimation)

/**
 *  UITableView 加载动画
 *
 *  @param direction 动画类型
 *  @param duration  动画持续时间
 *  @param offset    每个cell之间的时间间隔
 */
- (void)reloadDataWithDirection:(DLLoadAnimationDirectionType)direction
                       duration:(NSTimeInterval)duration
                         offset:(NSTimeInterval)offset;


@end
