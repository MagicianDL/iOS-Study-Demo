//
//  DLLog.h
//  LogDemo
//
//  Created by SYH TECH on 16/6/6.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  输出日志的等级
 */
typedef NS_ENUM(NSInteger, DLLogLevel) {
    /**
     *  普通信息
     */
    DLLogLevelInfo = 0,
    /**
     *  警告
     */
    DLLogLevelWarning,
    /**
     *  错误
     */
    DLLogLevelError
};

#define D(format,...) NSLog(@format, ##__VA_ARGS__)
#define I(format,...) [DLLog infoLog:@format, ##__VA_ARGS__]
#define W(format,...) [DLLog warningLog:@"-WARNING-\nFile: "__FILE__"\nLine: %5d:\nMESSAGE: "format,__LINE__, ##__VA_ARGS__]
#define E(format,...) [DLLog errorLog:@"#ERROR#\nFile: "__FILE__"\nLine: %5d:\nMESSAGE: "format,__LINE__, ##__VA_ARGS__]


@interface DLLog : NSObject
/**
 *  输出普通日志
 *
 *  @param formatstring 输出格式
 */
+ (void)infoLog:(id)formatstring,...;
/**
 *  输出警告日志
 *
 *  @param formatstring 输出格式
 */
+ (void)warningLog:(id)formatstring,...;
/**
 *  输出错误日志
 *
 *  @param formatstring 输出格式
 */
+ (void)errorLog:(id)formatstring,...;



@end
