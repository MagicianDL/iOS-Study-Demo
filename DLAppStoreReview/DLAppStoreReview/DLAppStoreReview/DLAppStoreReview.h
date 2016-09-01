//
//  DLAppStoreReview.h
//  DLAppStoreReview
//
//  Created by 张洪岩 on 16/5/19.
//  Copyright © 2016年 Dalang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DLAppStoreReview : NSObject

@property (nonatomic, strong) NSString *appID; // APPID

- (void)gotoAppStore:(UIViewController *)vc;

@end
