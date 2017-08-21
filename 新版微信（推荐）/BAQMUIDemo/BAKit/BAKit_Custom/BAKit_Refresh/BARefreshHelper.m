//
//  BARefreshHelper.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/27.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BARefreshHelper.h"


NSString *const BARefreshKeyPathContentOffset = @"contentOffset";
NSString *const BARefreshKeyPathContentInset = @"contentInset";
NSString *const BARefreshKeyPathContentSize = @"contentSize";
NSString *const BARefreshKeyPathPanState = @"refreshState";

@implementation BARefreshHelper

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    // 准备工作
    [self prepare];
    
    // 默认是普通状态
    self.refreshState = BARefreshStateNormal;
}

- (void)prepare
{
    // 基本属性
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews
{
    [self placeSubviews];
    
    [super layoutSubviews];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 如果不是UIScrollView，不做任何事情
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    
    // 旧的父控件移除监听
    [self removeObservers];
    
    if (newSuperview) { // 新的父控件
        // 设置宽度
        self.width = newSuperview.width;
        // 设置位置
        self.x = 0;
        
        // 记录UIScrollView
        _scrollView = (UIScrollView *)newSuperview;
        // 设置永远支持垂直弹簧效果
        _scrollView.alwaysBounceVertical = YES;
        // 记录UIScrollView最开始的contentInset
        _scrollViewOriginalInset = _scrollView.contentInset;
        
        // 添加监听
        [self addObservers];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.refreshState == BARefreshStateWillRefresh) {
        // 预防view还没显示出来就调用了beginRefreshing
        self.refreshState = BARefreshStateRefreshing;
    }
}

#pragma mark - KVO监听
- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:BARefreshKeyPathContentOffset options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:BARefreshKeyPathContentSize options:options context:nil];
}

- (void)removeObservers
{
    [self.superview removeObserver:self forKeyPath:BARefreshKeyPathContentOffset];
    [self.superview removeObserver:self forKeyPath:BARefreshKeyPathContentSize];;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 遇到这些情况就直接返回
    if (!self.userInteractionEnabled) return;
    
    // 这个就算看不见也需要处理
    if ([keyPath isEqualToString:BARefreshKeyPathContentSize]) {
        [self scrollViewContentSizeDidChange:change];
    }
    
    // 看不见
    if (self.hidden) return;
    if ([keyPath isEqualToString:BARefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    } else if ([keyPath isEqualToString:BARefreshKeyPathPanState]) {
        [self scrollViewPanStateDidChange:change];
    }
}



- (void)placeSubviews{}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change{}

- (void)setRefreshState:(BARefreshState)refreshState
{
    _refreshState = refreshState;
    
    // 加入主队列的目的是等setState:方法调用完毕、设置完文字后再去布局子控件
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsLayout];
    });
}

#pragma mark - 内部方法
- (void)executeRefreshingCallback
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.refreshingBlock) {
            self.refreshingBlock();
        }
    });
}

#pragma mark 进入刷新状态
- (void)beginRefreshing
{
//    [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
//        self.alpha = 1.0;
//    }];
//    // 只要正在刷新，就完全显示
//    if (self.window) {
//        self.refreshState = BARefreshStateRefreshing;
//    } else {
//        // 预防正在刷新中时，调用本方法使得header inset回置失败
//        if (self.refreshState != BARefreshStateRefreshing) {
//            self.refreshState = BARefreshStateWillRefresh;
//            // 刷新(预防从另一个控制器回到这个控制器的情况，回来要重新刷新一下)
//            [self setNeedsDisplay];
//        }
//    }
    self.refreshState = BARefreshStateRefreshing;
}

- (void)endRefreshing
{
    self.refreshState = BARefreshStateNormal;
}

@end
