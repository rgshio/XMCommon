//
//  NSCoder+XMCommon.m
//  XMCommon
//
//  Created by rgshio on 16/4/7.
//  Copyright © 2016年 rgshio. All rights reserved.
//

#import "NSCoder+XMCommon.h"

@implementation NSCoder (XMCommon)

- (id)decodeObjectWithKey:(NSString *)key {
    id obj = [self decodeObjectForKey:key];
    if ([obj isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    return obj;
}

@end
