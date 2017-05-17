
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
 * 博客    : http://boaihome.com
 
 *********************************************************************************
 
 */


#import "UIView+BAAnimation.h"

@implementation UIView (BAAnimation)

/*!
 *  缩放显示动画
 *
 *  @param duration    持续时间，默认：1.0f
 *  @param scaleRatio  缩放比率，默认：1.6f
 *  @param finishBlock 缩放完成回调
 */
- (void)ba_animation_scaleShowWithDuration:(CGFloat)duration
                                 ratio:(CGFloat)scaleRatio
                           finishBlock:(void(^)())finishBlock
{
    if (!duration)
    {
        duration = 1.0f;
    }
    if (!scaleRatio)
    {
        scaleRatio = 1.6f;
    }

    self.transform = CGAffineTransformScale(self.transform, 0.01f, 0.01f);
    
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            self.transform = CGAffineTransformIdentity;
//            self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        } completion:^(BOOL finished) {
            if (finishBlock)
            {
                finishBlock();
            }
        }];
    }];
}

/*!
 *  缩放消失动画
 *
 *  @param duration    持续时间，默认：1.0f
 *  @param scaleRatio  缩放比率，默认：1.6f
 *  @param finishBlock 缩放完成回调
 */
- (void)ba_animation_scaleDismissWithDuration:(CGFloat)duration
                                 ratio:(CGFloat)scaleRatio
                           finishBlock:(void(^)())finishBlock
{
    if (!duration)
    {
        duration = 1.0f;
    }
    if (!scaleRatio)
    {
        scaleRatio = 1.6f;
    }

    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            self.transform = CGAffineTransformMakeScale(0.0001f, 0.0001f);
        } completion:^(BOOL finished) {
            if (finishBlock) {
                finishBlock();
            }
        }];
    }];
}

/*!
 *  透明度动画
 *
 *  @param duration    持续时间，默认：1.5f
 *  @param startAlpha  开始的 alpha，默认：0.2f
 *  @param finishAlpha 结束的 alpha，默认：1.0f
 */
- (void)ba_animation_alphaWithDuration:(CGFloat)duration
                            startAlpha:(CGFloat)startAlpha
                           finishAlpha:(CGFloat)finishAlpha
{
    if (!duration)
    {
        duration = 1.5f;
    }
    if (!startAlpha)
    {
        startAlpha = 0.2f;
    }
    if (!finishAlpha)
    {
        finishAlpha = 1.0f;
    }
    [UIView animateWithDuration:duration animations:^{
        self.alpha = startAlpha;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            self.alpha = finishAlpha;
        }];
    }];
}

/*!
 *  转场动画
 *
 *  @param duration      持续时间，默认：1.5f
 *  @param startOptions  开始转场动画样式
 *  @param finishOptions 结束转场动画样式
 *  @param finishBlock   转场结束回调
 */
- (void)ba_animation_transitionWithDuration:(CGFloat)duration
                               startOptions:(UIViewAnimationOptions)startOptions
                               finishOptions:(UIViewAnimationOptions)finishOptions
                                finishBlock:(void(^)())finishBlock
{
    if (!duration)
    {
        duration = 1.5f;
    }
    [UIView transitionWithView:self duration:duration options:startOptions animations:^{
        
    } completion:^(BOOL finished) {
        [UIView transitionWithView:self duration:duration options:finishOptions animations:^{
            
        } completion:^(BOOL finished) {
            if (finishBlock)
            {
                finishBlock();
            }
        }];
    }];
}

/*!
 *  改变 frame 动画
 *
 *  @param duration      持续时间，默认：1.5f
 *  @param originalFrame 原始 frame
 *  @param newFrame      更改后的 frame
 *  @param finishBlock   结束回调
 */
- (void)ba_animation_changFrameWithDuration:(CGFloat)duration
                              originalFrame:(CGRect)originalFrame
                                   newFrame:(CGRect)newFrame
                                finishBlock:(void(^)())finishBlock
{
    if (!duration)
    {
        duration = 1.5f;
    }
    [UIView animateWithDuration:1.0f animations:^{
        self.frame = newFrame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0f animations:^{
            self.frame = originalFrame;
        } completion:^(BOOL finished) {
            if (finishBlock)
            {
                finishBlock();
            }
        }];
    }];
}

/*!
 *  改变 Bounds 动画
 *
 *  @param duration       持续时间，默认：1.5f
 *  @param originalBounds 原始 Bounds
 *  @param newBounds      更改后的 Bounds
 *  @param finishBlock    结束回调
 */
- (void)ba_animation_changBoundsWithDuration:(CGFloat)duration
                              originalBounds:(CGRect)originalBounds
                                   newBounds:(CGRect)newBounds
                                finishBlock:(void(^)())finishBlock
{
    if (!duration)
    {
        duration = 1.5f;
    }
    [UIView animateWithDuration:duration animations:^{
        self.bounds = newBounds;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0f animations:^{
            self.bounds = originalBounds;
        }];
    }];
}

/*!
 *  改变 Center 动画
 *
 *  @param duration       持续时间，默认：1.5f
 *  @param originalCenter 原始 Center
 *  @param newCenter      更改后的 Center
 *  @param finishBlock    结束回调
 */
- (void)ba_animation_changCenterWithDuration:(CGFloat)duration
                              originalCenter:(CGPoint)originalCenter
                                   newCenter:(CGPoint)newCenter
                                 finishBlock:(void(^)())finishBlock
{
    if (!duration)
    {
        duration = 1.5f;
    }
    [UIView animateWithDuration:0.5f animations:^{
        self.center = newCenter;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5f animations:^{
            self.center = originalCenter;
        }];
    }];
}

/*!
 *  弹簧动画
 *
 *  @param duration              持续时间，默认：1.5f
 *  @param damping               弹性比率，默认：1.0f
 *  @param initialSpringVelocity 初始弹簧速度，默认：3.0f
 *  @param startOptions          开始动画样式
 *  @param finishOptions         开始动画样式
 *  @param startBlock            开始动画回调
 *  @param finishBlock           结束动画回调
 */
- (void)ba_animation_springWithDuration:(CGFloat)duration
                                damping:(CGFloat)damping
                  initialSpringVelocity:(CGFloat)initialSpringVelocity
                           startOptions:(UIViewAnimationOptions)startOptions
                          finishOptions:(UIViewAnimationOptions)finishOptions
                            startBlock:(void(^)())startBlock
                            finishBlock:(void(^)())finishBlock
{
    if (!duration)
    {
        duration = 1.5f;
    }
    if (!damping)
    {
        damping = 1.0f;
    }
    if (!initialSpringVelocity)
    {
        initialSpringVelocity = 3.0f;
    }
    [UIView animateWithDuration:duration delay:0.f usingSpringWithDamping:damping initialSpringVelocity:initialSpringVelocity options:startOptions animations:^{
        if (startBlock)
        {
            startBlock();
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:0.f usingSpringWithDamping:damping initialSpringVelocity:initialSpringVelocity options:finishOptions animations:^{
            if (finishBlock)
            {
                finishBlock();
            }
        } completion:^(BOOL finished) {
            
        }];
    }];
}



@end
