
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



typedef void(^GestureOpertation)(UIGestureRecognizer *gesture);

@interface UIGestureRecognizer (Opertation)

@property (nonatomic, copy, readonly) GestureOpertation opertation;
@property (nonatomic, copy, readonly) GestureOpertation beganOpertation;
@property (nonatomic, copy, readonly) GestureOpertation changedOpertation;
@property (nonatomic, copy, readonly) GestureOpertation cancelledOpertation;
@property (nonatomic, copy, readonly) GestureOpertation endOpertation;
@property (nonatomic, copy, readonly) GestureOpertation failedOpertation;
@property (nonatomic, copy, readonly) GestureOpertation swipeRightOpertation;
@property (nonatomic, copy, readonly) GestureOpertation swipeLeftOpertation;
@property (nonatomic, copy, readonly) GestureOpertation swipeUpOpertation;
@property (nonatomic, copy, readonly) GestureOpertation swipeDownOpertation;

/**
 *  添加操作,此方法用于点按手势
 *
 *  @param opertation 操作
 *
 *  @return self 可以继续掉后续方法
 */
- (instancetype)addOpertation:(GestureOpertation)opertation;
/**
 *  添加开始操作
 *
 *  @param beganOpertation 操作
 *
 *  @return self 可以继续掉后续方法
 */
- (instancetype)addBeganOpertation:(GestureOpertation)beganOpertation;
/**
 *  添加改变时的操作
 *
 *  @param changedOpertation 操作
 *
 *  @return self 可以继续掉后续方法
 */
- (instancetype)addChangedOpertation:(GestureOpertation)changedOpertation;
/**
 *  添加取消时的操作
 *
 *  @param cancelledOpertation 操作
 *
 *  @return self 可以继续掉后续方法
 */
- (instancetype)addCancelledOpertation:(GestureOpertation)cancelledOpertation;
/**
 *  添加结束时操作
 *
 *  @param endOpertation 操作
 *
 *  @return self 可以继续掉后续方法
 */
- (instancetype)addEndOpertation:(GestureOpertation)endOpertation;
/**
 *  添加失败时的操作
 *
 *  @param failedOpertation 操作
 *
 *  @return self 可以继续掉后续方法
 */
- (instancetype)addFailedOpertation:(GestureOpertation)failedOpertation;

/**
 *  添加向右轻扫时操作
 *
 *  @param swipeRightOpertation 操作
 *
 *  @return self 可以继续掉后续方法
 */
- (instancetype)addSwipeRightOpertation:(GestureOpertation)swipeRightOpertation;
/**
 *  添加向左轻扫时操作
 *
 *  @param swipeLeftOpertation 操作
 *
 *  @return self 可以继续掉后续方法
 */
- (instancetype)addSwipeLeftOpertation:(GestureOpertation)swipeLeftOpertation;
/**
 *  添加向上轻扫时操作
 *
 *  @param swipeUpOpertation 操作
 *
 *  @return self 可以继续掉后续方法
 */
- (instancetype)addSwipeUpOpertation:(GestureOpertation)swipeUpOpertation;
/**
 *  添加向下轻扫时操作
 *
 *  @param swipeDownOpertation 操作
 *
 *  @return self 可以继续掉后续方法
 */
- (instancetype)addSwipeDownOpertation:(GestureOpertation)swipeDownOpertation;

@end
