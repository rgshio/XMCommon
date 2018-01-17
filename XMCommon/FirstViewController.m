//
//  FirstViewController.m
//  XMCommon
//
//  Created by rgshio on 15/7/7.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import "FirstViewController.h"
#import "PDFView.h"
#import "PDFZoomView.h"

@interface FirstViewController ()<CALayerDelegate, UIScrollViewDelegate> {
    UIView *myContentView;
    UIScrollView *scrollView;
    CGPDFPageRef myPageRef;
    
    PDFView *pdfView;
    
    UISwipeGestureRecognizer *oneFingerSwiperight;
    UISwipeGestureRecognizer *oneFingerSwipeleft;
}

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadMainView];
}

- (void)loadMainView {
    PDFZoomView *zoomView = [[PDFZoomView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:zoomView];
    
    oneFingerSwiperight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipe:)];
    [oneFingerSwiperight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:oneFingerSwiperight];
    
    oneFingerSwipeleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipe:)];
    [oneFingerSwipeleft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:oneFingerSwipeleft];
}

- (void)oneFingerSwipe:(UISwipeGestureRecognizer *)recognizer {
    [pdfView oneFingerSwipe:recognizer];
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
