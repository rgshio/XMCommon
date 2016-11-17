//
//  NSCoder+XMCommon.h
//  XMCommon
//
//  Created by rgshio on 16/4/7.
//  Copyright © 2016年 rgshio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCoder (XMCommon)

/**
 *  消除null类型
 */
- (id)decodeObjectWithKey:(NSString *)key;

@end
