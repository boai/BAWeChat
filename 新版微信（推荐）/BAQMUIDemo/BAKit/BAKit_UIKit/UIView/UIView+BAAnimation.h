
/*!
 *  @header BAKit.h
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright  Copyright © 2016年 博爱. All rights reserved.
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
 * 在使用 BAKit 的过程中如果出现 bug 请及时以以下任意一种方式联系我，我会及时修复 bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * BAHome : https://github.com/BAHome
 * 博客    : http://boaihome.com
 
 *********************************************************************************
 
 */


#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>


/**
 view 的 进出场动画 方向

 - BAKit_ViewAnimationEnterDirectionTypeTop: 从 top 进入
 - BAKit_ViewAnimationEnterDirectionTypeLeft: 从 left 进入
 - BAKit_ViewAnimationEnterDirectionTypeBottom: 从 bottom 进入
 - BAKit_ViewAnimationEnterDirectionTypeRitht: 从 right 进入
 */
typedef NS_ENUM(NSUInteger, BAKit_ViewAnimationEnterDirectionType) {
    BAKit_ViewAnimationEnterDirectionTypeTop,
    BAKit_ViewAnimationEnterDirectionTypeLeft,
    BAKit_ViewAnimationEnterDirectionTypeBottom,
    BAKit_ViewAnimationEnterDirectionTypeRitht,
};

/**
 view 的 翻动动画 方向

 - BAKit_ViewAnimationFlipDirectionTypeTop: 向 top 翻动
 - BAKit_ViewAnimationFlipDirectionTypeLeft: 向 left 翻动
 - BAKit_ViewAnimationFlipDirectionTypeBottom: 向 bottom 翻动
 - BAKit_ViewAnimationFlipDirectionTypeRight: 向 right 翻动
 */
typedef NS_ENUM(NSUInteger, BAKit_ViewAnimationFlipDirectionType)
{
    BAKit_ViewAnimationFlipDirectionTypeTop = 0,
    BAKit_ViewAnimationFlipDirectionTypeLeft,
    BAKit_ViewAnimationFlipDirectionTypeBottom,
    BAKit_ViewAnimationFlipDirectionTypeRight,
};

/**
 *  Direction of the translation
 */
typedef NS_ENUM(NSInteger, UIViewAnimationTranslationDirection)
{
    /**
     *  Translation from left to right
     */
    UIViewAnimationTranslationDirectionFromLeftToRight = 0,
    /**
     *  Translation from right to left
     */
    UIViewAnimationTranslationDirectionFromRightToLeft
};

/**
 *  Direction of the linear gradient
 */
typedef NS_ENUM(NSInteger, UIViewLinearGradientDirection)
{
    /**
     *  Linear gradient vertical
     */
    UIViewLinearGradientDirectionVertical = 0,
    /**
     *  Linear gradient horizontal
     */
    UIViewLinearGradientDirectionHorizontal,
    /**
     *  Linear gradient from left to right and top to down
     */
    UIViewLinearGradientDirectionDiagonalFromLeftToRightAndTopToDown,
    /**
     *  Linear gradient from left to right and down to top
     */
    UIViewLinearGradientDirectionDiagonalFromLeftToRightAndDownToTop,
    /**
     *  Linear gradient from right to left and top to down
     */
    UIViewLinearGradientDirectionDiagonalFromRightToLeftAndTopToDown,
    /**
     *  Linear gradient from right to left and down to top
     */
    UIViewLinearGradientDirectionDiagonalFromRightToLeftAndDownToTop
};


@interface UIView (BAAnimation)

/*!
 *  缩放显示动画
 *
 *  @param duration    持续时间，默认：1.0f
 *  @param scaleRatio  缩放比率，默认：1.6f
 *  @param finishBlock 缩放完成回调
 */
- (void)ba_animation_scaleShowWithDuration:(CGFloat)duration
                                     ratio:(CGFloat)scaleRatio
                               finishBlock:(void(^)())finishBlock;

/*!
 *  缩放消失动画
 *
 *  @param duration    持续时间，默认：1.0f
 *  @param scaleRatio  缩放比率，默认：1.6f
 *  @param finishBlock 缩放完成回调
 */
- (void)ba_animation_scaleDismissWithDuration:(CGFloat)duration
                                        ratio:(CGFloat)scaleRatio
                                  finishBlock:(void(^)())finishBlock;

/*!
 *  透明度动画
 *
 *  @param duration    持续时间，默认：1.5f
 *  @param startAlpha  开始的 alpha，默认：0.2f
 *  @param finishAlpha 结束的 alpha，默认：1.0f
 */
- (void)ba_animation_alphaWithDuration:(CGFloat)duration
                            startAlpha:(CGFloat)startAlpha
                           finishAlpha:(CGFloat)finishAlpha;

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
                                finishBlock:(void(^)())finishBlock;

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
                                finishBlock:(void(^)())finishBlock;

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
                                finishBlock:(void(^)())finishBlock;

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
                                 finishBlock:(void(^)())finishBlock;

/*!
 *  弹簧动画
 *
 *  @param duration              持续时间，默认：1.5f
 *  @param damping               弹性比率
 *  @param initialSpringVelocity 初始弹簧速度
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
                            finishBlock:(void(^)())finishBlock;

/**
 view 出现动画
 
 @param positionType 位置类型
 @param duration duration 默认：1.0f
 @param finishBlock finishBlock
 */
- (void)ba_animation_showFromPositionType:(BAKit_ViewAnimationEnterDirectionType)positionType
                                 duration:(CGFloat)duration
                              finishBlock:(void(^)())finishBlock;

/**
 view 消失动画
 
 @param positionType 位置类型
 @param duration duration 默认：1.0f
 @param finishBlock finishBlock
 */
- (void)ba_animation_dismissFromPositionType:(BAKit_ViewAnimationEnterDirectionType)positionType
                                    duration:(CGFloat)duration
                                 finishBlock:(void(^)())finishBlock;

/**
 view 翻转动画
 
 @param duration 位置类型
 @param direction duration 默认：1.0f
 */
- (void)ba_animation_flipWithDuration:(NSTimeInterval)duration
                            direction:(BAKit_ViewAnimationFlipDirectionType)direction;

- (void)translateAroundTheView:(UIView *)topView
                      duration:(CGFloat)duration
                     direction:(UIViewAnimationTranslationDirection)direction
                        repeat:(BOOL)repeat
                 startFromEdge:(BOOL)startFromEdge;

/**
 线性梯度：渐变色，注意：渐变颜色必须要有两个及两个以上颜色，否则设置无效！
 
 @param colorArray 颜色数组，至少两个
 @param frame frame
 @param direction 方向，横向还是纵向
 */
- (void)ba_createGradientWithColorArray:(NSArray *)colorArray
                                  frame:(CGRect)frame
                              direction:(UIViewLinearGradientDirection)direction;

@end


