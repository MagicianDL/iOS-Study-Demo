//
//  UITableViewCell+LoadAnimation.h
//  UITableViewReloadAnimation
//
//  Created by Dalang on 16/8/23.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (LoadAnimation)

- (void)displayWithDirection:(DLLoadAnimationDirectionType)direction
                    duration:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
               springDamping:(CGFloat)dampingRatio
              springVelocity:(CGFloat)velocity;


@end
