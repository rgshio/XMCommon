//
//  XMButton.m
//  XMCommon
//
//  Created by rgshio on 2017/7/27.
//  Copyright © 2017年 rgshio. All rights reserved.
//

#import "XMButton.h"

@implementation XMButton

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    
    self.layer.cornerRadius = _cornerRadius;
}

- (void)setMaskToBounds:(BOOL)maskToBounds {
    _maskToBounds = maskToBounds;
    
    self.layer.masksToBounds = _maskToBounds;
}

@end
