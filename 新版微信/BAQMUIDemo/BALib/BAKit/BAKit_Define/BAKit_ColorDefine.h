
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

#ifndef BAKit_ColorDefine_h
#define BAKit_ColorDefine_h

CG_INLINE UIColor *
BAKit_ColorWithRGBA(float r,float g,float b, float a){
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0];
}

CG_INLINE UIColor *
BAKit_ColorWithRGB(float r,float g,float b){
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

/*! 随机色 */
CG_INLINE UIColor *
BAKit_ColorRandom() {
     return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}

#pragma mark - Gray
#define UIColorGray1  BAKit_ColorWithRGB(53, 60, 70)
#define UIColorGray2  BAKit_ColorWithRGB(73, 80, 90)
#define UIColorGray3  BAKit_ColorWithRGB(93, 100, 110)
#define UIColorGray4  BAKit_ColorWithRGB(113, 120, 130)
#define UIColorGray5  BAKit_ColorWithRGB(133, 140, 150)
#define UIColorGray6  BAKit_ColorWithRGB(153, 160, 170)
#define UIColorGray7  BAKit_ColorWithRGB(173, 180, 190)
#define UIColorGray8  BAKit_ColorWithRGB(196, 200, 208)
#define UIColorGray9  BAKit_ColorWithRGB(216, 220, 228)
#define UIColorGray10 BAKit_ColorWithRGB(240, 240, 240)

#pragma mark - 常用颜色
/*! 微信主题绿 */
#define BAKit_ColorWeXinGreen     BAKit_ColorWithRGBA(0, 190, 12, 1)

/*! 白色 1.0 white */
#define BAKit_ColorWhite          BAKit_ColorWithRGBA(255, 255, 255, 1)

/*! 红色 1.0, 0.0, 0.0 RGB */
#define BAKit_ColorRed            BAKit_ColorWithRGBA(255, 0, 0, 1)

/*! 黄色 1.0, 1.0, 0.0 RGB */
#define BAKit_ColorYellow         BAKit_ColorWithRGBA(255, 255, 0, 1)

/*! 绿色 0.0, 1.0, 0.0 RGB */
#define BAKit_ColorGreen          BAKit_ColorWithRGBA(0, 255, 0, 1)

/*! 蓝色 0.0, 0.0, 1.0 RGB */
#define BAKit_ColorBlue           BAKit_ColorWithRGBA(0, 0, 255, 1)

/*! 无色 0.0 white, 0.0 alpha */
#define BAKit_ColorClear          BAKit_ColorWithRGBA(0, 0, 0, 0)

/*! 橙色 1.0, 0.5, 0.0 RGB */
#define BAKit_ColorOrange         BAKit_ColorWithRGBA(255, 255, 0, 1)

/*! 黑色 0.0 white */
#define BAKit_ColorBlack          BAKit_ColorWithRGBA(0, 0, 0, 1)

/*! 浅灰色 0.667 white */
#define BAKit_ColorLightGray      BAKit_ColorWithRGBA(255, 255, 255, 0.667)

/*! 灰色 0.5 white */
#define BAKit_ColorGray           [UIColor grayColor]

/*! 青色 0.0, 1.0, 1.0 RGB */
#define BAKit_ColorCyan           [UIColor cyanColor]

/*! 深灰色 0.333 white */
#define BAKit_ColorDarkGray       [UIColor darkGrayColor]

/*! 红褐色 1.0, 0.0, 1.0 RGB */
#define BAKit_ColorMagenta        [UIColor magentaColor]

/*! 棕色 0.6, 0.4, 0.2 RGB */
#define BAKit_ColorBrown          [UIColor brownColor]

/*! 红褐色 1.0, 0.0, 1.0 RGB */
#define BAKit_ColorMagenta        [UIColor magentaColor]

/*! 紫色 0.5, 0.0, 0.5 RGB */
#define BAKit_ColorPurple         [UIColor purpleColor]

/*! 半透明遮罩色  */
#define BAKit_ColorTranslucent    [[UIColor blackColor] colorWithAlphaComponent:0.3f]

#pragma mark - TimeLine
#define kTimeLineCellColorBlue     BAKit_ColorWithRGBA(92, 140, 193, 1.0f)
#define kTimeLineNameFontColor    UIColorGray1
#define kTimeLineContentFontColor UIColorGray2
#define kTimeLineTimeFontColor    UIColorGray4
#define kTimeLineSourceFontColor  UIColorGray4




#endif /* BAKit_ColorDefine_h */
