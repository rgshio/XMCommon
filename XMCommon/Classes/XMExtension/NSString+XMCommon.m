//
//  NSString+XMCommon.m
//  XMCommon
//
//  Created by rgshio on 15/6/24.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import "NSString+XMCommon.h"

@implementation NSString (XMCommon)

- (NSString *)urlEncode
{
    NSString *encodeStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
    
    return encodeStr;
}

@end
