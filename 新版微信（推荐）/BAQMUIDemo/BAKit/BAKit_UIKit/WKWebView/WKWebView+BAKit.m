//
//  WKWebView+BAKit.m
//  BAWebViewController
//
//  Created by boai on 2017/6/14.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "WKWebView+BAKit.h"
#import "WKWebView+BAJavaScriptAlert.h"

@implementation WKWebView (BAKit)

#pragma mark - hook

/**
 添加 WKWebView 的代理，注意：用此方法添加代理，例如：
 BAKit_WeakSelf
 [self.webView ba_web_initWithDelegate:weak_self.webView uIDelegate:weak_self.webView];
 
 @param navigationDelegate navigationDelegate
 @param uIDelegate uIDelegate
 */
- (void)ba_web_initWithDelegate:(id<WKNavigationDelegate>)navigationDelegate
                     uIDelegate:(id<WKUIDelegate>)uIDelegate
{
    self.navigationDelegate = navigationDelegate;
    self.UIDelegate = uIDelegate;
    
    [self ba_web_addNoti];
}

//- (instancetype)ba_web_init
//{
//    [self ba_web_init];
//    
//    self.navigationDelegate = self;
//    self.UIDelegate = self;
//    
//    [self ba_web_addNoti];
//
//    return self;
//}
//
//- (instancetype)ba_web_initWithFrame
//{
//    [self ba_web_initWithFrame];
//    
//    self.navigationDelegate = self;
//    self.UIDelegate = self;
//    
//    [self ba_web_addNoti];
//    
//    return self;
//}

- (void)ba_web_dealloc
{
    [self ba_removeNoti];
}

- (void)ba_removeNoti
{
//    NSLog(@"%s",__FUNCTION__);

    [self removeObserver:self forKeyPath:@"title"];
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
    [self removeObserver:self forKeyPath:@"URL"];
}

#pragma mark - 添加对WKWebView属性的监听
- (void)ba_web_addNoti
{
    // 获取页面标题
    [self addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    // 当前页面载入进度
    [self addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    // 监听 URL，当之前的 URL 不为空，而新的 URL 为空时则表示进程被终止
    [self addObserver:self
           forKeyPath:@"URL"
              options:NSKeyValueObservingOptionNew
              context:nil];

}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"title"])
    {
        if (self.ba_web_getTitleBlock)
        {
            self.ba_web_getTitleBlock(self.title);
        }
        if (self.ba_web_getCurrentUrlBlock)
        {
            self.ba_web_getCurrentUrlBlock(self.URL);
        }
    }
    else if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        // estimatedProgress：加载进度，范围：0.0f ~ 1.0f
        NSLog(@"progress: %f", self.estimatedProgress);
        if (self.ba_web_isLoadingBlock)
        {
            self.ba_web_isLoadingBlock(self.loading, self.estimatedProgress);
        }
    }
    else if ([keyPath isEqualToString:@"URL"])
    {
        NSURL *newUrl = [change objectForKey:NSKeyValueChangeNewKey];
        NSURL *oldUrl = [change objectForKey:NSKeyValueChangeOldKey];
        if (![newUrl isKindOfClass:[NSURL class]] && [oldUrl isKindOfClass:[NSURL class]]) {
            [self reload];
        };
    }
    
    // 加载完成
    if (!self.loading)
    {
        if (self.ba_web_isLoadingBlock)
        {
            self.ba_web_isLoadingBlock(self.loading, 1.0F);
        }
    }
}

#ifndef NSFoundationVersionNumber_iOS_9_0
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0){
    
    NSLog(@"进程被终止");
    NSLog(@"%@",webView.URL);
    [webView reload];
}
#else

#endif

#pragma mark - custom Mothed
- (BOOL)ba_externalAppRequiredToOpenURL:(NSURL *)url
{
    // 若需要限制只允许某些前缀的scheme通过请求，则取消下述注释，并在数组内添加自己需要放行的前缀
    //    NSSet *validSchemes = [NSSet setWithArray:@[@"http", @"https",@"file"]];
    //    return ![validSchemes containsObject:URL.scheme];
    
    //    NSURL *responseUrl = navigationAction.request.URL;
    //    NSString *urlStr = [responseUrl absoluteString];
    //    if ([[responseUrl scheme] isEqualToString:baseUrlScheme]) {
    //        if ([urlStr containsString:baseShareUrlPath]) {
    //            //点击立即分享
    ////            [VPKCShare showShareWithPlatformImages:@[@"fx_pengyouquan"]];
    //            decisionHandler(WKNavigationActionPolicyCancel);
    //        } else if([responseUrl.path containsString:baseCloseUrlPath]){
    //            //点击关闭
    //            [_webView removeFromSuperview];
    //            decisionHandler(WKNavigationActionPolicyCancel);
    //        } else if([responseUrl.path containsString:baseGetUrlPath]){
    //            //点击立即领取
    //            decisionHandler(WKNavigationActionPolicyAllow);
    //        } else {
    //            decisionHandler(WKNavigationActionPolicyAllow);
    //        }
    //    } else {
    //        decisionHandler(WKNavigationActionPolicyAllow);
    //    }
    
    return !url;
}

#pragma mark - WKScriptMessageHandler
/**
 *  JS 调用 OC 时 webview 会调用此方法
 *
 *  @param userContentController  webview中配置的userContentController 信息
 *  @param message                JS执行传递的消息
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    // 这里可以通过 name 处理多组交互
    // body 只支持 NSNumber, NSString, NSDate, NSArray,NSDictionary 和 NSNull 类型
    NSLog(@"JS 中 message Body ：%@",message.body);
    
    if (self.ba_web_userContentControllerDidReceiveScriptMessageBlock)
    {
        self.ba_web_userContentControllerDidReceiveScriptMessageBlock(userContentController, message);
    }
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

#pragma mark = WKNavigationDelegate
#pragma mark 这个代理方法表示当客户端收到服务器的响应头，根据 response 相关信息，可以决定这次跳转是否可以继续进行。在发送请求之前，决定是否跳转，如果不添加这个，那么 wkwebview 跳转不了 AppStore 和 打电话
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
//    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
//    NSLog(@"%@",hostname);
    NSURL *url = navigationAction.request.URL;
    NSString *url_string = url.absoluteString;
    NSString *url_scheme = url.scheme;
    NSString *url_query = url.query;
    NSString *url_host = url.host;
    
    NSLog(@"URL scheme:%@", url_scheme);
    NSLog(@"URL scheme2:%@", self.ba_web_urlScheme);
    NSLog(@"URL query: %@", url_query);
    
    if ([url_scheme isEqualToString:self.ba_web_urlScheme])
    {
        if (self.ba_web_decidePolicyForNavigationActionBlock)
        {
            self.ba_web_decidePolicyForNavigationActionBlock(url);
        }
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    // APPStore
    if ([url.absoluteString containsString:@"itunes.apple.com"])
    {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    // 调用电话
    if ([url.scheme isEqualToString:@"tel"])
    {
        if ([BAKit_SharedApplication canOpenURL:url])
        {
            [BAKit_SharedApplication openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    // 参数 WKNavigationAction 中有两个属性：sourceFrame 和 targetFrame，分别代表这个 action 的出处和目标，类型是 WKFrameInfo 。WKFrameInfo有一个 mainFrame 的属性，标记frame是在主frame里显示还是新开一个frame显示
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    BOOL isMainframe = [frameInfo isMainFrame];
    NSLog(@"isMainframe :%d", isMainframe);
    
    if (![self ba_externalAppRequiredToOpenURL:url])
    {
        if (!navigationAction.targetFrame)
        {
            [self ba_web_loadURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    else if ([BAKit_SharedApplication canOpenURL:url])
    {
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }

    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - 在响应完成时，调用的方法。如果设置为不允许响应，web内 容就不会传过来
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark - 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}

#pragma mark - WKNavigationDelegate
// 开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    if (self.ba_web_didStartBlock)
    {
        self.ba_web_didStartBlock(webView, navigation);
    }
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    if (self.ba_web_didCommitBlock)
    {
        self.ba_web_didCommitBlock(webView, navigation);
    }
}

// 页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    // webView 高度自适应
    [self ba_web_stringByEvaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        // 获取页面高度，并重置 webview 的 frame
        self.ba_web_currentHeight = [result doubleValue];
        NSLog(@"html 的高度：%f", self.ba_web_currentHeight);
        
        //        CGRect frame = webView.frame;
        //        frame.size.height = self.ba_web_currentHeight;
        //        webView.frame = frame;
    }];
    
    if (self.ba_web_didFinishBlock)
    {
        self.ba_web_didFinishBlock(webView, navigation);
    }
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    if (self.ba_web_didFailBlock)
    {
        self.ba_web_didFailBlock(webView, navigation);
    }
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    BAKit_ShowAlertWithMsg(@"知道了");
}

#pragma mark - Public method
/**
 *  返回上一级页面
 */
- (void)ba_web_goBack
{
    if (self.canGoBack)
    {
        [self goBack];
    }
}

/**
 *  进入下一级页面
 */
- (void)ba_web_goForward
{
    if (self.canGoForward)
    {
        [self goForward];
    }
}

/**
 *  刷新 webView
 */
- (void)ba_web_reload
{
    [self reload];
}

/**
 *  加载一个 webview
 *
 *  @param request 请求的 NSURL URLRequest
 */
- (void)ba_web_loadRequest:(NSURLRequest *)request
{
    [self loadRequest:request];
//    [self ba_web_addNoti];
}

/**
 *  加载一个 webview
 *
 *  @param URL 请求的 URL
 */
- (void)ba_web_loadURL:(NSURL *)URL
{
    [self ba_web_loadRequest:[NSURLRequest requestWithURL:URL]];
}

/**
 *  加载一个 webview
 *
 *  @param URLString 请求的 URLString
 */
- (void)ba_web_loadURLString:(NSString *)URLString
{
    [self ba_web_loadURL:[NSURL URLWithString:URLString]];
}

/**
 *  加载本地网页
 *
 *  @param htmlName 请求的本地 HTML 文件名
 */
- (void)ba_web_loadHTMLFileName:(NSString *)htmlName
{
    /*! 一定要记得这一步，要不然本地的图片加载不出来 */
//    NSString *basePath = [[NSBundle mainBundle] bundlePath];
//    NSURL *baseURL = [NSURL fileURLWithPath:basePath];
    
//    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:htmlName
//                                                         ofType:@"html"];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.html", htmlName] ofType:nil];

//    NSString *HTMLString = [NSString stringWithContentsOfFile:htmlPath
//                                                     encoding:NSUTF8StringEncoding
//                                                        error:nil];
    if (htmlPath)
    {
        if (BAKit_IOS_VERSION >= 9.0)
        {
            NSURL *fileURL = [NSURL fileURLWithPath:htmlPath];
            [self loadFileURL:fileURL allowingReadAccessToURL:fileURL];
        } else {
            NSURL *fileURL = [self ba_fileURLForBuggyWKWebView8:[NSURL fileURLWithPath:htmlPath]];
            NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
            [self loadRequest:request];
        }
    }
    
//    [self ba_web_addNoti];
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
    
    [self loadHTMLString:htmlString baseURL:baseURL];
//    [self ba_web_addNoti];
}

/**
 *  加载 js 字符串
 *
 *  @param javaScriptString js 字符串
 */
- (void)ba_web_stringByEvaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id result, NSError * _Nullable error))completionHandler
{
    [self evaluateJavaScript:javaScriptString completionHandler:completionHandler];
}


/**
 添加 js 调用 OC，addScriptMessageHandler:name:有两个参数，第一个参数是 userContentController的代理对象，第二个参数是 JS 里发送 postMessage 的对象。添加一个脚本消息的处理器,同时需要在 JS 中添加，window.webkit.messageHandlers.<name>.postMessage(<messageBody>)才能起作用。
 
 @param nameArray JS 里发送 postMessage 的对象数组，可同时添加多个对象
 */
- (void)ba_web_addScriptMessageHandlerWithNameArray:(NSArray *)nameArray
{
    if ([nameArray isKindOfClass:[NSArray class]] && nameArray.count > 0)
    {
        //        self.ba_web_messageName = name;
        [nameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.configuration.userContentController addScriptMessageHandler:self name:obj];
        }];
    }
}

//将文件copy到tmp目录
- (NSURL *)ba_fileURLForBuggyWKWebView8:(NSURL *)fileURL
{
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
        return nil;
    }
    // Create "/temp/www" directory
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    // Files in "/temp/www" load flawlesly :)
    return dstURL;
}

#pragma mark - setter / getter

+ (void)load
{
//    BAKit_Objc_exchangeMethodAToB(NSSelectorFromString(@"init"), @selector(ba_web_init));
//    BAKit_Objc_exchangeMethodAToB(NSSelectorFromString(@"initWithFrame"), @selector(ba_web_initWithFrame));
    BAKit_Objc_exchangeMethodAToB(NSSelectorFromString(@"dealloc"),
                                  @selector(ba_web_dealloc));
}

- (void)setBa_web_currentHeight:(CGFloat)ba_web_currentHeight
{
    BAKit_Objc_setObj(@selector(ba_web_currentHeight), @(ba_web_currentHeight));
}

- (CGFloat)ba_web_currentHeight
{
    return [BAKit_Objc_getObj floatValue];
}

- (BOOL)ba_web_canGoBack
{
    return [self canGoBack];
}
                      
- (BOOL)ba_web_canGoForward
{
    return [self canGoForward];
}

- (void)setBa_web_didStartBlock:(BAKit_webView_didStartProvisionalNavigationBlock)ba_web_didStartBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_didStartBlock), ba_web_didStartBlock);
}

- (BAKit_webView_didStartProvisionalNavigationBlock)ba_web_didStartBlock
{
    return BAKit_Objc_getObj;
}

- (void)setBa_web_didCommitBlock:(BAKit_webView_didCommitNavigationBlock)ba_web_didCommitBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_didCommitBlock), ba_web_didCommitBlock);
}

- (BAKit_webView_didCommitNavigationBlock)ba_web_didCommitBlock
{
    return BAKit_Objc_getObj;
}

- (void)setBa_web_didFinishBlock:(BAKit_webView_didFinishNavigationBlock)ba_web_didFinishBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_didFinishBlock), ba_web_didFinishBlock);
}

- (BAKit_webView_didFinishNavigationBlock)ba_web_didFinishBlock
{
    return BAKit_Objc_getObj;
}

- (void)setBa_web_didFailBlock:(BAKit_webView_didFailProvisionalNavigationBlock)ba_web_didFailBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_didFailBlock), ba_web_didFailBlock);
}

- (BAKit_webView_didFailProvisionalNavigationBlock)ba_web_didFailBlock
{
    return BAKit_Objc_getObj;
}

- (void)setBa_web_isLoadingBlock:(BAKit_webView_isLoadingBlock)ba_web_isLoadingBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_isLoadingBlock), ba_web_isLoadingBlock);
}

- (BAKit_webView_isLoadingBlock)ba_web_isLoadingBlock
{
    return BAKit_Objc_getObj;
}

- (void)setBa_web_getTitleBlock:(BAKit_webView_getTitleBlock)ba_web_getTitleBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_getTitleBlock), ba_web_getTitleBlock);
}

- (BAKit_webView_getTitleBlock)ba_web_getTitleBlock
{
    return BAKit_Objc_getObj;
}

- (void)setBa_web_userContentControllerDidReceiveScriptMessageBlock:(BAKit_webView_userContentControllerDidReceiveScriptMessageBlock)ba_web_userContentControllerDidReceiveScriptMessageBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_userContentControllerDidReceiveScriptMessageBlock), ba_web_userContentControllerDidReceiveScriptMessageBlock);
}

- (BAKit_webView_userContentControllerDidReceiveScriptMessageBlock)ba_web_userContentControllerDidReceiveScriptMessageBlock
{
    return BAKit_Objc_getObj;
}

- (void)setBa_web_decidePolicyForNavigationActionBlock:(BAKit_webView_decidePolicyForNavigationActionBlock)ba_web_decidePolicyForNavigationActionBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_decidePolicyForNavigationActionBlock), ba_web_decidePolicyForNavigationActionBlock);
}

- (BAKit_webView_decidePolicyForNavigationActionBlock)ba_web_decidePolicyForNavigationActionBlock
{
    return BAKit_Objc_getObj;
}

- (void)setBa_web_getCurrentUrlBlock:(BAKit_webView_getCurrentUrlBlock)ba_web_getCurrentUrlBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_getCurrentUrlBlock), ba_web_getCurrentUrlBlock);
}

- (BAKit_webView_getCurrentUrlBlock)ba_web_getCurrentUrlBlock
{
    return BAKit_Objc_getObj;
}

- (void)setBa_web_urlScheme:(NSString *)ba_web_urlScheme
{
    BAKit_Objc_setObj(@selector(ba_web_urlScheme), ba_web_urlScheme);
}

- (NSString *)ba_web_urlScheme
{
    return BAKit_Objc_getObj;
}


@end
