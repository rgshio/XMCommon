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
    
    Method originMethod;
    Method overrideMethod;
    //解决不可变数组越界问题
    originMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    overrideMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(xm_objectAtIndex_I:));
    method_exchangeImplementations(originMethod, overrideMethod);
    
    //解决可变数组越界问题
    originMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
    overrideMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(xm_objectAtIndex_M:));
    method_exchangeImplementations(originMethod, overrideMethod);
    
    //解决可变数组添加nil问题
    originMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(addObject:));
    overrideMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(xm_addObject:));
    method_exchangeImplementations(originMethod, overrideMethod);
    
    //解决不可变数组添加nil问题
    originMethod = class_getInstanceMethod(objc_getClass("__NSPlaceholderArray"), @selector(initWithObjects:count:));
    overrideMethod = class_getInstanceMethod(objc_getClass("__NSPlaceholderArray"), @selector(xm_initWithObjects:count:));
    method_exchangeImplementations(originMethod, overrideMethod);
}

- (instancetype)xm_objectAtIndex_I:(NSInteger)index {
    if (index > self.count-1) {
        return nil;
    }
    
    return [self xm_objectAtIndex_I:index];
}

- (instancetype)xm_objectAtIndex_M:(NSInteger)index {
    if (index > self.count-1) {
        return nil;
    }
    
    return [self xm_objectAtIndex_M:index];
}

- (void)xm_addObject:(id)anObject {
    if (!anObject) {
        return;
    }
    
    [self xm_addObject:anObject];
}

- (instancetype)xm_initWithObjects:(const id  _Nonnull     __unsafe_unretained *)objects count:(NSUInteger)cnt {
    BOOL hasNilObject = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        if ([objects[i] isKindOfClass:[NSArray class]]) {
            NSLog(@"%@", objects[i]);
        }
        if (objects[i] == nil) {
            hasNilObject = YES;
            NSLog(@"%s object at index %lu is nil, it will be     filtered", __FUNCTION__, i);
        }
    }
    
    // 因为有值为nil的元素，那么我们可以过滤掉值为nil的元素
    if (hasNilObject) {
        id __unsafe_unretained newObjects[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
            }else {
                newObjects[index++] = @"";
            }
        }
        return [self xm_initWithObjects:newObjects count:index];
    }
    return [self xm_initWithObjects:objects count:cnt];
}

@end

