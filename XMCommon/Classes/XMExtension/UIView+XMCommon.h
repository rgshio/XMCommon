//
//  UIView+XMCommon.h
//  XMCommon
//
//  Created by rgshio on 15-1-22.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XMCommon)

/**
 *  圆角化对象(4个角)
 *  @param radius 圆角半径
 */
- (void)setRCornerRadius:(CGFloat)radius;

/**
 *  圆角化对象(4个角中的任意一个或几个)
 *  @param radius 圆角半径
 *  @param options 圆角的位置
 */
- (void)setRCornerRadius:(CGFloat)radius options:(UIRectCorner)options;

/**
 *  返回一个UIView的截屏, UIImage对象
 */
- (UIImage *)screenShot;

/**
 *  给对象加边框
 */
- (void)setBorderWidth:(CGFloat)width withColor:(UIColor *)color;

@end
