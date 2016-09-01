//
//  DLLog.m
//  LogDemo
//
//  Created by SYH on 16/6/3.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import "DLLog.h"

#ifndef GCDExecOnce
#define GCDExecOnce(block) \
{ \
static dispatch_once_t predicate = 0; \
dispatch_once(&predicate, block); \
}
#endif

#define DEFAULT_DATEFORMAT @"YYYY-MM-dd HH:mm:ss.SSS"
static NSDateFormatter* _dateFormatter = nil;

void Log(DLLogLevel level, const char *file, int line, const char *function, NSString *format,...)
{
    if (level < DLLogLevelInfo || level > DLLogLevelError) {
        return;
    }
    // 获取时间格式
    GCDExecOnce(^{
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [_dateFormatter setDateFormat:DEFAULT_DATEFORMAT];
    });
    // 获取当前时间戳
    const char *nowCString = [[_dateFormatter stringFromDate:[NSDate date]] cStringUsingEncoding:NSUTF8StringEncoding];
    // 处理format
    va_list ap;
    va_start (ap, format);
    if (![format hasSuffix: @"\n"]) {
        format = [format stringByAppendingString: @"\n"];
    }
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end (ap);
    // 获取一些参数
    NSString *fileName = [[NSString stringWithUTF8String:file] lastPathComponent];
    NSString *functionName = [NSString stringWithUTF8String:function];
    NSString *logType = nil;
    switch (level) {
        case DLLogLevelInfo:
            logType = @"Info";
            break;
        case DLLogLevelWarning:
            logType = @"Warning";
        case DLLogLevelError:
            logType = @"Error";
            
        default:
            break;
    }
    // 打印
    fprintf(stderr, "%s [%s]:\n [FILE]: %s\n [FUNCTION]: %s\n [LINE]: %d\n [MESSAGE]: %s", nowCString, [logType UTF8String], [fileName UTF8String], [functionName UTF8String], line, [body UTF8String]);
}
