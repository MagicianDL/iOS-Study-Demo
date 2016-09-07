//
//  UIImageView+DLLoader.m
//  DLCircleImageLoader
//
//  Created by Dalang on 16/9/5.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import "UIImageView+DLLoader.h"
#import "objc/runtime.h"
#import "DLCircularLoaderView.h"

@implementation UIImageView (DLLoader)

- (DLCircularLoaderView *)dl_circularLoaderView
{
    DLCircularLoaderView *loaderView = objc_getAssociatedObject(self, @selector(dl_circularLoaderView));
    if (!loaderView) {
        loaderView = [DLCircularLoaderView new];
        loaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        objc_setAssociatedObject(self, @selector(dl_circularLoaderView), loaderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return loaderView;
}

- (void)updateImageDownloadProgress:(CGFloat)progress
{
    self.dl_circularLoaderView.progress = progress;
}

- (void)startLoader
{
    DLCircularLoaderView *loaderView = self.dl_circularLoaderView;
    loaderView.frame = self.bounds;
    [self addSubview:loaderView];
    loaderView.progress = 0;
}

- (void)startLoaderWithTintColor:(UIColor *)color
{
    [self startLoader];
    self.dl_circularLoaderView.tintColor = color;
}

- (void)reveal
{
    [self.dl_circularLoaderView reveal];
}


@end
