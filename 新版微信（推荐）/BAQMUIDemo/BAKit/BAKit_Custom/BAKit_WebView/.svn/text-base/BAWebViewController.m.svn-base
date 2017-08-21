//
//  BAWebViewController.m
//  BAQMUIDemo
//
//  Created by boai on 2017/3/18.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BAWebViewController.h"
#import "BAWebView.h"
#import "BAWebViewModel.h"

#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"


@interface BAWebViewController ()<BAWebViewDelegate, NJKWebViewProgressDelegate, UIWebViewDelegate, WKNavigationDelegate,WKUIDelegate>
{
    BOOL _isWebViewOnceFinishLoad; //webview是否曾经成功加载成功过
    BOOL _isWebViewReloadOperation; //webview是否是重新加载
    
    NSMutableDictionary *_backDict;
    
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@property (nonatomic, strong) BAWebView *webView;

@end

@implementation BAWebViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.webView isKindOfClass:[UIWebView class]])
    {
        [self.view addSubview:_progressView];
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.webView isKindOfClass:[UIWebView class]])
    {
        [_progressView removeFromSuperview];
    }

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = BAKit_Color_White;
    [self loadViewModel];
}

- (void)loadViewModel
{
    [self configBackItem];
    [self configMenuItem];
    
    if ([self.webView isKindOfClass:[UIWebView class]])
    {
        _progressProxy = [[NJKWebViewProgress alloc] init];
        ((UIWebView *)self.webView).delegate = _progressProxy;
        
        _progressProxy.webViewProxyDelegate = self;
        _progressProxy.progressDelegate = self;
        
        CGFloat progressBarHeight = 2.f;
        CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0, 64 + progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
        _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    
    if (self.viewModel.requestURL)
    {
        [self.webView ba_web_loadURLString:self.viewModel.requestURL];
    }
    else if (self.viewModel.htmlString)
    {
        self.navigationItem.rightBarButtonItem = nil;
        [self.webView ba_web_loadHTMLString:self.viewModel.htmlString];
    }
    self.webView.delegate = self;
    
    if (self.viewModel.title)
    {
        self.title = self.viewModel.title;
    }
    if (self.request)
    {
        [self.webView ba_web_loadRequest:self.request];
    }
    if (self.htmlFileName)
    {
        [self.webView ba_web_loadHTMLFileName:self.htmlFileName];
    }
}

/**
 *  webview内容的标题
 */
- (void)ba_WebView:(BAWebView *)webview title:(NSString *)title
{
    if (self.viewModel.title)
    {
        self.title = self.viewModel.title;
    }
    else
    {
        self.title = self.webView.webView_currentTitle;
    }
}

/**
 *  webview监听
 */
- (void)ba_WebView:(BAWebView *)webview shouldStartLoadWithURL:(NSURL *)URL
{
        dispatch_main_async_safe(^{
//                [QMUITips showLoading:@"Loading..." inView:self.navigationController.view hideAfterDelay:0.5f];
        });
}

/**
 *  webview开始加载
 */
- (void)ba_WebViewDidStartLoad:(BAWebView *)webview
{
}

/**
 *  webview加载完成
 */
- (void)ba_WebView:(BAWebView *)webview didFinishLoadingURL:(NSURL *)URL
{
    dispatch_main_async_safe(^{
//                [QMUITips showSucceed:@"Success!" inView:self.navigationController.view hideAfterDelay:0.5f];


//            NSString *jsMethod = @"document.getElementById(\"download\").remove();document.querySelector(\"header.has-banner\").style.marginTop = 0;";
//            [self.webView ba_web_stringByEvaluatingJavaScriptFromString:jsMethod];
    });
}

/**
 *  webview加载失败
 */
- (void)ba_WebView:(BAWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error
{
    dispatch_main_async_safe(^{
        [QMUITips showError:@"Error" inView:self.navigationController.view hideAfterDelay:0.5f];
    });
}

- (void)ba_webView:(nonnull BAWebView *)webView didReceiveScriptMessage:(nonnull BAScriptMessage *)message
{
    NSLog(@"webView method:%@",message.method);
    
    //返回上一页
    if ([message.method isEqualToString:@"tobackpage"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    //打开新页面
    else if ([message.method isEqualToString:@"openappurl"]) {
        
        NSString *url = [message.params objectForKey:@"url"];
        if (url.length) {
            BAWebViewModel *model = [[BAWebViewModel alloc] initWithParams:@{RequestURLkey:url}];
            BAWebViewController *webViewController = [[BAWebViewController alloc] init];
            webViewController.viewModel = model;
            
            [self.navigationController pushViewController:webViewController animated:YES];
        }
    }

}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
//    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.webView.frame = self.view.bounds;
}



#pragma mark - custom Method

#pragma mark 导航栏的返回按钮
- (void)configBackItem
{
    UIImage *backImage = [UIImage imageNamed:@"nav-back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *backBtn = [[UIButton alloc] init];
//    [backBtn setTintColor:BAKit_ColorOrange];
    [backBtn setBackgroundImage:backImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn sizeToFit];
    
    UIBarButtonItem *colseItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = colseItem;
}

#pragma mark 导航栏的菜单按钮
- (void)configMenuItem
{
    UIImage *menuImage = [UIImage imageNamed:@"more_menu"];
    menuImage = [menuImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *menuBtn = [[UIButton alloc] init];
//    [menuBtn setTintColor:BAKit_ColorOrange];
    [menuBtn setImage:menuImage forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [menuBtn sizeToFit];
    
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.navigationItem.rightBarButtonItem = menuItem;
}

#pragma mark 导航栏的关闭按钮
- (void)configColseItem
{
    UIButton *colseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [colseBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [colseBtn setTitleColor:BAKit_Color_Black forState:UIControlStateNormal];
    [colseBtn addTarget:self action:@selector(colseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [colseBtn sizeToFit];
    
    UIBarButtonItem *colseItem = [[UIBarButtonItem alloc] initWithCustomView:colseBtn];
    NSMutableArray *newArr = [NSMutableArray arrayWithObjects:self.navigationItem.leftBarButtonItem,colseItem, nil];
    self.navigationItem.leftBarButtonItems = newArr;
}

#pragma mark - ***** 按钮点击事件
#pragma mark 返回按钮点击
- (void)backBtnAction:(UIButton *)sender
{
    if (self.webView.canGoBack)
    {
        [self.webView ba_web_goBack];
        if (self.navigationItem.leftBarButtonItems.count == 1)
        {
            [self configColseItem];
        }
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark 菜单按钮点击
- (void)menuBtnAction:(UIButton *)sender
{
    BAKit_WeakSelf

    [UIAlertController ba_alertControllerShowActionSheetInViewController:self withTitle:@"更 多" mutableAttributedTitle:nil message:nil mutableAttributedMessage:nil buttonTitlesArray:@[@"safari打开", @"复制链接", @"分享", @"刷新"] buttonTitleColorArray:@[BAKit_Color_Red, BAKit_Color_Green, BAKit_Color_Yellow, BAKit_Color_Orange] popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {
        
    } tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        
        BAKit_StrongSelf
        NSString *urlStr = self.viewModel.requestURL;
       
        urlStr = self.webView.webView_currentUrl.absoluteString;

        if (buttonIndex == 0)
        {
            if (urlStr.length > 0)
            {
                /*! safari打开 */
                BAKit_OpenUrl(urlStr);
                return;
            }
            else
            {
                BAKit_ShowAlertWithMsg_ios8(@"无法获取到当前 URL！");
            }
        }
        else if (buttonIndex == 1)
        {
            /*! 复制链接 */
            if (urlStr.length > 0)
            {
                BAKit_CopyContent(urlStr);
                [self.view ba_showAlertView:@"温馨提示：" message:@"亲爱的，已复制URL到黏贴板中！"];
                return;
            }
            else
            {
                BAKit_ShowAlertWithMsg_ios8(@"无法获取到当前 URL！");
            }
        }
        else if (buttonIndex == 2)
        {
            //            NSString *shareTitle = @"博爱分享 2.0 版";
            //            NSString *shareUrlSrt = @"http://www.cnblogs.com/boai/";
            //            NSString *shareContent = [NSString stringWithFormat:@"测试（博爱BABaseProject）分享【博爱之家】！详情点击：%@", shareUrlSrt];
            //            // 注意：图片不能为空
            //            UIImage *shareImage = [UIImage imageNamed:@"icon1.jpg"];
            
            //            [BASHAREMANAGER ba_UMshareListWithViewControll:self title:shareTitle shareContent:shareContent image:shareImage url:shareUrlSrt];
        }
        else if (buttonIndex == 3)
        {
            /*! 刷新 */
            [self.webView ba_web_reload];
        }
    }];
}

#pragma mark 关闭按钮点击
- (void)colseBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - setter / getter
- (BAWebView *)webView
{
    return BAKit_Lazy(_webView, ({
        BAWebView *webView = [BAWebView new];
        [webView canGoBack];
        [webView canGoForward];
        webView.tintColor = BAKit_Color_Cyan;
        
        [self.view addSubview:webView];
        webView;
    }));
}

- (void)setViewModel:(BAWebViewModel *)viewModel
{
    _viewModel = viewModel;
}










@end
