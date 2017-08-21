
/*!
 *  @header BAKit.h
 *          BABaseProject
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright    Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

/*
 
 *********************************************************************************
 *
 * 在使用BAKit的过程中如果出现bug请及时以以下任意一种方式联系我，我会及时修复bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * 博客园  : http://www.cnblogs.com/boai/
 * 博客    : http://boai.github.io
 * 简书    : http://www.jianshu.com/users/95c9800fdf47/latest_articles
 * 简书专题 : http://www.jianshu.com/collection/072d578bf782
 
 *********************************************************************************
 
 */


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>


@class BAWebView, BAScriptMessage;
@protocol BAWebViewDelegate <NSObject>

@optional

/**
 *  webview内容的标题
 */
- (void)ba_WebView:(BAWebView *)webview title:(NSString *)title;

/**
 *  webview监听
 */
- (void)ba_WebView:(BAWebView *)webview shouldStartLoadWithURL:(NSURL *)URL;

/**
 *  webview开始加载
 */
- (void)ba_WebViewDidStartLoad:(BAWebView *)webview;

/**
 *  webview加载完成
 */
- (void)ba_WebView:(BAWebView *)webview didFinishLoadingURL:(NSURL *)URL;

/**
 *  webview加载失败
 */
- (void)ba_WebView:(BAWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error;

- (void)ba_webView:(nonnull BAWebView *)webView didReceiveScriptMessage:(nonnull BAScriptMessage *)message;

@end


@interface BAWebView : UIView

/**
 *  progressView 进度条的颜色，默认为橙色
 */
@property (nonatomic, strong) UIColor *tintColor;

/**
 *  是否可以返回上级页面
 */
@property (nonatomic, readonly) BOOL canGoBack;
/**
 *  是否可以进入下级页面
 */
@property (nonatomic, readonly) BOOL canGoForward;

/**
 *  当前正在浏览的网页的 URL，用于复制当前网页 URL
 */
@property (nonatomic, strong) NSURL *webView_currentUrl;
@property (nonatomic, strong) NSString *webView_currentTitle;

@property (nonatomic, weak) id<BAWebViewDelegate>delegate;

/**
 *  初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame;

#pragma mark - Public method
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
 *  加载一个webview
 *
 *  @param request 请求的 NSURL URLRequest
 */
- (void)ba_web_loadRequest:(NSURLRequest *)request;

/**
 *  加载一个webview
 *
 *  @param URL 请求的URL
 */
- (void)ba_web_loadURL:(NSURL *)URL;

/**
 *  加载一个webview
 *
 *  @param URLString 请求的URLString
 */
- (void)ba_web_loadURLString:(NSString *)URLString;

/**
 *  加载本地网页
 *
 *  @param htmlName 请求的本地HTML文件名
 */
- (void)ba_web_loadHTMLFileName:(NSString *)htmlName;

/**
 *  加载本地 htmlString
 *
 *  @param htmlString 请求的本地 htmlString
 */
- (void)ba_web_loadHTMLString:(NSString *)htmlString;

/**
 *  加载本地js方法
 *
 *  @param jsString js字符串
 */
- (void)ba_web_stringByEvaluatingJavaScriptFromString:(NSString *)jsString;

#pragma mark - JS Method Invoke

/**
 *  调用JS方法（无返回值）
 *
 *  @param jsMethod JS方法名称
 */
- (void)ba_web_callJS:(nonnull NSString *)jsMethod;

/**
 *  调用JS方法（可处理返回值）
 *
 *  @param jsMethod JS方法名称
 *  @param handler  回调block
 */
- (void)ba_web_callJS:(nonnull NSString *)jsMethod handler:(nullable void(^)(__nullable id response))handler;

@end

@interface BAScriptMessage : NSObject

/**
 *  方法名
 *  用来确定Native App的执行逻辑
 */
@property (nonatomic, copy) NSString *method;

/**
 *  方法参数
 *  json字符串
 */
@property (nonatomic, copy) NSDictionary *params;

/**
 *  回调函数名
 *  Native App执行完后回调的JS方法名
 */
@property (nonatomic, copy) NSString *callback;

@end
