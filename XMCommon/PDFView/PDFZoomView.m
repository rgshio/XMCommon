//
//  PDFZoomView.m
//  XMCommon
//
//  Created by rgshio on 2017/8/15.
//  Copyright © 2017年 rgshio. All rights reserved.
//

#import "PDFZoomView.h"
#import "PDFView.h"

@interface PDFZoomView ()

@property (nonatomic, strong) PDFView *pdfView;

@end

@implementation PDFZoomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.minimumZoomScale = 1;
        self.maximumZoomScale = 2;
        
        self.pdfView = [[PDFView alloc] initWithFrame:frame];
        [self addSubview:self.pdfView];
        
        self.pdfView.contentScaleFactor = [[UIScreen mainScreen] scale];

    }
    
    return self;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)sv {
    return self.pdfView;
}

@end
