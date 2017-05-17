
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
 
 */ //  手势封装

#import <UIKit/UIKit.h>
#import "UIGestureRecognizer+Opertation.h"

typedef NS_OPTIONS(NSUInteger, SwipeDirection) {
    SwipeDirectionRight = 1,
    SwipeDirectionLeft  = 2,
    SwipeDirectionUp    = 3,
    SwipeDirectionDown  = 4
};

@interface UIView (Gesture)
/**
 *  添加点按手势
 */
- (UITapGestureRecognizer *)addTapGestureRecognizer;
- (UITapGestureRecognizer *)addTapGestureRecognizer:(void(^)(UITapGestureRecognizer *tapGesture))tapGesture;
/**
 *  添加拖动手势
 */
- (UIPanGestureRecognizer *)addPanGestureRecognizer;
- (UIPanGestureRecognizer *)addPanGestureRecognizer:(void(^)(UIPanGestureRecognizer *panGesture))panGesture;
/**
 *  添加捏合手势
 */
- (UIPinchGestureRecognizer *)addPinchGestureRecognizer;
- (UIPinchGestureRecognizer *)addPinchGestureRecognizer:(void(^)(UIPinchGestureRecognizer *pinGesture))pinGesture;
/**
 *  添加旋转手势
 */
- (UIRotationGestureRecognizer *)addRotationGestureRecognizer;
- (UIRotationGestureRecognizer *)addRotationGestureRecognizer:(void(^)(UIRotationGestureRecognizer *rotationGesture))rotationGesture;
/**
 *  添加长按手势
 */
- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer;
- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(void(^)(UILongPressGestureRecognizer *longGesture))longGesture;
/**
 *  添加轻扫手势
 */
- (UISwipeGestureRecognizer *)addSwipeGestureRecognizer:(SwipeDirection)type;
- (UISwipeGestureRecognizer *)addSwipeGestureRecognizer:(SwipeDirection)type gestureRecognizer:(void(^)(UISwipeGestureRecognizer *swipeGesture))swipeGesture;
@end
