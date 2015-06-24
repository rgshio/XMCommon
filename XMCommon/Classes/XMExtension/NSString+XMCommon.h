//
//  NSString+XMCommon.h
//  XMCommon
//
//  Created by rgshio on 15/6/24.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XMCommon)

/**
 *  URL中特殊字符转换16进制
 */
- (NSString *)urlEncode;

@end
