//
//  DLCommons.h
//  UITableViewReloadAnimation
//
//  Created by Dalang on 16/8/23.
//  Copyright © 2016年 SYH. All rights reserved.
//

#ifndef DLCommons_h
#define DLCommons_h

#import <UIKit/UIKit.h>

/**
 *  加载类型
 */
typedef NS_ENUM(NSInteger, DLLoadAnimationDirectionType) {
    /**
     *  自上而下
     */
   DLLoadAnimationDirectionTypeTop = 0,
    /**
     *  自下而上
     */
    DLLoadAnimationDirectionTypeBottom,
    /**
     *  自左而右
     */
    DLLoadAnimationDirectionTypeLeft,
    /**
     *  自右而左
     */
    DLLoadAnimationDirectionTypeRight
};



#endif /* DLCommons_h */
