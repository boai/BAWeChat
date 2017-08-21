
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

#if TARGET_OS_IOS
typedef void (^UIAlertControllerPopoverPresentationControllerBlock) (UIPopoverPresentationController * __nonnull popover);
#endif
typedef void (^UIAlertControllerCompletionBlock) (UIAlertController * __nonnull controller, UIAlertAction * __nonnull action, NSInteger buttonIndex);

@interface UIAlertController (Blocks)

@property (readonly, nonatomic) BOOL visible;

/**
 快速创建一个系统 Alert 或者 ActionSheet

 @param viewController 显示的VC
 @param title title
 @param mutableAttributedTitle mutableAttributedTitle
 @param message message
 @param mutableAttributedMessage mutableAttributedMessage
 @param preferredStyle 选择 alert 样式 或者 ActionSheet 样式
 @param buttonTitlesArray 按钮数组
 @param buttonTitleColorArray 按钮颜色数组，默认：系统蓝色，如果颜色数组个数小于title数组个数，则全部为默认蓝色
 @param popoverPresentationControllerBlock popoverPresentationControllerBlock
 @param tapBlock tapBlock
 @return 一个系统 Alert 或者 ActionSheet
 */
+ (nonnull instancetype)ba_alertControllerShowInViewController:(nonnull UIViewController *)viewController
                                   withTitle:(nullable NSString *)title
                      mutableAttributedTitle:(nullable NSMutableAttributedString *)mutableAttributedTitle
                                     message:(nullable NSString *)message
                    mutableAttributedMessage:(nullable NSMutableAttributedString *)mutableAttributedMessage
                              preferredStyle:(UIAlertControllerStyle)preferredStyle
                           buttonTitlesArray:(nullable NSArray *)buttonTitlesArray
                       buttonTitleColorArray:(nullable NSArray <UIColor *>*)buttonTitleColorArray
#if TARGET_OS_IOS
          popoverPresentationControllerBlock:(nullable UIAlertControllerPopoverPresentationControllerBlock)popoverPresentationControllerBlock
#endif
                                    tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;

/**
 快速创建一个系统 Alert

 @param viewController 显示的VC
 @param title title
 @param mutableAttributedTitle mutableAttributedTitle
 @param message message
 @param mutableAttributedMessage mutableAttributedMessage
 @param buttonTitlesArray 按钮数组
 @param buttonTitleColorArray 按钮颜色数组，默认：系统蓝色，如果颜色数组个数小于title数组个数，则全部为默认蓝色
 @param tapBlock tapBlock
 @return Alert
 */
+ (nonnull instancetype)ba_alertControllerShowAlertInViewController:(nonnull UIViewController *)viewController
                                        withTitle:(nullable NSString *)title
                           mutableAttributedTitle:(nullable NSMutableAttributedString *)mutableAttributedTitle
                                          message:(nullable NSString *)message
                         mutableAttributedMessage:(nullable NSMutableAttributedString *)mutableAttributedMessage
                                buttonTitlesArray:(nullable NSArray *)buttonTitlesArray
                            buttonTitleColorArray:(nullable NSArray <UIColor *>*)buttonTitleColorArray
                                         tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;

/**
 快速创建一个系统 ActionSheet

 @param viewController 显示的VC
 @param title title
 @param mutableAttributedTitle mutableAttributedTitle
 @param message message
 @param mutableAttributedMessage mutableAttributedMessage
 @param buttonTitlesArray 按钮数组
 @param buttonTitleColorArray 按钮颜色数组，默认：系统蓝色，如果颜色数组个数小于title数组个数，则全部为默认蓝色
 @param popoverPresentationControllerBlock popoverPresentationControllerBlock description
 @param tapBlock tapBlock description
 @return ActionSheet
 */
+ (nonnull instancetype)ba_alertControllerShowActionSheetInViewController:(nonnull UIViewController *)viewController
                                              withTitle:(nullable NSString *)title
                                 mutableAttributedTitle:(nullable NSMutableAttributedString *)mutableAttributedTitle
                                                message:(nullable NSString *)message
                               mutableAttributedMessage:(nullable NSMutableAttributedString *)mutableAttributedMessage
                                      buttonTitlesArray:(nullable NSArray *)buttonTitlesArray
                                  buttonTitleColorArray:(nullable NSArray <UIColor *>*)buttonTitleColorArray
#if TARGET_OS_IOS
                     popoverPresentationControllerBlock:(nullable UIAlertControllerPopoverPresentationControllerBlock)popoverPresentationControllerBlock
#endif
                                               tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;

@end
