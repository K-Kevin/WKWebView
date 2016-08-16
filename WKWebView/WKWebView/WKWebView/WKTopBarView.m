//
//  WKTopBarView.m
//  WKWebView
//
//  Created by likai on 16/8/15.
//  Copyright © 2016年 kkk. All rights reserved.
//

#import "WKTopBarView.h"
#import <PureLayout/PureLayout.h>

@interface WKTopBarView()

@property (nonatomic, strong) WKTopBarInfo *topBarInfo;

@property (nonatomic, strong) UIView   *backgroundView;
@property (nonatomic, strong) UIView   *bottomLineView;

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *refreshButton;

@end

@implementation WKTopBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.bottomLineView];
    [self addSubview:self.backButton];
    [self addSubview:self.closeButton];
    [self addSubview:self.refreshButton];
    [self addSubview:self.titleLabel];
    
    [self setNeedsUpdateConstraints]; // bootstrap Auto Layout
    
    [self updateViewConstraints];
}

- (void)updateTopBarInfo:(WKTopBarInfo *)topBarInfo {
    self.topBarInfo = topBarInfo;
    if (self.topBarInfo.titleStr.length >0) {
        self.titleLabel.text = self.topBarInfo.titleStr;
    }
    self.closeButton.hidden = !self.topBarInfo.hasClose;
    self.refreshButton.hidden = !self.topBarInfo.hasRefresh;
}

#pragma mark - buttonTapActionDelegate

- (void)topBarTapAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    WKTopBarTapEvents tapTag = button.tag;
    if (_delegate && [_delegate conformsToProtocol:@protocol(WKTopBarViewDelegate)]) {
        if ([_delegate respondsToSelector:@selector(wkTopBarView:buttonTapActionTapType:)]) {
            [_delegate wkTopBarView:self buttonTapActionTapType:tapTag];
        }
    }
}

- (void)updateViewConstraints
{
    [self.backgroundView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0];
    [self.backgroundView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0];
    [self.backgroundView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0];
    [self.backgroundView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0];
    
    [self.bottomLineView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0];
    [self.bottomLineView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0];
    [self.bottomLineView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.5];
    [self.bottomLineView autoSetDimension:ALDimensionHeight toSize:0.5];
    
    [self.backButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0];
    [self.backButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0];
    [self.backButton autoSetDimensionsToSize:CGSizeMake(40.0, 40.0)];
    
    [self.closeButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0];
    [self.closeButton autoSetDimensionsToSize:CGSizeMake(40.0, 40.0)];
    [self.closeButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.backButton withOffset:5.0];
    
    [self.refreshButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0];
    [self.refreshButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5.0];
    [self.refreshButton autoSetDimensionsToSize:CGSizeMake(40.0, 40.0)];
    
    CGFloat leftAndRightPadding = 40.0 + 5.0 + 40.0 + 5.0;
    
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:leftAndRightPadding];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:leftAndRightPadding];
//    [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.closeButton withOffset:5.0];
//    [self.titleLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.titleLabel withOffset:-5.0];
    [self.titleLabel autoSetDimension:ALDimensionHeight toSize:42.0];

}

#pragma mark - Getters and Setters

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView newAutoLayoutView];
        _backgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _backgroundView;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [UIView newAutoLayoutView];
        _bottomLineView.backgroundColor = [UIColor colorWithRed:220.f/255.f green:220.f/255.f blue:220.f/255.f alpha:1];
    }
    return _bottomLineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel newAutoLayoutView];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton newAutoLayoutView];
        _backButton.tag = WKTopBarTapEventsBack;
        [_backButton setImage:[UIImage imageNamed:@"backImage"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(topBarTapAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _backButton;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton newAutoLayoutView];
        _closeButton.hidden = YES;
        _closeButton.tag = WKTopBarTapEventsClose;
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_closeButton addTarget:self action:@selector(topBarTapAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _closeButton;
}

- (UIButton *)refreshButton {
    if (!_refreshButton) {
        _refreshButton = [UIButton newAutoLayoutView];
        _refreshButton.hidden = YES;
        _refreshButton.tag = WKTopBarTapEventsRefresh;
        [_refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
        _refreshButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_refreshButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_refreshButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_refreshButton addTarget:self action:@selector(topBarTapAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshButton;
}

- (WKTopBarInfo *)topBarInfo {
    if (!_topBarInfo) {
        _topBarInfo = [[WKTopBarInfo alloc] init];
    }
    return _topBarInfo;
}

@end
