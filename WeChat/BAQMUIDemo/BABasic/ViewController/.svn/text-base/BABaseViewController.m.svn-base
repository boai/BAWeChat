//
//  BABaseViewController.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BABaseViewController.h"
#import "SDCycleScrollView.h"

#import "BAWebViewController.h"
#import "BAWebViewModel.h"

#import "LBXScanView.h"
#import "BAScanViewController.h"

@interface BABaseViewController ()


@end

@implementation BABaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self base_viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self base_viewWillDisappear];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];

    [self base_viewDidDisappear];
}
    
    
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorWhite;
    
    [self setupUI];
    [self setupNavi];
    
//    [BAKit_FPSLabel ba_showInWindow:[UIApplication sharedApplication].keyWindow];

}

- (void)setupUI
{
    
}

- (void)setupNavi
{
    
}

- (void)base_viewWillAppear
{
    
}
    
- (void)base_viewWillDisappear
{
//    removeAllObjects_viewWillDisappear
}
    
- (void)base_viewDidDisappear
{
    //    removeAllObjects_viewDidDisappear
}

- (void)gotoScanVC
{
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    //BAScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    BAScanViewController *vc = [BAScanViewController new];
    vc.style = style;
    
    vc.isQQSimulator = YES;
    vc.isVideoZoom = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoWebWithUrl:(NSString *)url
{
    BAWebViewModel *model = [[BAWebViewModel alloc] initWithParams:@{RequestURLkey:url}];
    BAWebViewController *webVC = [[BAWebViewController alloc] init];
    webVC.viewModel = model;
    
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)gotoWebWithHtmlString:(NSString *)htmlString title:(NSString *)title
{
    BAWebViewModel *model = [[BAWebViewModel alloc] initWithParams:@{RequestHtmlStringkey: htmlString, WebTitlekey: title}];
    BAWebViewController *webVC = [[BAWebViewController alloc] init];
    webVC.viewModel = model;
    
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)gotoWebWithRequest:(NSURLRequest *)request
{
    BAWebViewController *webVC = [[BAWebViewController alloc] init];
    webVC.request = request;
    
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)gotoWebWithHtmlFileName:(NSString *)htmlFileName
{
    BAWebViewController *webVC = [[BAWebViewController alloc] init];
    webVC.htmlFileName = htmlFileName;
    
    [self.navigationController pushViewController:webVC animated:YES];
}

- (SDCycleScrollView *)setupBannerViewWithFrame:(CGRect)frame
                                 imageUrlsArray:(NSArray *)imageUrlsArray
                                    titlesArray:(NSArray *)titlesArray
                                withBannerBlock:(BannerBlock)bannerBlock
{
//    CGRect cycleScrollViewFrame = BAKit_CGRectFlatMake(0, 0, SCREEN_WIDTH, kBannerView_H);
    
    if (!self.cycleScrollView)
    {
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:(id<SDCycleScrollViewDelegate>)self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        //    cycleScrollView.titlesGroup = titlesArray;
        cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        cycleScrollView.imageURLStringsGroup = imageUrlsArray;
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        //    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
        //         --- 轮播时间间隔，默认1.0秒，可自定义
        cycleScrollView.autoScrollTimeInterval = 2.0f;
        
        if (bannerBlock)
        {
            cycleScrollView.clickItemOperationBlock = ^(NSInteger index) {
                bannerBlock(index);
            };
        }
        self.cycleScrollView = cycleScrollView;
    }
    
    return self.cycleScrollView;
}

- (SDCycleScrollView *)setupUploadViewWithFrame:(CGRect)frame
                                 imageUrlsArray:(NSArray *)imageUrlsArray
                                      withBlock:(BannerBlock)block
{    
    if (!self.cycleScrollView)
    {
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame imageNamesGroup:imageUrlsArray];
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        //    cycleScrollView.titlesGroup = titlesArray;
        cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        cycleScrollView.imageURLStringsGroup = imageUrlsArray;
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        //    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
        //         --- 轮播时间间隔，默认1.0秒，可自定义
        cycleScrollView.autoScroll = NO;
        
        if (block)
        {
            cycleScrollView.clickItemOperationBlock = ^(NSInteger index) {
                block(index);
            };
        }
        self.cycleScrollView = cycleScrollView;
    }
    
    return self.cycleScrollView;
}

/*！
 自定义动画样式
 
 @param type 动画样式
 @param animationView 需要动画的 View
 */
- (void)ba_animationWithBATransitionType:(BATransitionType)type
                           animationView:(UIView *)animationView
{
    switch (type) {
        case 0:
            [self ba_transitonWithType:BATransitionTypeFade view:animationView];
            break;
            
        case 1:
            [self ba_transitonWithType:BATransitionTypePush view:animationView];
            break;
            
        case 2:
            [self ba_transitonWithType:BATransitionTypeReveal view:animationView];
            break;
            
        case 3:
            [self ba_transitonWithType:BATransitionTypeMoveIn view:animationView];
            break;
            
        case 4:
            [self ba_transitonWithType:BATransitionTypeCube view:animationView];
            break;
            
        case 5:
            [self ba_transitonWithType:BATransitionTypeSuckEffect view:animationView];
            break;
            
        case 6:
            [self ba_transitonWithType:BATransitionTypeOglFlip view:animationView];
            break;
            
        case 7:
            [self ba_transitonWithType:BATransitionTypeRippleEffect view:animationView];
            break;
            
        case 8:
            [self ba_transitonWithType:BATransitionTypePageCurl view:animationView];
            break;
            
        case 9:
            [self ba_transitonWithType:BATransitionTypePageUnCurl view:animationView];
            break;
            
        case 10:
            [self ba_transitonWithType:BATransitionTypeCameraIrisHollowOpen view:animationView];
            break;
            
        case 11:
            [self ba_transitonWithType:BATransitionTypeCameraIrisHollowClose view:animationView];
            break;
            
        case 12:
            [animationView ba_transitionViewWithDuration:0.8f
                                       animationCurve:UIViewAnimationCurveEaseInOut transition:UIViewAnimationTransitionCurlDown
                                              forView:animationView];
            break;
            
        case 13:
            [animationView ba_transitionViewWithDuration:0.8f
                                       animationCurve:UIViewAnimationCurveEaseInOut transition:UIViewAnimationTransitionCurlUp
                                              forView:animationView];
            break;
            
        case 14:
            [animationView ba_transitionViewWithDuration:0.8f
                                       animationCurve:UIViewAnimationCurveEaseInOut transition:UIViewAnimationTransitionFlipFromLeft
                                              forView:animationView];
            break;
            
        case 15:
            [animationView ba_transitionViewWithDuration:0.8f
                                       animationCurve:UIViewAnimationCurveEaseInOut transition:UIViewAnimationTransitionFlipFromRight
                                              forView:animationView];
            break;
            
        default:
            break;
    }
    
}

- (void)ba_transitonWithType:(BATransitionType)type view:(UIView *)animationView
{
    [animationView ba_transitionWithType:type
                              subType:BATransitionSubtypeFromLeft
                             duration:0.8f
                       timingFunction:BATransitionTimingFunctionTypeEaseInEaseOut
                  removedOnCompletion:YES
                              forView:animationView];
}

#pragma mark - 清理缓存
- (void)ba_clearCacheWithBlock:(void (^)(NSInteger buttonIndex, BAKit_ClearCacheManager *clearCacheManager, CGFloat cacheSize))block
{
    BAKit_ClearCacheManager *clearCacheManager = [BAKit_ClearCacheManager ba_sharedCache];
    CGFloat cacheSize = [clearCacheManager ba_loadCacheSize];
    
    NSString *clearMessage = [NSString stringWithFormat:@"缓存大小为：%.2fM，确定要清理吗?", cacheSize];
    
    [UIAlertController ba_alertControllerShowAlertInViewController:self withTitle:@"温馨提示：" mutableAttributedTitle:nil message:clearMessage mutableAttributedMessage:nil buttonTitlesArray:@[@"取 消", @"确 定"] buttonTitleColorArray:@[UIColorGreen, UIColorRed] tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        
        if (block)
        {
            block(buttonIndex, clearCacheManager, cacheSize);
        }
        
        return;
    }];


}




#pragma mark - setter/getter
//- (void)setBannerBlock:(BannerBlock)bannerBlock
//{
//    _bannerBlock = bannerBlock;
//}

- (void)dealloc
{
    [self base_viewDidDisappear];
}

@end
