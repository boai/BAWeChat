
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

typedef NS_ENUM(NSUInteger, BALoadingViewType) {
    /*! 三个小球横向滚动 */
    BALoadingViewTypeBall = 0,
    /*! 三个小球旋转 */
    BALoadingViewTypeBallRotation,
    /*! win 10 加载动画 */
    BALoadingViewTypeWin10
};

@interface BAKit_LoadingView : UIView

/*! 加载动画的样式 */
@property (nonatomic, assign) BALoadingViewType loadingType;

/*! 仅限样式1 的颜色数组，默认为：@[[UIColor greenColor], [UIColor redColor], [UIColor blueColor]];
 */
@property (nonatomic, strong) NSArray <UIColor *>*ballColorsArray;
/*! 仅限样式 2、样式 3、样式 4 的主题颜色，默认：2为红色，3为绿色，4为灰色 */
@property (nonatomic, strong) UIColor *themColor;

/*! 仅限样式 1 和 样式 2 的小球的大小【0-30之间最佳】，默认：20 */
@property (nonatomic, assign) CGFloat ballSize;



@end
