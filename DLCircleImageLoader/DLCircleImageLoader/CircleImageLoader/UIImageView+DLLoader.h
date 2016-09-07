//
//  UIImageView+DLLoader.h
//  DLCircleImageLoader
//
//  Created by Dalang on 16/9/5.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DLLoader)

- (void)updateImageDownloadProgress:(CGFloat)progress;

- (void)startLoader;

- (void)startLoaderWithTintColor:(UIColor *)color;

- (void)reveal;


@end
