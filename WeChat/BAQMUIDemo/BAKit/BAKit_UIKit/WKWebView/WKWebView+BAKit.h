//
//  WKWebView+BAKit.h
//  BAWebViewController
//
//  Created by boai on 2017/6/14.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 开始加载时调用
 
 @param webView webView
 @param navigation navigation
 */
typedef void (^BAKit_webView_didStartProvisionalNavigationBlock)(WKWebView * _Nullable webView, WKNavigation *navigation);

/**
 当内容开始返回时调用
 
 @param webView webView
 @param navigation navigation
 */
typedef void (^BAKit_webView_didCommitNavigationBlock)(WKWebView *webView, WKNavigation *navigation);

/**
 页面加载完成之后调用
 
 @param webView webView
 @param navigation navigation
 */
typedef void (^BAKit_webView_didFinishNavigationBlock)(WKWebView *webView, WKNavigation *navigation);

/**
 页面加载失败时调用
 
 @param webView webView
 @param navigation navigation
 */
typedef void (^BAKit_webView_didFailProvisionalNavigationBlock)(WKWebView *webView, WKNavigation *navigation);

/**
 获取 webview 当前的加载进度，判断是否正在加载
 
 @param isLoading 是否正在加载
 @param progress web 加载进度，范围：0.0f ~ 1.0f
 */
typedef void (^BAKit_webView_isLoadingBlock)(BOOL isLoading, CGFloat progress);

/**
 获取 webview 当前的 title
 
 @param title title
 */
typedef void (^BAKit_webView_getTitleBlock)(NSString *title);

/**
 JS 调用 OC 时 webview 会调用此方法
 
 @param userContentController webview中配置的userContentController 信息
 
 @param message JS执行传递的消息
 */
typedef void (^BAKit_webView_userContentControllerDidReceiveScriptMessageBlock)(WKUserContentController *userContentController, WKScriptMessage *message);

/**
 在发送请求之前，决定是否跳转，如果不添加这个，那么 wkwebview 跳转不了 AppStore 和 打电话，所谓拦截 URL 进行进一步处理，就在这里处理

 @param currentUrl currentUrl
 */
typedef void (^BAKit_webView_decidePolicyForNavigationActionBlock)(NSURL *currentUrl);

/**
 获取 webview 当前的 URL

 @param currentUrl currentUrl
 */
typedef void (^BAKit_webView_getCurrentUrlBlock)(NSURL *currentUrl);


@interface WKWebView (BAKit)
<
    WKNavigationDelegate,
    WKUIDelegate,
    WKScriptMessageHandler
>

/**
 当前网页的高度
 */
@property(nonatomic, assign) CGFloat ba_web_currentHeight;

/**
 是否可以返回上级页面
 */
@property (nonatomic, readonly) BOOL ba_web_canGoBack;

/**
 是否可以进入下级页面
 */
@property (nonatomic, readonly) BOOL ba_web_canGoForward;

/**
 需要拦截的 urlScheme，先设置此项，再 调用 ba_web_decidePolicyForNavigationActionBlock 来处理，详见 demo
 */
@property(nonatomic, strong) NSString *ba_web_urlScheme;

@property(nonatomic, copy) BAKit_webView_didStartProvisionalNavigationBlock ba_web_didStartBlock;
@property(nonatomic, copy) BAKit_webView_didCommitNavigationBlock ba_web_didCommitBlock;
@property(nonatomic, copy) BAKit_webView_didFinishNavigationBlock ba_web_didFinishBlock;
@property(nonatomic, copy) BAKit_webView_didFailProvisionalNavigationBlock ba_web_didFailBlock;
@property(nonatomic, copy) BAKit_webView_isLoadingBlock ba_web_isLoadingBlock;
@property(nonatomic, copy) BAKit_webView_getTitleBlock ba_web_getTitleBlock;
@property(nonatomic, copy) BAKit_webView_userContentControllerDidReceiveScriptMessageBlock ba_web_userContentControllerDidReceiveScriptMessageBlock;
@property(nonatomic, copy) BAKit_webView_decidePolicyForNavigationActionBlock ba_web_decidePolicyForNavigationActionBlock;
@property(nonatomic, copy) BAKit_webView_getCurrentUrlBlock ba_web_getCurrentUrlBlock;

#pragma mark - Public method

/**
 添加 WKWebView 的代理，注意：用此方法添加代理，例如：
 BAKit_WeakSelf
 [self.webView ba_web_initWithDelegate:weak_self.webView uIDelegate:weak_self.webView];

 @param navigationDelegate navigationDelegate
 @param uIDelegate uIDelegate
 */
- (void)ba_web_initWithDelegate:(id<WKNavigationDelegate>)navigationDelegate
                     uIDelegate:(id<WKUIDelegate>)uIDelegate;

/**
 *  返回上一级页面
 */
- (void)ba_web_goBack;

/**
 *  进入下一级页面
 */
- (void)ba_web_goForward;

/**
 *  刷新 webView
 */
- (void)ba_web_reload;

/**
 *  加载一个 webview
 *
 *  @param request 请求的 NSURL URLRequest
 */
- (void)ba_web_loadRequest:(NSURLRequest *)request;

/**
 *  加载一个 webview
 *
 *  @param URL 请求的 URL
 */
- (void)ba_web_loadURL:(NSURL *)URL;

/**
 *  加载一个 webview
 *
 *  @param URLString 请求的 URLString
 */
- (void)ba_web_loadURLString:(NSString *)URLString;

/**
 *  加载本地网页
 *
 *  @param htmlName 请求的本地 HTML 文件名
 */
- (void)ba_web_loadHTMLFileName:(NSString *)htmlName;

/**
 *  加载本地 htmlString
 *
 *  @param htmlString 请求的本地 htmlString
 */
- (void)ba_web_loadHTMLString:(NSString *)htmlString;

/**
 *  OC 调用 JS，加载 js 字符串，例如：高度自适应获取代码：
 // webView 高度自适应
 [self ba_web_stringByEvaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
 // 获取页面高度，并重置 webview 的 frame
 self.ba_web_currentHeight = [result doubleValue];
 CGRect frame = webView.frame;
 frame.size.height = self.ba_web_currentHeight;
 webView.frame = frame;
 }];
 *
 *  @param javaScriptString js 字符串
 */
- (void)ba_web_stringByEvaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id result, NSError * _Nullable error))completionHandler;

/**
 JS 调用 OC，addScriptMessageHandler:name:有两个参数，第一个参数是 userContentController的代理对象，第二个参数是 JS 里发送 postMessage 的对象。添加一个脚本消息的处理器,同时需要在 JS 中添加，window.webkit.messageHandlers.<name>.postMessage(<messageBody>)才能起作用。
 
 @param nameArray JS 里发送 postMessage 的对象数组，可同时添加多个对象
 */
- (void)ba_web_addScriptMessageHandlerWithNameArray:(NSArray *)nameArray;


@end
NS_ASSUME_NONNULL_END
