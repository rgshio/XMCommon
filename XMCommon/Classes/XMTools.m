//
//  XMTools.m
//  XMCommon
//
//  Created by rgshio on 15/3/25.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import "XMTools.h"

@implementation XMTools

#pragma mark - 判断空字符串
+ (BOOL)isBlankString:(NSString*)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

#pragma mark - 取当前时间
+ (NSString *)getDateTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

#pragma mark - 生成唯一字符
+ (NSString *)getUUIDStr
{
    NSString *  result;
    CFUUIDRef   uuid;
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    assert(uuidStr != NULL);
    
    result = ( __bridge NSString * ) uuidStr ;
    assert(result != nil);
    
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    result = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return result;
}

#pragma mark - 判断文件是否存在
+ (BOOL)fileExist:(NSString *)filepath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager fileExistsAtPath:filepath];
}

@end
