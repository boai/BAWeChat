
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

#import <UIKit/UIKit.h>

/*! Common transition types. */
typedef NS_ENUM(NSUInteger, BATransitionType) {
    /*! 淡入淡出 */
    BATransitionTypeFade = 0,
    /*! 推挤 */
    BATransitionTypePush,
    /*! 揭开 */
    BATransitionTypeReveal,
    /*! 覆盖 */
    BATransitionTypeMoveIn,
    /*! 立方体 */
    BATransitionTypeCube,
    /*! 吮吸 */
    BATransitionTypeSuckEffect,
    /*! 翻转 */
    BATransitionTypeOglFlip,
    /*! 波纹 */
    BATransitionTypeRippleEffect,
    /*! 翻页 */
    BATransitionTypePageCurl,
    /*! 反翻页 */
    BATransitionTypePageUnCurl,
    /*! 开镜头 */
    BATransitionTypeCameraIrisHollowOpen,
    /*! 关镜头 */
    BATransitionTypeCameraIrisHollowClose,
};

/*! Common transition subtypes. */
typedef NS_ENUM(NSUInteger, BATransitionSubtype) {
    BATransitionSubtypeFromRight = 0,
    BATransitionSubtypeFromLeft,
    BATransitionSubtypeFromTop,
    BATransitionSubtypeFromBottom
};

/*!  Timing function names.  */
typedef NS_ENUM(NSUInteger, BATransitionTimingFunctionType) {
    /*! 默认 */
    BATransitionTimingFunctionTypeDefault = 0,
    /*! 线性,即匀速 */
    BATransitionTimingFunctionTypeLinear,
    /*! 先慢后快 */
    BATransitionTimingFunctionTypeEaseIn,
    /*! 先快后慢 */
    BATransitionTimingFunctionTypeEaseOut,
    /*! 先慢后快再慢 */
    BATransitionTimingFunctionTypeEaseInEaseOut
};


@interface UIView (BATransition)

/*!
 *  CATransition动画实现
 *
 *  @param type                转场动画类型【过渡效果】，默认：BATransitionTypeFade
 *  @param subType             转场动画将去的方向，默认：BATransitionSubtypeFromRight
 *  @param duration            转场动画持续时间，默认：0.8f
 *  @param timingFunction      计时函数，从头到尾的流畅度，默认：BATransitionTimingFunctionTypeDefault
 *  @param removedOnCompletion 在动画执行完时是否被移除，默认：YES
 *  @param forView             添加动画（转场动画是添加在层上的动画）
 */
- (void)ba_transitionWithType:(BATransitionType)type
                      subType:(BATransitionSubtype)subType
                     duration:(CFTimeInterval)duration
               timingFunction:(BATransitionTimingFunctionType)timingFunction
          removedOnCompletion:(BOOL)removedOnCompletion
                      forView:(UIView *)forView;

/*!
 *  UIView实现动画
 *
 *  @param duration       转场动画持续时间，默认：0.8f
 *  @param animationCurve 动画曲线，默认：UIViewAnimationCurveEaseInOut
 *  @param transition     动画过渡，默认：UIViewAnimationTransitionNone
 *  @param forView        添加动画（转场动画是添加在层上的动画）
 */
- (void)ba_transitionViewWithDuration:(CFTimeInterval)duration
                       animationCurve:(UIViewAnimationCurve)animationCurve
                           transition:(UIViewAnimationTransition)transition
                              forView:(UIView *)forView;

@end
