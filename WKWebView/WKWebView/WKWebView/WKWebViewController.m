//
//  WKWebViewController.m
//  WKWebView
//
//  Created by likai on 16/8/15.
//  Copyright © 2016年 kkk. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "WKTopBarView.h"
#import <PureLayout/PureLayout.h>

@interface WKWebViewController ()<WKNavigationDelegate, WKUIDelegate, WKTopBarViewDelegate>
{
    BOOL isBackButtonPressed_;
}

@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, strong) WKTopBarView *wkTopBarView;

@property (nonatomic, strong) UIProgressView *wkProgressView;

@property (nonatomic, strong) NSURL *currentUrl;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.wkTopBarView];
    [self.wkTopBarView addSubview:self.wkProgressView];
    [self.view addSubview:self.wkWebView];
    
    [self.view setNeedsUpdateConstraints]; // bootstrap Auto Layout
    
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    self.webUrlString = [self.webUrlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrlString]];
    [self.wkWebView loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView removeObserver:self forKeyPath:@"title"];
}

#pragma mark - 观察者

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == self.wkWebView) {
            [self.wkProgressView setAlpha:1.0f];
            [self.wkProgressView setProgress:self.wkWebView.estimatedProgress animated:YES];
            if(self.wkWebView.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.wkProgressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.wkProgressView setProgress:0.0f animated:NO];
                }];
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else if ([keyPath isEqualToString:@"title"]) {
        if (object == self.wkWebView) {
            [self setTopBarInfoWithTitle:self.wkWebView.title];
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - WKNavigationDelegate

/**
 *  页面开始加载时调用
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  当内容开始返回时调用
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  页面加载完成之后调用
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  加载失败时调用
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  接收到服务器跳转请求之后调用
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  在收到响应后，决定是否跳转
 *  @param decisionHandler    是否跳转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

/**
 *  在发送请求之前，决定是否跳转
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - H5TopBarViewDelegate

- (void)wkTopBarView:(WKTopBarView *)wkTopBarView buttonTapActionTapType:(WKTopBarTapEvents)tapEvent {
    switch (tapEvent) {
        case WKTopBarTapEventsBack://返回
        {
            if ([self.wkWebView canGoBack]) {
                [self.wkWebView goBack];
                isBackButtonPressed_ = YES;
            } else {
                if (self.pushType == H5PushTypePresent) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }
            break;
        case WKTopBarTapEventsClose://关闭
        {
            if (self.pushType == H5PushTypePresent) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
            break;
        case WKTopBarTapEventsRefresh://刷新
        {
            [self.wkWebView reload];
        }
            break;
        default:
            break;
    }
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {

        [self.wkTopBarView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0];
        [self.wkTopBarView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0];
        [self.wkTopBarView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0];
        [self.wkTopBarView autoSetDimension:ALDimensionHeight toSize:64.0];
        
        [self.wkProgressView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0];
        [self.wkProgressView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0];
        [self.wkProgressView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0];
        [self.wkProgressView autoSetDimension:ALDimensionHeight toSize:2.0];
        
        [self.wkWebView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.wkTopBarView];
        [self.wkWebView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0];
        [self.wkWebView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0];
        [self.wkWebView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateViewConstraints];
}

#pragma mark - Custom Methods

- (void)setTopBarInfoWithTitle:(NSString *)titleStr {
    WKTopBarInfo *topBarInfo = [[WKTopBarInfo alloc] init];
    if (titleStr.length > 0) {
        topBarInfo.titleStr = titleStr;
    }
    topBarInfo.hasClose = isBackButtonPressed_;
    [self.wkTopBarView updateTopBarInfo:topBarInfo];
}

#pragma mark - Getters and Setters

- (UIProgressView *)wkProgressView {
    if (!_wkProgressView) {
        _wkProgressView = [UIProgressView newAutoLayoutView];
        _wkProgressView.progress = 0.0;
        _wkProgressView.progressTintColor = [UIColor orangeColor];
        _wkProgressView.trackTintColor = [UIColor clearColor];
        _wkProgressView.backgroundColor = [UIColor clearColor];
    }
    return _wkProgressView;
}

- (WKTopBarView *)wkTopBarView {
    if (!_wkTopBarView) {
        _wkTopBarView = [WKTopBarView newAutoLayoutView];
        _wkTopBarView.delegate = self;
    }
    return _wkTopBarView;
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [WKWebView newAutoLayoutView];
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
    }
    return _wkWebView;
}

@end
