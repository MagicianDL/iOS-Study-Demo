//
//  DLLog.h
//  LogDemo
//
//  Created by SYH on 16/6/3.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DLLogLevel) {
    DLLogLevelInfo = 0, // 普通信息
    DLLogLevelWarning, // 警告
    DLLogLevelError // 错误
};


#define ON   1
#define OFF  0

///////////////   CONFIG   /////////////////

#define NO_LOG          OFF   // 禁用Log
#define SWITCH_LOG      OFF   // 切换打印

#define TIME_STAMP      OFF   // 时间戳
#define FILE_NAME       ON    // 文件名

////////////////////////////////////////////

//#if SWITCH_LOG
//#if NO_LOG
//#define NSLog(args...)
//#else
//#define NSLog(args...) ExtendNSLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
//#endif
//#endif

#define D(__VA_ARGS__) NSLog(__VA_ARGS__);
#define I(args...) Log(DLLogLevelInfo,__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
#define W(args...) Log(DLLogLevelWarning,__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
#define E(args...) Log(DLLogLevelError,__FILE__,__LINE__,__PRETTY_FUNCTION__,args);

void Log(DLLogLevel level, const char *file, int line, const char *function, NSString *format,...);