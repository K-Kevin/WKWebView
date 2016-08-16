//
//  WKWebViewController.h
//  WKWebView
//
//  Created by likai on 16/8/15.
//  Copyright © 2016年 kkk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, H5PushType) {
    H5PushTypeDefault = 0,
    H5PushTypePresent = 1,
};

@interface WKWebViewController : UIViewController

@property (nonatomic, assign) H5PushType pushType;

@property (nonatomic, strong) NSString *webUrlString;

@end
