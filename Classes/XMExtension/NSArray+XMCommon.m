//
//  NSArray+XMCommon.m
//  XMCommon
//
//  Created by rgshio on 15/7/28.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import "NSArray+XMCommon.h"
#import <objc/runtime.h>

@implementation NSArray (XMCommon)

+ (void)load {
    [super load];
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(xmObjectAtIndex:));
    method_exchangeImplementations(fromMethod, toMethod);
}

- (instancetype)xmObjectAtIndex:(NSInteger)index {
    if (index > self.count-1) {
        @try {
            [self xmObjectAtIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"-------%s Crash Method Class %s-------", class_getName(self.class), __func__);
        }
        @finally {}
        return nil;
    }else {
        [self xmObjectAtIndex:index];
    }
}

@end
