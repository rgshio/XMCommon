//
//  ViewController.m
//  XMCommon
//
//  Created by rgshio on 15-1-22.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import "ViewController.h"
#import "XMCommon.h"
#import "FirstViewController.h"
#import "PDFView.h"

@interface ViewController () 

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#if 0
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
        
    self.view.backgroundColor = [UIColor colorWithHexString:@"0x0"];
#elif 0
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:18];
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
    
    NSString *str = nil;
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:str forKey:@"123"];
    
#elif 0
    
    NSURL *url = [NSURL URLWithString:@"http://101.201.169.97/cs/device/recommend.do?user_id=1&device=1"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *dict = [data jsonObject];
    //字典进行非null值处理,进行字段null处理
    NSLog(@"dict = %@ str = %@", [dict nonull], [dict objectWithKey:@"abc"]);
    
#elif 0
    NSString *email = @"asdf@163.com";
    NSLog(@"valid email is ok %@", email.isValidEmail ? @"YES" : @"NO");
    
    NSString *phone = @"11111111111";
    NSLog(@"valid phone number is ok %@", phone.isValidPhoneNumber ? @"YES" : @"NO");
    
    NSString *person = @"111111111111111111";
    NSLog(@"valid person id is ok %@", person.isValidPersonID ? @"YES" : @"NO");
    
    NSString *aes = @"123";
    NSLog(@"eaes = %@\ndaes = %@", [aes encryptAESWithKey:@""], [[aes encryptAESWithKey:@""] decryptAESWithKey:@""]);
#elif 1
    
    
#endif
}

- (IBAction)goFirst:(id)sender {
    
    FirstViewController *first = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
    [self.navigationController pushViewController:first animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
