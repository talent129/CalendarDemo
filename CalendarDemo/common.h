//
//  common.h
//  CalendarDemo
//
//  Created by mac on 17/5/4.
//  Copyright © 2017年 cai. All rights reserved.
//

#ifndef common_h
#define common_h

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//自定义输出
/* 显示打印行 */
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr, "[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#endif /* common_h */
