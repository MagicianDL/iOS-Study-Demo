//
//  DLLog.m
//  LogDemo
//
//  Created by SYH TECH on 16/6/6.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import "DLLog.h"

@implementation DLLog

// MARK: 输出普通日志
+ (void)infoLog:(id)formatstring,...
{
    va_list argList;
    if (!formatstring) {
        return;
    }
    va_start(argList, formatstring);
    NSString *log = [[NSString alloc] initWithFormat:formatstring arguments:argList];
    NSLog(@"%@", log);
}
// MARK: 输出警告日志
+ (void)warningLog:(id)formatstring,...
{
    va_list argList;
    if (!formatstring) {
        return;
    }
    va_start(argList, formatstring);
    NSString *log = [[NSString alloc] initWithFormat:formatstring arguments:argList];
    NSLog(@"**%@", log);
}
// MARK: 输出错误日志
+ (void)errorLog:(id)formatstring,...
{
    va_list argList;
    if (!formatstring) {
        return;
    }
    va_start(argList, formatstring);
    NSString *log = [[NSString alloc] initWithFormat:formatstring arguments:argList];
    NSLog(@"##%@", log);
}


@end
