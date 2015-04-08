//
//  XMTools.h
//  XMCommon
//
//  Created by rgshio on 15/3/25.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMTools : NSObject

#pragma mark - 判断空字符串
+ (BOOL)isBlankString:(NSString*)string;

#pragma mark - 取当前时间
+ (NSString *)getDateTime;

#pragma mark - 生成唯一字符
+ (NSString *)getUUIDStr;

#pragma mark - 判断文件是否存在
+ (BOOL)fileExist:(NSString *)filepath;

@end
