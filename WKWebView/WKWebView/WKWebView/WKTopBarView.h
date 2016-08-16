//
//  WKTopBarView.h
//  WKWebView
//
//  Created by likai on 16/8/15.
//  Copyright © 2016年 kkk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKTopBarInfo.h"

typedef NS_ENUM (NSInteger, WKTopBarTapEvents){
    WKTopBarTapEventsBack    = 0,
    WKTopBarTapEventsClose   = 1,
    WKTopBarTapEventsRefresh = 2,
};

@class WKTopBarInfo;
@protocol WKTopBarViewDelegate;

@interface WKTopBarView : UIView

@property (nonatomic, weak) id<WKTopBarViewDelegate> delegate;

- (void)updateTopBarInfo:(WKTopBarInfo *)topBarInfo;

@end

@protocol WKTopBarViewDelegate <NSObject>

- (void)wkTopBarView:(WKTopBarView *)wkTopBarView buttonTapActionTapType:(WKTopBarTapEvents)tapEvent;

@end
