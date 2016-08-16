//
//  RootViewController.m
//  WKWebView
//
//  Created by likai on 16/8/15.
//  Copyright © 2016年 kkk. All rights reserved.
//

#import "RootViewController.h"
#import "WKWebViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)h5Action:(id)sender {
    
    WKWebViewController *vc = [[WKWebViewController alloc] init];
    vc.pushType = H5PushTypeDefault;
    vc.webUrlString = @"http://www.jd.com";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
