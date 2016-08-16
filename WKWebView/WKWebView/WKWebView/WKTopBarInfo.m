//
//  WKTopBarInfo.m
//  WKWebView
//
//  Created by likai on 16/8/15.
//  Copyright © 2016年 kkk. All rights reserved.
//

#import "WKTopBarInfo.h"

@implementation WKTopBarInfo

- (id)init {
    self = [super init];
    if (self) {
        _hasBack = YES;
        _hasRefresh = YES;
    }
    return self;
}

@end
