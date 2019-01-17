//
//  BARefreshHelper.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/27.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+BARefresh.h"

UIKIT_EXTERN NSString *const BARefreshKeyPathContentOffset;
UIKIT_EXTERN NSString *const BARefreshKeyPathContentSize;
UIKIT_EXTERN NSString *const BARefreshKeyPathContentInset;
UIKIT_EXTERN NSString *const BARefreshKeyPathPanState;

typedef NS_ENUM(NSUInteger, BARefreshState) {
    /** 普通闲置状态 */
    BARefreshStateNormal = 1,
    /** 即将刷新的状态 */
    BARefreshStateWillRefresh,
    /** 松开就可以进行刷新的状态 */
    BARefreshStatePulling,
    /** 正在刷新中的状态 */
    BARefreshStateRefreshing
};

typedef void (^BARefreshingBlock)();
/** 结束刷新后的回调 */
//typedef void (^BAEndRefreshingBlock)();

@interface BARefreshHelper : UIView
{
    /** 记录scrollView刚开始的inset */
    UIEdgeInsets _scrollViewOriginalInset;
    /** 父控件 */
    __weak UIScrollView *_scrollView;
}
/** 刷新状态 一般交给子类内部实现 */
@property (nonatomic, assign) BARefreshState refreshState;
@property (nonatomic, copy)   BARefreshingBlock refreshingBlock;
//@property (nonatomic, copy)   BAEndRefreshingBlock endRefreshingBlock;

/** 进入刷新状态 */
- (void)beginRefreshing;
- (void)endRefreshing;
/** 触发回调（交给子类去调用） */
- (void)executeRefreshingCallback;


#pragma mark - 交给子类去访问
/** 记录scrollView刚开始的inset */
@property (assign, nonatomic, readonly) UIEdgeInsets scrollViewOriginalInset;
/** 父控件 */
@property (weak, nonatomic, readonly) UIScrollView *scrollView;


#pragma mark - 交给子类们去实现
/** 初始化 */
- (void)prepare NS_REQUIRES_SUPER;
/** 摆放子控件frame */
- (void)placeSubviews NS_REQUIRES_SUPER;
/** 当scrollView的contentOffset发生改变的时候调用 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** 当scrollView的contentSize发生改变的时候调用 */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** 当scrollView的拖拽状态发生改变的时候调用 */
- (void)scrollViewPanStateDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;


@end
