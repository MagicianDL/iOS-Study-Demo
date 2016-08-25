//
//  UITableView+ReloadAnimation.m
//  UITableViewReloadAnimation
//
//  Created by Dalang on 16/8/23.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import "UITableView+ReloadAnimation.h"

@implementation UITableView (ReloadAnimation)

- (void)reloadDataWithDirection:(DLLoadAnimationDirectionType)direction
                       duration:(NSTimeInterval)duration
                         offset:(NSTimeInterval)offset
{
//    [self reloadData];
    [self setContentOffset:self.contentOffset animated:NO];
    [UIView animateWithDuration:0.2 animations:^{
//        self.hidden = YES;
        [self reloadData];
    } completion:^(BOOL finished) {
//        self.hidden = NO;
        [self visibleRowsAnimationWithDirection:direction duration:duration offset:offset];
    }];

}

- (void)visibleRowsAnimationWithDirection:(DLLoadAnimationDirectionType)direction
                                 duration:(NSTimeInterval)duration
                                   offset:(NSTimeInterval)offset
{
    
    NSArray *visibleCells = [self indexPathsForVisibleRows];
    NSInteger count = visibleCells.count;
    switch (direction) {
        case DLLoadAnimationDirectionTypeTop: {
            for (NSInteger i = 0; i < count; i++) {
                NSIndexPath *indexPath = visibleCells[count - 1 - i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
                cell.hidden = YES;
                CGPoint originPoint = cell.center;
                cell.center = CGPointMake(originPoint.x, originPoint.y - 1000);
                [UIView animateWithDuration:(duration + i * offset) delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    cell.center = CGPointMake(originPoint.x ,  originPoint.y + 2.0);
                    cell.hidden = NO;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        cell.center = CGPointMake(originPoint.x ,  originPoint.y - 2.0);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                            cell.center = originPoint;
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }
        }
            break;
        case DLLoadAnimationDirectionTypeBottom: {
            for (int i = 0; i < count; i++) {
                NSIndexPath *path = visibleCells[i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:path];
                cell.hidden = YES;
                CGPoint originPoint = cell.center;
                cell.center = CGPointMake(originPoint.x, originPoint.y + 1000);
                [UIView animateWithDuration:(duration + i * offset) delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    cell.center = CGPointMake(originPoint.x ,  originPoint.y - 2.0);
                    cell.hidden = NO;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        cell.center = CGPointMake(originPoint.x, originPoint.y + 2.0);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                            cell.center = originPoint;
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }
        }
            break;
        case DLLoadAnimationDirectionTypeLeft: {
            for (int i = 0; i < count; i++) {
                NSIndexPath *path = visibleCells[i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:path];
                cell.hidden = YES;
                CGPoint originPoint = cell.center;
                cell.center = CGPointMake(-cell.frame.size.width,  originPoint.y);
                [UIView animateWithDuration:(duration + i * offset) delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    cell.center = CGPointMake(originPoint.x - 2.0 ,  originPoint.y);
                    cell.hidden = NO;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        cell.center = CGPointMake(originPoint.x + 2.0, originPoint.y);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                            cell.center = originPoint;
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }
        }
            break;
        case DLLoadAnimationDirectionTypeRight: {
            for (int i = 0; i < count; i++) {
                NSIndexPath *path = visibleCells[i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:path];
                cell.hidden = YES;
                CGPoint originPoint = cell.center;
                cell.center = CGPointMake(cell.frame.size.width * 3.0,  originPoint.y);
                [UIView animateWithDuration:(duration + i * offset) delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    cell.center = CGPointMake(originPoint.x + 2.0,  originPoint.y);
                    cell.hidden = NO;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        cell.center = CGPointMake(originPoint.x - 2.0, originPoint.y);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                            cell.center = originPoint;
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }
        }
            break;
            
        default:
            break;
    }
    
}

@end
