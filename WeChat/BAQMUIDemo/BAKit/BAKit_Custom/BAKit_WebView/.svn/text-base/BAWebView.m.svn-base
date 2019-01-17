//
//  BAWebView.m
//  BAQMUIDemo
//
//  Created by boai on 2017/3/18.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BAWebView.h"
#import "WKWebView+Post.h"

@interface BAWebView ()
<
    WKNavigationDelegate,
    WKUIDelegate,
    UIWebViewDelegate,
    UIAlertViewDelegate
>
{
    /*! 将代理对象是否能响应相关协议方法缓存在结构体中 */
    struct {
        unsigned int didTitle           :1;
        unsigned int didShouldStartLoad :1;
        unsigned int didStartLoad       :1;
        unsigned int didFinishLoad      :1;
        unsigned int didFailLoad        :1;
        unsigned int didReceiveScriptMessage      :1;

    } _BAWebViewFlags;
}

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, strong) NSURL *urlToLaunchWithPermission;
@property (nonatomic, assign) BOOL webView_isLoading;
@property (strong, nonatomic) UIProgressView *progressView;

@property (nonatomic, strong) UIAlertView *externalAppPermissionAlertView;

@end

@implementation BAWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    if (NSClassFromString(@"WKWebView"))
    {
        WKWebViewConfiguration *webConfig = [[WKWebViewConfiguration alloc] init];
        webConfig.preferences = [[WKPreferences alloc] init];
        webConfig.preferences.minimumFontSize = 40;
        
        self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:webConfig];
    }
    else
    {
        self.webView = [UIWebView new];
    }
    
    self.backgroundColor = BAKit_Color_White;

    if (self.wkWebView)
    {
        self.wkWebView.navigationDelegate = self;
        self.wkWebView.UIDelegate = self;
        self.wkWebView.multipleTouchEnabled = YES;
        self.wkWebView.autoresizesSubviews = YES;
//        self.wkWebView.scrollView.alwaysBounceVertical = YES;
        
        [self addSubview:self.wkWebView];
        [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [self insertSubview:_webView belowSubview:self.progressView];
    }
    else
    {
        self.webView.delegate = self;
        self.webView.multipleTouchEnabled = YES;
        self.webView.autoresizesSubviews = YES;
        self.webView.scalesPageToFit = YES;
//        self.webView.scrollView.alwaysBounceVertical = YES;
        /*! 适应屏幕 */
        self.webView.scalesPageToFit = YES;
        /*! 解决iOS9.2以上黑边问题 */
        self.webView.opaque = NO;
        /*! 关闭多点触控 */
        self.webView.multipleTouchEnabled = YES;
        /*! 加载网页中的电话号码，单击可以拨打 */
        self.webView.dataDetectorTypes = YES;
        
        [self addSubview:self.webView];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.wkWebView)
    {
        self.wkWebView.frame = self.bounds;
    }
    if (self.webView)
    {
        self.webView.frame = self.bounds;
    }
    
}

#pragma mark - Public method
/**
 *  返回上一级页面
 */
- (void)ba_web_goBack
{
    if (self.wkWebView)
    {
        [self.wkWebView goBack];
    }
    else
    {
        [self.webView goBack];
    }
}

/**
 *  进入下一级页面
 */
- (void)ba_web_goForward
{
    if (self.wkWebView)
    {
        [self.wkWebView goForward];
    }
    else
    {
        [self.webView goForward];
    }
}

/**
 *  刷新 webView
 */
- (void)ba_web_reload
{
    if (self.wkWebView)
    {
        [self.wkWebView reload];
    }
    else
    {
        [self.webView reload];
    }
}

/**
 *  加载一个webview
 *
 *  @param request 请求的 NSURL URLRequest
 */
- (void)ba_web_loadRequest:(NSURLRequest *)request
{
    if (self.wkWebView)
    {
        [self.wkWebView loadRequest:request];
    }
    else
    {
        [self.webView loadRequest:request];
    }
}

/**
 *  加载一个webview
 *
 *  @param URL 请求的URL
 */
- (void)ba_web_loadURL:(NSURL *)URL
{
    [self ba_web_loadRequest:[NSURLRequest requestWithURL:URL]];
}

/**
 *  加载一个webview
 *
 *  @param URLString 请求的URLString
 */
- (void)ba_web_loadURLString:(NSString *)URLString
{
    NSURL *url = [NSURL URLWithString:URLString];
    [self ba_web_loadURL:url];
}

/**
 *  加载本地网页
 *
 *  @param htmlName 请求的本地HTML文件名
 */
- (void)ba_web_loadHTMLFileName:(NSString *)htmlName
{
    /*! 一定要记得这一步，要不然本地的图片加载不出来 */
    NSString *basePath = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:basePath];
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:htmlName
                                                         ofType:@"html"];
    NSString *HTMLString = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    if (self.wkWebView)
    {
        [self.wkWebView loadHTMLString:HTMLString baseURL:baseURL];
    }
    else
    {
        [self.webView loadHTMLString:HTMLString baseURL:baseURL];
    }
}

/**
 *  加载本地 htmlString
 *
 *  @param htmlString 请求的本地 htmlString
 */
- (void)ba_web_loadHTMLString:(NSString *)htmlString
{
    /*! 一定要记得这一步，要不然本地的图片加载不出来 */
    NSString *basePath = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:basePath];
    
    if (self.wkWebView)
    {
        [self.wkWebView loadHTMLString:htmlString baseURL:baseURL];
    }
    else
    {
        [self.webView loadHTMLString:htmlString baseURL:baseURL];
    }
}

/**
 *  加载本地js方法
 *
 *  @param jsString js字符串
 */
- (void)ba_web_stringByEvaluatingJavaScriptFromString:(NSString *)jsString
{
    if (self.wkWebView)
    {
        [self.wkWebView evaluateJavaScript:jsString completionHandler:nil];
    }
    else
    {
        [self.webView stringByEvaluatingJavaScriptFromString:jsString];
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (webView == self.webView)
    {
        if (_BAWebViewFlags.didStartLoad)
        {
            [self.delegate ba_WebViewDidStartLoad:self];
        }
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (webView == self.webView)
    {
        if (![self ba_externalAppRequiredToOpenURL:request.URL])
        {
            self.webView_currentUrl = request.URL;
            self.webView_isLoading = YES;
            self.webView_currentTitle = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
            
            if (_BAWebViewFlags.didShouldStartLoad)
            {
                [self.delegate ba_WebView:self shouldStartLoadWithURL:request.URL];
            }
            return YES;
        }
        else
        {
            [self ba_launchExternalAppWithURL:request.URL];
            return NO;
        }
    }
    return NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (webView == self.webView)
    {
        BAKit_SharedApplication.networkActivityIndicatorVisible = NO;

        if (!self.webView.isLoading)
        {
            self.webView_isLoading = NO;
        }
        if (_BAWebViewFlags.didFinishLoad)
        {
            [self.delegate ba_WebView:self didFinishLoadingURL:self.webView.request.URL];
        }
        // 获取内容高度
        CGFloat height =  [[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] intValue];
        
        NSLog(@"html 的高度：%f", height);
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (webView == self.webView)
    {
        if (!self.webView.isLoading)
        {
            self.webView_isLoading = NO;
        }
        if (_BAWebViewFlags.didFailLoad)
        {
            [self.delegate ba_WebView:self didFailToLoadURL:self.webView.request.URL error:error];
        }
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    if (webView == self.wkWebView)
    {
        self.webView_currentUrl = self.wkWebView.URL;
        if (_BAWebViewFlags.didStartLoad)
        {
            [self.delegate ba_WebViewDidStartLoad:self];
        }
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    if (webView == self.wkWebView)
    {
        self.webView_currentUrl = self.wkWebView.URL;
        if (_BAWebViewFlags.didFinishLoad)
        {
            [self.delegate ba_WebView:self didFinishLoadingURL:self.wkWebView.URL];
        }
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if (webView == self.wkWebView)
    {
        if (_BAWebViewFlags.didFailLoad)
        {
            [self.delegate ba_WebView:self didFailToLoadURL:self.wkWebView.URL error:error];
        }
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if (webView == self.wkWebView)
    {
        if (_BAWebViewFlags.didFailLoad)
        {
            [self.delegate ba_WebView:self didFailToLoadURL:self.wkWebView.URL error:error];
        }
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if (webView == self.wkWebView)
    {
        if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"])
        {
            [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
            decisionHandler(WKNavigationActionPolicyCancel);
        }
//        else
//        {
//            decisionHandler(WKNavigationActionPolicyAllow);
//        }
//        
        NSURL *url = navigationAction.request.URL;
        self.webView_currentUrl = self.wkWebView.URL;
        if (![self ba_externalAppRequiredToOpenURL:url])
        {
            if (!navigationAction.targetFrame)
            {
                [self ba_web_loadURL:url];
                decisionHandler(WKNavigationActionPolicyCancel);
                return;
            }
            [self ba_callBack_webViewShuldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType];
        }
        else if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [self ba_launchExternalAppWithURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (BOOL)ba_callBack_webViewShuldStartLoadWithRequest:(NSURLRequest *)request navigationType:(NSInteger)navigationType
{
    if (_BAWebViewFlags.didShouldStartLoad)
    {
        [self.delegate ba_WebView:self shouldStartLoadWithURL:request.URL];
    }
    return YES;
}

#pragma mark - WKUIDelegate
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (!navigationAction.targetFrame.isMainFrame)
    {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark - Estimated Progress KVO (WKWebView)
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
    else if ([keyPath isEqualToString:@"title"])
    {
        self.webView_currentTitle = self.wkWebView.title;
        if (_BAWebViewFlags.didTitle)
        {
            [self.delegate ba_WebView:self title:self.webView_currentTitle];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSLog(@"message:%@",message.body);
    if ([message.body isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *body = (NSDictionary *)message.body;
        
        BAScriptMessage *msg = [BAScriptMessage new];
        [msg setValuesForKeysWithDictionary:body];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(ba_webView:didReceiveScriptMessage:)]) {
            [self.delegate ba_webView:self didReceiveScriptMessage:msg];
        }
    }
    
}

#pragma mark - JS

- (void)ba_web_callJS:(NSString *)jsMethod
{
    [self ba_web_callJS:jsMethod handler:nil];
}

- (void)ba_web_callJS:(NSString *)jsMethod handler:(void (^)(id _Nullable))handler
{
    
    NSLog(@"call js:%@", jsMethod);
    if (self.wkWebView)
    {
        [self.wkWebView evaluateJavaScript:jsMethod completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            if (handler) {
                handler(response);
            }
        }];
    }
}

#pragma mark - custom Mothed
- (BOOL)ba_externalAppRequiredToOpenURL:(NSURL *)url
{
    //若需要限制只允许某些前缀的scheme通过请求，则取消下述注释，并在数组内添加自己需要放行的前缀
    //    NSSet *validSchemes = [NSSet setWithArray:@[@"http", @"https",@"file"]];
    //    return ![validSchemes containsObject:URL.scheme];
    return !url;
}

- (void)ba_launchExternalAppWithURL:(NSURL *)url
{
    self.urlToLaunchWithPermission = url;
    if (!self.externalAppPermissionAlertView.isVisible)
    {
        [self.externalAppPermissionAlertView show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView == self.externalAppPermissionAlertView)
    {
        if (buttonIndex != alertView.cancelButtonIndex)
        {
            [BAKit_SharedApplication openURL:self.urlToLaunchWithPermission];
        }
        self.urlToLaunchWithPermission = nil;
    }
}

#pragma mark 拼接cookie
- (NSString*)readCurrentCookieWith:(NSDictionary*)dic
{
    if (dic == nil) {
        return nil;
    }else{
        NSHTTPCookieStorage*cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        NSMutableString *cookieString = [[NSMutableString alloc] init];
        for (NSHTTPCookie*cookie in [cookieJar cookies]) {
            [cookieString appendFormat:@"%@=%@;",cookie.name,cookie.value];
        }
        //删除最后一个“；”
        [cookieString deleteCharactersInRange:NSMakeRange(cookieString.length - 1, 1)];
        return cookieString;
        
    }
}

//设置cookie

- (void)setCookie{
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
//    [cookieProperties setObject:@"cookie_user" forKey:NSHTTPCookieName];
//    [cookieProperties setObject:uid forKey:NSHTTPCookieValue];
    [cookieProperties setObject:@"http://testpay.yunlianhui.cn" forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
    
    NSHTTPCookie *cookieuser = [[NSHTTPCookie alloc] initWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser];
}

//清除cookie

//- (void)deleteCookie{
//    NSHTTPCookie *cookie;
//    
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    
//    NSArray *cookieAry = [cookieJar cookiesForURL: [NSURL URLWithString: _urlstr]];
//    
//    for (cookie in cookieAry) {
//        
//        [cookieJar deleteCookie: cookie];
//        
//    }  
//}

#pragma mark - setter / getter

- (BOOL)canGoBack
{
    if (self.wkWebView)
    {
        return [self.wkWebView canGoBack];
    }
    else
    {
        return [self.webView canGoBack];
    }
}

- (BOOL)canGoForward
{
    if (self.wkWebView)
    {
        return [self.wkWebView canGoForward];
    }
    else
    {
        return [self.webView canGoForward];
    }
}

- (void)setTintColor:(UIColor *)tintColor
{
    _tintColor = tintColor;
}

- (void)setDelegate:(id<BAWebViewDelegate>)delegate
{
    _delegate = delegate;
    _BAWebViewFlags.didTitle = [delegate respondsToSelector:@selector(ba_WebView:title:)];
    _BAWebViewFlags.didShouldStartLoad = [delegate respondsToSelector:@selector(ba_WebView:shouldStartLoadWithURL:)];
    _BAWebViewFlags.didStartLoad = [delegate respondsToSelector:@selector(ba_WebViewDidStartLoad:)];
    _BAWebViewFlags.didFinishLoad = [delegate respondsToSelector:@selector(ba_WebView:didFinishLoadingURL:)];
    _BAWebViewFlags.didFailLoad = [delegate respondsToSelector:@selector(ba_WebView:didFailToLoadURL:error:)];
    _BAWebViewFlags.didReceiveScriptMessage = [delegate respondsToSelector:@selector(ba_webView:didReceiveScriptMessage:)];
}

- (UIProgressView *)progressView
{
    if(!_progressView)
    {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 2.0f)];
        self.progressView.tintColor = [UIColor orangeColor];
        self.progressView.trackTintColor = [UIColor whiteColor];
        [self addSubview:self.progressView];
    }
    return _progressView;
}

#pragma mark - Dealloc
- (void)dealloc
{
    self.webView.delegate = nil;
    self.wkWebView.navigationDelegate = nil;
    self.wkWebView.UIDelegate = nil;
    [self.wkWebView removeObserver:self forKeyPath:@"title"];
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];

}


@end

@implementation BAScriptMessage

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@:{method:%@,params:%@,callback:%@}>", NSStringFromClass([self class]),self.method, self.params, self.callback];
}

@end
