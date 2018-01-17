//
//  PDFView.m
//  XMCommon
//
//  Created by rgshio on 2017/8/15.
//  Copyright © 2017年 rgshio. All rights reserved.
//

#import "PDFView.h"

@interface PDFView () {
    CGPDFPageRef pageRef;
    CGPDFDocumentRef document;
    CGRect pageRect;
}

@property (readwrite) int pageNumber;   // 当前页码
@property (readwrite) int pageCount;    // ppt总页码

@end

@implementation PDFView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.pageNumber = 1;
        
        CFStringRef path = CFStringCreateWithCString(NULL, [[self getPdfPathByFile:@"123"] UTF8String], kCFStringEncodingUTF8);;
        CFURLRef url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, NO);
        document = CGPDFDocumentCreateWithURL(url);
        self.pageCount = (int)CGPDFDocumentGetNumberOfPages(document);
        pageRef = CGPDFDocumentGetPage(document, self.pageNumber);
        
        pageRect = CGPDFPageGetBoxRect(pageRef, kCGPDFMediaBox);

        CFRelease(path);
        CFRelease(url);
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
    CGContextFillRect(context, self.bounds);
    
    CGContextSaveGState(context);
    // Flip the context so that the PDF page is rendered
    // right side up.
    CGContextTranslateCTM(context, 0.0, self.bounds.size.width);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // Scale the context so that the PDF page is rendered
    // at the correct size for the zoom level.
    CGContextScaleCTM(context, self.frame.size.width/pageRect.size.width, self.frame.size.width/pageRect.size.width);
    CGContextDrawPDFPage(context, pageRef);
    
    CGContextRestoreGState(context);
    
//    CGContextRelease(context);
}

- (NSString *)getPdfPathByFile:(NSString *)fileName {
    return [[NSBundle mainBundle] pathForResource:fileName ofType:@"pdf"];
}

- (void)oneFingerSwipe:(UISwipeGestureRecognizer *)recognizer {
    if (recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        
        _pageNumber--;
        if (_pageNumber <= 0) {
            _pageNumber = 1;
            return;
        }
        
        [self setViewPage:_pageNumber];
        [UIView beginAnimations:@"animationID" context:nil];
        [UIView setAnimationDuration:0.7f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self cache:YES];
        
        UIView *superview = self.superview;
        [self removeFromSuperview];
        [superview insertSubview:self atIndex:0];
        
        [UIView commitAnimations];
        
    }
    
    if (recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        _pageNumber++;
        if (_pageNumber > _pageCount)
        {
            _pageNumber = _pageCount;
            return;
        }
        
        [self setViewPage:_pageNumber];
        [UIView beginAnimations:@"animationID" context:nil];
        [UIView setAnimationDuration:0.7f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self cache:YES];
        
        UIView *superview = self.superview;
        [self removeFromSuperview];
        [superview insertSubview:self atIndex:0];
        
        [UIView commitAnimations];
        
    }
}

- (void)setViewPage:(int)pageID {
    pageRef = CGPDFDocumentGetPage(document, pageID);
    _pageNumber = pageID;
    
    [self setNeedsDisplay];
    //_pptCountLabel.text = [NSString stringWithFormat:@"%d/%d",PageID,PageCount];
}

- (void)dealloc {
    NSLog(@"%@ dealloc", [self class]);
    CGPDFDocumentRelease(document);
}

@end
