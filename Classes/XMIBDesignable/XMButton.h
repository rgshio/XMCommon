//
//  XMButton.h
//  XMCommon
//
//  Created by rgshio on 2017/7/27.
//  Copyright © 2017年 rgshio. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE //类之前加上这个可以在Interface Builder实时渲染
@interface XMButton : UIButton

//IBInspectable说明这个属性可以被观察,在Interface Builder以属性的方式显示
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable BOOL maskToBounds;

@end
