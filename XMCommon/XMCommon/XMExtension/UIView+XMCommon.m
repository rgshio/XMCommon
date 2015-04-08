//
//  UIView+XMCommon.m
//  XMCommon
//
//  Created by rgshio on 15-1-22.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import "UIView+XMCommon.h"

@implementation UIView (XMCommon)

/**
 *  返回一个圆角化的对象(4个角)
 *  @param radius 圆角半径
 */
- (void)setRCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
}

/**
 *  返回一个圆角化的对象(4个角中的任意一个或几个)
 *  @param radius 圆角半径
 *  @param options 圆角的位置
 */
- (void)setRCornerRadius:(CGFloat)radius options:(UIRectCorner)options
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:options cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

/**
 *  返回一个UIView的截屏, UIImage对象
 */
- (UIImage *)screenShot
{
	UIGraphicsBeginImageContext(self.bounds.size);
	[[UIColor clearColor] setFill];
	[[UIBezierPath bezierPathWithRect:self.bounds] fill];
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	[self.layer renderInContext:ctx];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

/**
 *  给对象加边框
 */
- (void)setBorderWidth:(CGFloat)width withColor:(UIColor *)color
{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

@end
