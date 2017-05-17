//
//  BATimeLineRefreshHeader.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/24.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BATimeLineRefreshHeader.h"

#define kBATimeLineRefreshHeaderRotateAnimationKey @"RotateAnimationKey"
#define angle2Rad(angle) (angle / 180.0 * M_PI)


static const CGFloat criticalY = -60.f;

@interface BATimeLineRefreshHeader ()

@property (nonatomic, weak) UIImageView *imageView;
@property (assign, nonatomic) CGFloat insetTDelta;

@end

@implementation BATimeLineRefreshHeader
{
    CABasicAnimation *_rotateAnimation;
}

+ (instancetype)ba_headerWithRefreshingBlock:(BARefreshingBlock)refreshingBlock
{
    BATimeLineRefreshHeader *header = [[self alloc] init];
    header.refreshingBlock = refreshingBlock;
    
    return header;
}

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    self.backgroundColor = BAKit_ColorRed;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:BAKit_ImageBADiscoveryName(@"AlbumReflashIcon")];
    [self addSubview:imageView];
    self.imageView = imageView;
    
    _rotateAnimation = [[CABasicAnimation alloc] init];
    _rotateAnimation.keyPath = @"transform.rotation.z";
    _rotateAnimation.fromValue = @(0.0);
    _rotateAnimation.toValue = @(angle2Rad(360));
    _rotateAnimation.duration = 1.0f;
    _rotateAnimation.repeatCount = MAXFLOAT;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)layoutSubviews
{
    self.imageView.frame = CGRectMake(40, 45, self.imageView.image.size.width, self.imageView.image.size.height);
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    // 在刷新的refreshing状态
//    if (self.refreshState == BARefreshStateRefreshing)
//    {
//        if (self.window == nil) return;
//        
//        // sectionheader停留解决
//        CGFloat insetT = - self.scrollView.offsetY > _scrollViewOriginalInset.top ? - self.scrollView.offsetY : _scrollViewOriginalInset.top;
//        insetT = insetT > self.height + _scrollViewOriginalInset.top ? self.height + _scrollViewOriginalInset.top : insetT;
//        self.scrollView.insetT = insetT;
//        
//        self.insetTDelta = _scrollViewOriginalInset.top - insetT;
//        return;
//    }
//    
//    // 跳转到下一个控制器时，contentInset可能会变
//    _scrollViewOriginalInset = self.scrollView.contentInset;
//    
    // 当前的contentOffset
    CGFloat offY = self.scrollView.offsetY;
//    // 头部控件刚好出现的offsetY
//    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
//    
//    // 如果是向上滚动到看不见头部控件，直接返回
//    // >= -> >
//    if (offY > happenOffsetY) return;
//    
//    // 普通 和 即将刷新 的临界点
//    CGFloat normal2pullingOffsetY = happenOffsetY - self.height;

    CGFloat rotateValue = offY / 50.0 * M_PI;

////    if (offY < criticalY) {
////        offY = criticalY;
//    
//        if (self.scrollView.isDragging)
//        { // 如果正在拖拽
//            if (self.refreshState == BARefreshStateNormal && offY < normal2pullingOffsetY) {
//                // 转为即将刷新状态
//                self.refreshState = BARefreshStatePulling;
//            }
//            else if (self.refreshState == BARefreshStatePulling && offY >= normal2pullingOffsetY) {
//                // 转为普通状态
//                self.refreshState = BARefreshStateNormal;
//            }
//            if (self.refreshState != BARefreshStateWillRefresh)
//            {
//                self.refreshState = BARefreshStateWillRefresh;
//            }
//        }
//        else if (self.refreshState == BARefreshStatePulling)
//        {// 即将刷新 && 手松开
//            // 开始刷新
//            [self beginRefreshing];
//        }
//        else if (self.refreshState == BARefreshStateWillRefresh)
//        {
//            self.refreshState = BARefreshStateRefreshing;
//        }
////    }

    
    if (offY < criticalY) {
        offY = criticalY;
        
        if (self.scrollView.isDragging && self.refreshState != BARefreshStateWillRefresh)
        {
            self.refreshState = BARefreshStateWillRefresh;
        }
        else if (!self.scrollView.isDragging && self.refreshState == BARefreshStateWillRefresh)
        {
            self.refreshState = BARefreshStateRefreshing;
        }
    }

    
    if (self.refreshState == BARefreshStateRefreshing) return;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, 0, -offY);
    transform = CGAffineTransformRotate(transform, rotateValue);
    
    self.imageView.transform = transform;
    
}

- (void)setRefreshState:(BARefreshState)refreshState
{
    // 状态检查
    BARefreshState oldState = self.refreshState;
    if (refreshState == oldState) return;
    [super setRefreshState:refreshState];
    
    switch (refreshState) {
        case BARefreshStateNormal:
        {
            // 恢复inset和offset
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.scrollView.y = -100;
//                self.scrollView.insetT += self.insetTDelta;

            } completion:^(BOOL finished) {
            
                [UIView animateWithDuration:0.3f animations:^{
                    self.imageView.transform = CGAffineTransformIdentity;
                    [self.imageView.layer removeAnimationForKey:kBATimeLineRefreshHeaderRotateAnimationKey];
                }];
            }];
            
        }
            break;
        case BARefreshStateRefreshing:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                    CGFloat top = self.scrollViewOriginalInset.top + self.height;
                    // 增加滚动区域top
//                    self.scrollView.insetT = top;
//                    // 设置滚动位置
//                    [self.scrollView setContentOffset:CGPointMake(0, -top) animated:NO];
                    self.scrollView.y = top;

                } completion:^(BOOL finished) {
            
                    [self.imageView.layer addAnimation:_rotateAnimation forKey:kBATimeLineRefreshHeaderRotateAnimationKey];
                    [self executeRefreshingCallback];

                }];
            });
        }
            break;
        default:
            break;
    }
}

@end
