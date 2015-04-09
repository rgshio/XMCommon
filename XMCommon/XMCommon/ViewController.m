//
//  ViewController.m
//  XMCommon
//
//  Created by rgshio on 15-1-22.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import "ViewController.h"
#import "XMCommon.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(60, 100, 200, 100)];
    view.backgroundColor = [UIColor cyanColor];
    [view setRCornerRadius:50 options:UIRectCornerTopLeft | UIRectCornerBottomRight];
    [view setBorderWidth:5.0f withColor:[UIColor lightGrayColor]];
    [self.view addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 220, 200, 200)];
    imageView.backgroundColor = [UIColor redColor];
    imageView.image = [self.view screenShot];
    [imageView setBorderWidth:2.0f withColor:[UIColor lightGrayColor]];
    [self.view addSubview:imageView];
    
//    self.view.backgroundColor = [UIColor colorWithHexString:@"0x0"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
