//
//  BABaseViewController.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@class BAKit_ClearCacheManager;
typedef void (^BannerBlock)(NSInteger index);

@interface BABaseViewController : QMUICommonViewController

@property(nonatomic, copy)   BannerBlock bannerBlock;
//@property(nonatomic, strong) SDCycleScrollView *cycleScrollView;


- (void)base_viewWillAppear;
- (void)base_viewWillDisappear;
- (void)base_viewDidDisappear;
- (void)setupUI;
- (void)setupNavi;

- (void)gotoScanVC;

- (void)gotoWebWithUrl:(NSString *)url;
- (void)gotoWebWithHtmlString:(NSString *)htmlString
                        title:(NSString *)title;
- (void)gotoWebWithRequest:(NSURLRequest *)request;
- (void)gotoWebWithHtmlFileName:(NSString *)htmlFileName;

//- (SDCycleScrollView *)setupBannerViewWithFrame:(CGRect)frame
//                                 imageUrlsArray:(NSArray *)imageUrlsArray
//                                    titlesArray:(NSArray *)titlesArray
//                                withBannerBlock:(BannerBlock)bannerBlock;
//- (SDCycleScrollView *)setupUploadViewWithFrame:(CGRect)frame
//                                 imageUrlsArray:(NSArray *)imageUrlsArray
//                                      withBlock:(BannerBlock)block;

/*！
 自定义动画样式

 @param type 动画样式
 @param animationView 需要动画的 View
 */
- (void)ba_animationWithBATransitionType:(BATransitionType)type
                           animationView:(UIView *)animationView;

#pragma mark - 清理缓存
- (void)ba_clearCacheWithBlock:(void (^)(NSInteger buttonIndex, BAKit_ClearCacheManager *clearCacheManager, CGFloat cacheSize))block;


@end
