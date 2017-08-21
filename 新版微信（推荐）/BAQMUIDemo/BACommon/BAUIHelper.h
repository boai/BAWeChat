
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

#import <Foundation/Foundation.h>

@interface BAUIHelper : NSObject

/*! 启动自定义QMUI的配置模板 */
+ (void)ba_setupConfigurationTemplate;
/*! 博爱自定义的全局样式渲染 */
+ (void)ba_renderGlobalAppearances;

@end

@interface BAUIHelper (QMUIModalPresentationViewController)

+ (void)ba_uiHelper_customMoreOperationAppearance;

@end

@interface BAUIHelper (QMUIAlertControllerAppearance)

+ (void)ba_uiHelper_customAlertControllerAppearance;

@end

@interface BAUIHelper (UITabBarItem)

+ (UITabBarItem *)ba_uiHelper_tabbarItemWithTitle:(NSString *)title
                                            image:(UIImage *)image
                                    selectedImage:(UIImage *)selectedImage
                               selectedTitleColor:(UIColor *)selectedTitleColor
                                              tag:(NSInteger)tag;

@end

@interface BAUIHelper (Button)

+ (QMUIButton *)ba_uiHelper_generateDarkFilledButton;
+ (QMUIButton *)ba_uiHelper_generateLightBorderedButton;
+ (QMUIButton *)ba_uiHelper_creatButtonWithTitle:(NSString *)title
                                        selTitle:(NSString *)selTitle
                                      titleColor:(UIColor *)titleColor
                                   titleFontSize:(CGFloat)titleFontSize
                                           image:(UIImage *)image
                                        selImage:(UIImage *)selImage
                                          target:(id)target
                                        selector:(SEL)sel;

@end

@interface NSString (Code)

- (void)ba_uiHelper_enumerateCodeStringBlock:(void (^)(NSString *codeString, NSRange codeRange))block;

@end

@interface BAUIHelper (SavePhoto)

+ (void)ba_uiHelper_showAlertWhenSavedPhotoFailuredByPermissionDenied;

@end

@interface BAUIHelper (Calculate)

+ (NSString *)ba_uiHelper_humanReadableFileSize:(long long)size;

@end


