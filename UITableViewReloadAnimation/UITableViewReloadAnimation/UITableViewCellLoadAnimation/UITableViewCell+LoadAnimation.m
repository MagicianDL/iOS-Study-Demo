//
//  UITableViewCell+LoadAnimation.m
//  UITableViewReloadAnimation
//
//  Created by Dalang on 16/8/23.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import "UITableViewCell+LoadAnimation.h"

@implementation UITableViewCell (LoadAnimation)

- (void)displayWithDirection:(DLLoadAnimationDirectionType)direction
                    duration:(NSTimeInterval)duration
                       delay:(NSTimeInterval)delay
               springDamping:(CGFloat)dampingRatio
              springVelocity:(CGFloat)velocity
{
    UIView *cellContentView = self.contentView;
    CGFloat rotationAngleDegrees = -30;
    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, rotationAngleRadians, -50.0, 0.0, 1.0);
    
    switch (direction) {
        case DLLoadAnimationDirectionTypeTop: {
            CGPoint offsetPositioning = CGPointMake(0, -cellContentView.frame.size.height * 4);
            transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, -50.0);
            cellContentView.layer.transform = transform;
            cellContentView.layer.opacity = 0.8;
            [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:dampingRatio initialSpringVelocity:velocity options:0 animations:^{
                cellContentView.layer.transform = CATransform3DIdentity;
                cellContentView.layer.opacity = 1;
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case DLLoadAnimationDirectionTypeBottom: {
            CGPoint offsetPositioning = CGPointMake(0, cellContentView.frame.size.height * 4);
            transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, -50.0);
            cellContentView.layer.transform = transform;
            cellContentView.layer.opacity = 0.8;
            [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:dampingRatio initialSpringVelocity:velocity options:0 animations:^{
                cellContentView.layer.transform = CATransform3DIdentity;
                cellContentView.layer.opacity = 1;
            } completion:^(BOOL finished) {
            
            }];
            
        }
            break;
        case DLLoadAnimationDirectionTypeLeft: {
            CGPoint offsetPositioning = CGPointMake(-600, -20.0);
            transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, -50.0);
            cellContentView.layer.transform = transform;
            cellContentView.layer.opacity = 0.8;
            
            [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:dampingRatio initialSpringVelocity:velocity options:0 animations:^{
                cellContentView.layer.transform = CATransform3DIdentity;
                cellContentView.layer.opacity = 1;
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case DLLoadAnimationDirectionTypeRight: {
            CGPoint offsetPositioning = CGPointMake(600, -20.0);
            transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, -50.0);
            cellContentView.layer.transform = transform;
            cellContentView.layer.opacity = 0.8;
            
            [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:dampingRatio initialSpringVelocity:velocity options:0 animations:^{
                cellContentView.layer.transform = CATransform3DIdentity;
                cellContentView.layer.opacity = 1;
            } completion:^(BOOL finished) {
            
            }];

        }
            break;
            
        default:
            break;
    }
    
}


@end
