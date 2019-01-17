
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
 
 */ //  自定义键盘输入类

#import <UIKit/UIKit.h>

/*!
 *  键盘输入框右边按钮
 */
typedef NS_ENUM(NSUInteger, BATimeLineKeyboardViewType) {
    /*!
     *  表情按钮
     */
    BATimeLineKeyboardViewTypeEmotionButton = 0,
    /*!
     *  更多按钮
     */
    BATimeLineKeyboardViewTypeMoreButton
};

/*!
 *  更多View 按钮
 */
typedef NS_ENUM(NSUInteger, BATimeLineKeyboardMoreViewType) {
    /*!
     *  照片按钮
     */
    BATimeLineKeyboardMoreViewTypePhotoButton = 0,
    /*!
     *  拍照按钮
     */
    BATimeLineKeyboardMoreViewTypeCameraButton,
    /*!
     *  位置按钮
     */
    BATimeLineKeyboardMoreViewTypeLocationButton,
    /*!
     *  视频按钮
     */
    BATimeLineKeyboardMoreViewTypeVideoButton
};

/*!
 *  键盘选择样式
 */
typedef NS_ENUM(NSUInteger, BATimeLineKeyboardInputViewType) {
    /*!
     *  默认文字输入
     */
    BATimeLineKeyboardInputViewTypeNormal = 0,
    /*!
     *  表情输入
     */
    BATimeLineKeyboardInputViewTypeEmotion,
    /*!
     *  自定义输入
     */
    BATimeLineKeyboardInputViewTypeMore
};

@interface BAKit_KeyboardView : UIView

/*!
 *  自定义键盘返回值，id 可为 NSString，也可为 NSMutableAttributedString
 */
@property (nonatomic, copy) void(^BATimeLineKeyboardViewReturnBlock)(id contentString);

/*!
 *  键盘选择样式
 */
@property (nonatomic, assign) BATimeLineKeyboardInputViewType inputViewType;

/*!
 *  输入框
 */
@property (nonatomic, strong) QMUITextView *commentTextView;

/*!
 *  是否显示表情按钮，默认不显示
 */
@property(nonatomic, assign, getter = isShowEmotionButton) BOOL showEmotionButton;

/*!
 *  是否显示更多按钮，默认不显示
 */
@property(nonatomic, assign, getter = isShowMoreButton) BOOL showMoreButton;


/*!
 *  弹出键盘
 */
- (void)ba_showKeyboardView;

/*!
 *  隐藏键盘
 */
- (void)ba_hideKeyboardView;





@end
