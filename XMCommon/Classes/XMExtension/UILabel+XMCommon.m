//
//  UILabel+XMCommon.m
//  XMCommon
//
//  Created by rgshio on 15/7/28.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import "UILabel+XMCommon.h"
#import "XMCommon.h"

@implementation UILabel (XMCommon)

- (NSString *)autoText
{
    return self.text;
}

- (void)setAutoText:(NSString *)autoText
{
    /**< 主线程执行,获取其他属性*/
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat height1 = [autoText boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: self.font} context:nil].size.height; /**< 文本总高度*/
        
        CGFloat height2 = [@"单" boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: self.font} context:nil].size.height; /**< 单行文本高度*/
        
        CGFloat height = 0.0f;
        if (self.numberOfLines == 0) {
            height = height1;
        }else {
            height = height2 * (int)self.numberOfLines;
        }
        
        self.frame = CGRectMake(self.originX, self.originY, self.width, height);
        self.text = autoText;
    });
}

@end
