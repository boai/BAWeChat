
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


#import "BAKit_PickerView.h"

#import "BAKit_ConfigurationDefine.h"
#import "NSDateFormatter+BAKit.h"
#import "NSDate+BAKit.h"
#import "UIView+BAAnimation.h"

#define kBAKit_PickerView_H        200 * BAKit_ScaleYAndHeight
#define kBAKit_PickerViewToolBar_H 40 * BAKit_ScaleYAndHeight

@interface BAKit_PickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSString *m_local2DString;
}

// 省 数组
@property (nonatomic, copy) NSMutableArray *provinceArray;
// 城市 数组
@property (nonatomic, copy) NSMutableArray *cityArray;
// 区县 数组
@property (nonatomic, copy) NSMutableArray *areaArray;

/**
 选择的那组数据，主要是城市
 */
@property (nonatomic, copy) NSMutableArray *selectedArray;

@property (nonatomic, strong) UIPickerView *pickView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *bgView;

/**
 取消按钮
 */
@property (nonatomic, strong) UIButton *cancleButton;

/**
 确定按钮
 */
@property (nonatomic, strong) UIButton *sureButton;

/**
 顶部 toolbar 工具栏
 */
@property (nonatomic, strong) UIView *toolBarView;

/**
 省，用于保存选择后的数据
 */
@property (nonatomic, copy) NSString *province;

/**
 市，用于保存选择后的数据
 */
@property (nonatomic, copy) NSString *city;

/**
 区，用于保存选择后的数据
 */
@property (nonatomic, copy) NSString *area;

/**
 选择的结果
 */
@property(nonatomic, strong) NSString *resultString;

@property(nonatomic, strong) NSDateFormatter *formatter;

@property(nonatomic, strong) NSMutableArray *yearArray;
@property(nonatomic, strong) NSMutableArray *mounthArray;
@property(nonatomic, strong) NSMutableArray *dayArray;
@property(nonatomic, strong) NSMutableArray *hoursArray;
@property(nonatomic, strong) NSMutableArray *minutesArray;
@property(nonatomic, strong) NSMutableArray *secondsArray;

@property(nonatomic, strong) NSMutableArray *weekArray;

@property(nonatomic, strong) NSString *defaultMounthString;
@property(nonatomic, strong) NSString *defaultYearString;
@property(nonatomic, strong) NSString *defaultDayString;
@property(nonatomic, strong) NSString *defaultHoursString;
@property(nonatomic, strong) NSString *defaultMinutesString;
@property(nonatomic, strong) NSString *defaultSecondsString;

@property(nonatomic, strong) NSString *defaultWeekString;

@property (nonatomic, strong) UIWindow *alertWindow;
@property(nonatomic, assign) BOOL isAnimating;


@end

@implementation BAKit_PickerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWitPlist:(NSString *)plistName
{
    if (self = [super init])
    {
        [self setupUI];
        
    }
    return self;
}

+ (void)ba_creatCityPickerViewWithConfiguration:(void (^)(BAKit_PickerView *tempView)) configuration
                                          block:(BAKit_PickerViewBlock)block
{
    BAKit_PickerView *pickerView = [[BAKit_PickerView alloc] init];
    if (configuration)
    {
        configuration(pickerView);
    }
    [pickerView ba_pickViewShow];
    pickerView.block = block;
}

+ (void)ba_creatCustomPickerViewWithDataArray:(NSArray *)dataArray
                                configuration:(void (^)(BAKit_PickerView *tempView)) configuration
                                        block:(BAKit_PickerViewResultBlock)block
{
    BAKit_PickerView *pickerView = [[BAKit_PickerView alloc] init];
    pickerView.pickerViewType = BAKit_PickerViewTypeArray;

    if (configuration)
    {
        configuration(pickerView);
    }
    pickerView.dataArray = dataArray;
    [pickerView ba_pickViewShow];
    pickerView.resultBlock = block;
}

+ (void)ba_creatPickerViewWithType:(BAKit_PickerViewType)pickerViewType
                     configuration:(void (^)(BAKit_PickerView *tempView))configuration
                             block:(BAKit_PickerViewResultBlock)block
{
    BAKit_PickerView *pickerView = [[BAKit_PickerView alloc] init];
    
    if (configuration)
    {
        configuration(pickerView);
    }
    pickerView.pickerViewType = pickerViewType;
    [pickerView ba_pickViewShow];
    pickerView.resultBlock = block;
}

- (void)setupUI
{
    self.backgroundColor = BAKit_Color_Translucent_pod;
    self.pickView.hidden = NO;
    
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    
    // 默认配置
    self.pickerViewType = BAKit_PickerViewTypeCity;
    self.dateType = BAKit_PickerViewDateTypeYMD;
    self.dateMode = BAKit_PickerViewDateModeDate;
    self.animationType = BAKit_PickerViewAnimationTypeScale;
    self.isTouchEdgeHide = YES;
    self.ba_backgroundColor_pickView = BAKit_Color_White_pod;
    self.ba_backgroundColor_toolBar = BAKit_Color_White_pod;
    self.ba_pickViewFont = [UIFont boldSystemFontOfSize:17];
    self.ba_pickViewTextColor = [UIColor blackColor];
    self.buttonPositionType = BAKit_PickerViewButtonPositionTypeNormal;
    self.pickerViewPositionType = BAKit_PickerViewPositionTypeNormal;
    
    [BAKit_NotiCenter addObserver:self selector:@selector(handleDeviceOrientationRotateAction:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

#pragma mark - 通知处理
- (void)handleDeviceOrientationRotateAction:(NSNotification *)notification
{
    [self ba_layoutSubViews];
}

#pragma mark - layout
- (void)ba_layoutSubViews
{
    self.frame = [UIScreen mainScreen].bounds;
    self.alertWindow.frame = self.window.bounds;
    
    
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    
    CGFloat min_view_w = CGRectGetWidth(self.frame);
    CGFloat min_view_h = CGRectGetHeight(self.frame);

    
    min_h = kBAKit_PickerView_H + kBAKit_PickerViewToolBar_H;
    min_y = min_view_h - min_h;
    min_w = min_view_w;
    
    if (self.pickerViewPositionType == BAKit_PickerViewPositionTypeCenter)
    {
        min_w = 250 * BAKit_ScaleXAndWidth;
    }

    self.bgView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    CGFloat min_bgView_w = CGRectGetWidth(self.bgView.frame);
    CGFloat min_bgView_h = CGRectGetHeight(self.bgView.frame);
    
    if (self.pickerViewPositionType == BAKit_PickerViewPositionTypeCenter)
    {
        self.bgView.center = self.center;
        [self.bgView ba_view_setViewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:10];
    }
    
    if (self.buttonPositionType == BAKit_PickerViewButtonPositionTypeNormal)
    {
        min_y = kBAKit_PickerViewToolBar_H;
        min_h = kBAKit_PickerView_H;
        self.pickView.frame = CGRectMake(min_x, min_y, min_w, min_h);
        self.datePicker.frame = self.pickView.frame;
        
        min_y = 0;
        min_h = kBAKit_PickerViewToolBar_H;
        self.toolBarView.frame = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_x = 20;
        min_w = 40;
        min_h = kBAKit_PickerViewToolBar_H;
        self.cancleButton.frame = CGRectMake(min_x, min_y, min_w, min_h);
        min_x = min_bgView_w - 40 - 20;

        self.sureButton.frame = CGRectMake(min_x, min_y, min_w, min_h);
    }
    else if (self.buttonPositionType == BAKit_PickerViewButtonPositionTypeBottom)
    {
        min_y = 0;
        min_w = min_bgView_w;
        min_h = min_bgView_h - kBAKit_PickerViewToolBar_H;
        min_x = 0;
        self.pickView.frame = CGRectMake(min_x, min_y, min_w, min_h);
        self.datePicker.frame = self.pickView.frame;

        min_y = CGRectGetMaxY(self.pickView.frame);
        min_h = kBAKit_PickerViewToolBar_H;
        self.toolBarView.frame = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_y = 0;
        min_x = 20;
        min_w = 40;
        min_h = kBAKit_PickerViewToolBar_H;
        self.cancleButton.frame = CGRectMake(min_x, min_y, min_w, min_h);
        

        min_x = min_bgView_w - 40 - 20;
        self.sureButton.frame = CGRectMake(min_x, min_y, min_w, min_h);
    }

}

#pragma mark - UIPickerViewDelegate UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (self.pickerViewType) {
        case BAKit_PickerViewTypeCity:
            return 3;
            break;
        case BAKit_PickerViewTypeArray:
            return 1;
            break;
        case BAKit_PickerViewTypeDate:
        {
            if (self.dateType == BAKit_PickerViewDateTypeYMDHMS) {
                return 6;
            }
            else
            {
              return 0;
            }
        }
             return 0;
            break;
        case BAKit_PickerViewTypeDateWeek:
        case BAKit_PickerViewTypeDateYM:
            return 2;
            break;
        
        default:
            
            break;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (self.pickerViewType) {
        case BAKit_PickerViewTypeCity:
        {
            return 0 == component ? self.provinceArray.count : 1 == component ? self.cityArray.count : self.areaArray.count;
        }
            break;
       
        case BAKit_PickerViewTypeArray:
        {
            return self.dataArray.count;
        }
            break;
            
        case BAKit_PickerViewTypeDate:
        {
            if (self.dateType == BAKit_PickerViewDateTypeYMDHMS) {
                switch (component) {
                    case 0:
                        return self.yearArray.count;
                        break;
                    case 1:
                        return self.mounthArray.count;
                        break;
                    case 2:
                        return self.dayArray.count;
                        break;
                    case 3:
                        return self.hoursArray.count;
                        break;
                    case 4:
                        return self.minutesArray.count;
                        break;
                    case 5:
                        return self.secondsArray.count;
                        break;
                    default:
                        break;
                }
            }
            return 0;
        }
            break;
        case BAKit_PickerViewTypeDateYM:
        {
            return (component == 0) ? self.yearArray.count : self.mounthArray.count;
        }
            break;
        case BAKit_PickerViewTypeDateWeek:
        {
            return (component == 0) ? self.yearArray.count : self.weekArray.count;
        }
            break;
        
        default:
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.pickerViewType == BAKit_PickerViewTypeCity)
    {
        return 0 == component ? [self cutLocalStringForShow:self.provinceArray[row]] : 1 == component ? [self cutLocalStringForShow:self.cityArray[row]] : 0 == self.areaArray.count ? nil : [self cutLocalStringForShow:self.areaArray[row]];
    }
    else if (self.pickerViewType == BAKit_PickerViewTypeArray)
    {
        return self.dataArray[row];
    }
    else if (self.pickerViewType == BAKit_PickerViewTypeDate)
    {
        if (self.dateType == BAKit_PickerViewDateTypeYMDHMS) {
            
            switch (component) {
                case 0:
                    return self.yearArray[row];
                    break;
                case 1:
                    return self.mounthArray[row];
                    break;
                case 2:
                    return self.dayArray[row];
                    break;
                case 3:
                    return self.hoursArray[row];
                    break;
                case 4:
                    return self.minutesArray[row];
                    break;
                case 5:
                    return self.secondsArray[row];
                    break;
                default:
                    break;
            }
        }

    }
    else if (self.pickerViewType == BAKit_PickerViewTypeDateYM)
    {
        return (component == 0) ? self.yearArray[row] : self.mounthArray[row];
    }
    else if (self.pickerViewType == BAKit_PickerViewTypeDateWeek)
    {
        return (component == 0) ? self.yearArray[row] : self.weekArray[row];
    }
    return nil;
}
- (nullable UIView *)viewForRow:(NSInteger)row forComponent:(NSInteger)component{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    return view;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.pickerViewType == BAKit_PickerViewTypeCity)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"BAPickView.bundle/BACity" ofType:@"plist"];
        NSArray *provinceArray = [[NSArray alloc]initWithContentsOfFile:path];
        
        if (0 == component)
        {
            self.selectedArray = provinceArray[row][@"cities"];
            [self.cityArray removeAllObjects];
            
            [self.selectedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.cityArray addObject:obj[@"city"]];
            }];
            
            self.areaArray = [NSMutableArray arrayWithArray:self.selectedArray[0][@"areas"]];
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
        else if (1 == component)
        {
            if (0 == self.selectedArray.count)
            {
                self.selectedArray = provinceArray[0][@"cities"];
            }
            
            self.areaArray = self.selectedArray[row][@"areas"];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
        
        NSInteger provinces = [pickerView selectedRowInComponent:0];
        NSInteger city = [pickerView selectedRowInComponent:1];
        NSInteger area = [pickerView selectedRowInComponent:2];
        
        self.province = [self cutLocalString:self.provinceArray[provinces]];
        self.city = [self cutLocalString:self.cityArray[city]];
        self.area = 0 == self.areaArray.count ? @"" : [self cutLocalString:self.areaArray[area]];
    }
    else if (self.pickerViewType == BAKit_PickerViewTypeArray)
    {
        self.resultString = self.dataArray[row];
    }
    else if (self.pickerViewType == BAKit_PickerViewTypeDate)
    {
        if (self.dateType == BAKit_PickerViewDateTypeYMDHMS) {
            switch (component) {
                case 0:
                {
                    self.defaultYearString = self.yearArray[row];
                    [self refreshDay];
                    
                }
                    break;
                case 1:
                {
                    self.defaultMounthString = self.mounthArray[row];
                    [self refreshDay];
                }
                    break;
                case 2:
                {
                    self.defaultDayString = self.dayArray[row];

                }
                    break;
                case 3:
                {
                    self.defaultHoursString = self.hoursArray[row];

                }
                    break;
                case 4:
                {
                    self.defaultMinutesString = self.minutesArray[row];

                }
                    break;
                case 5:
                {
                    self.defaultSecondsString = self.secondsArray[row];

                }
                    break;
                default:
                    break;
            }

        }
        
    }
    else if (self.pickerViewType == BAKit_PickerViewTypeDateYM)
    {
        if (component == 0)
        {
            self.defaultYearString = self.yearArray[row];
        }
        else
        {
            self.defaultMounthString = self.mounthArray[row];
        }
        
        
        NSString *yearString = [self.defaultYearString substringToIndex:4];
        
        NSString *monthString = @"";
        NSString *month = [NSString stringWithFormat:@"%02li", (long)BAKit_Current_Month()];

        if ([self.defaultMounthString isEqualToString:month])
        {
            monthString = month;
        }
        else
        {
            monthString = [self.defaultMounthString substringToIndex:self.defaultMounthString.length - 1];
        }
        
        self.resultString = [NSString stringWithFormat:@"%@-%@", yearString,monthString];
        
        if (self.customDateFormatter)
        {
            self.resultString = [self.resultString stringByAppendingString:@"-10"];
            NSDateFormatter *formatter = [NSDateFormatter ba_setupDateFormatterWithYMD];
            NSDate *date = [formatter dateFromString:self.resultString];
            self.resultString = [self.customDateFormatter stringFromDate:date];
        }
    }
    else if (self.pickerViewType == BAKit_PickerViewTypeDateWeek)
    {
        if (component == 0)
        {
            self.defaultYearString = self.yearArray[row];
            [self ba_refreshWeeksByYear:self.defaultYearString];
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            self.defaultWeekString = self.weekArray.firstObject;
        }
        else
        {
            self.defaultWeekString = self.weekArray[row];
        }
        
        NSString *yearString = [self.defaultYearString substringToIndex:4];
        
        NSString *weekString = @"";
        NSString *week = [NSString stringWithFormat:@"%02li", (long)BAKit_Current_Date().weekOfYear];
        
        if ([self.defaultMounthString isEqualToString:week])
        {
            weekString = week;
        }
        else
        {
            weekString = [self.defaultWeekString substringToIndex:self.defaultWeekString.length - 1];
        }
        
        self.resultString = [NSString stringWithFormat:@"%@年，%@", yearString, self.defaultWeekString];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.backgroundColor = [UIColor clearColor];
        pickerLabel.font = self.ba_pickViewFont;
        pickerLabel.textColor = self.ba_pickViewTextColor;
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - custom method
- (void)ba_pickViewShow
{
    [self.alertWindow addSubview:self];
    [self ba_layoutSubViews];
    
    [self ba_pickViewShowAnimation];
}

- (void)ba_pickViewHidden
{
    [self ba_pickViewHiddenAnimation];
}

#pragma mark 进场动画

- (void)ba_pickViewShowAnimation
{
    self.isAnimating = YES;
    BAKit_WeakSelf
    switch (self.animationType) {
        case BAKit_PickerViewAnimationTypeScale:
        {
            [self.bgView ba_animation_scaleShowWithDuration:0.6f ratio:1.0f finishBlock:^{
                BAKit_StrongSelf
                self.isAnimating = NO;
            }];
        }
            break;
        case BAKit_PickerViewAnimationTypeTop:
        {
            [self.bgView ba_animation_showFromPositionType:BAKit_ViewAnimationEnterDirectionTypeTop duration:0.6f finishBlock:^{
                BAKit_StrongSelf
                self.isAnimating = NO;
            }];
        }
            break;
        case BAKit_PickerViewAnimationTypeBottom:
        {
            [self.bgView ba_animation_showFromPositionType:BAKit_ViewAnimationEnterDirectionTypeBottom duration:0.6f finishBlock:^{
                BAKit_StrongSelf
                self.isAnimating = NO;
            }];
        }
            break;
        case BAKit_PickerViewAnimationTypeLeft:
        {
            [self.bgView ba_animation_showFromPositionType:BAKit_ViewAnimationEnterDirectionTypeLeft duration:0.6f finishBlock:^{
                BAKit_StrongSelf
                self.isAnimating = NO;
            }];
        }
            break;
        case BAKit_PickerViewAnimationTypeRight:
        {
            [self.bgView ba_animation_showFromPositionType:BAKit_ViewAnimationEnterDirectionTypeRitht duration:0.6f finishBlock:^{
                BAKit_StrongSelf
                self.isAnimating = NO;
            }];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark 出场动画
- (void)ba_pickViewHiddenAnimation
{
    self.isAnimating = YES;
    self.bgView.alpha = 1.0f;
    BAKit_WeakSelf
    switch (self.animationType) {
        case BAKit_PickerViewAnimationTypeScale:
        {
            [self.bgView ba_animation_scaleDismissWithDuration:0.6f ratio:1.0f finishBlock:^{
                BAKit_StrongSelf
                self.bgView.alpha = 0.1f;
                self.isAnimating = NO;
                [self ba_removeSelf];
            }];
        }
            break;
        case BAKit_PickerViewAnimationTypeTop:
        {
            [self.bgView ba_animation_dismissFromPositionType:BAKit_ViewAnimationEnterDirectionTypeTop duration:0.6f finishBlock:^{
                BAKit_StrongSelf
                self.bgView.alpha = 0.1f;
                self.isAnimating = NO;
                [self ba_removeSelf];
            }];
        }
            break;
        case BAKit_PickerViewAnimationTypeBottom:
        {
            [self.bgView ba_animation_dismissFromPositionType:BAKit_ViewAnimationEnterDirectionTypeBottom duration:0.6f finishBlock:^{
                BAKit_StrongSelf
                self.bgView.alpha = 0.1f;
                self.isAnimating = NO;
                [self ba_removeSelf];
            }];
        }
            break;
        case BAKit_PickerViewAnimationTypeLeft:
        {
            [self.bgView ba_animation_dismissFromPositionType:BAKit_ViewAnimationEnterDirectionTypeLeft duration:0.6f finishBlock:^{
                BAKit_StrongSelf
                self.bgView.alpha = 0.1f;
                self.isAnimating = NO;
                [self ba_removeSelf];
            }];
        }
            break;
        case BAKit_PickerViewAnimationTypeRight:
        {
            [self.bgView ba_animation_dismissFromPositionType:BAKit_ViewAnimationEnterDirectionTypeRitht duration:0.6f finishBlock:^{
                BAKit_StrongSelf
                self.bgView.alpha = 0.1f;
                self.isAnimating = NO;
                [self ba_removeSelf];
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"触摸了边缘隐藏View！");
    UITouch *touch = [touches anyObject];
    UIView *view = [touch view];
    
    if (self.isAnimating)
    {
        NSLog(@"请在动画结束时点击！");
        return;
    }
    if (!self.isTouchEdgeHide)
    {
        NSLog(@"触摸了View边缘，但您未开启触摸边缘隐藏方法，请设置 isTouchEdgeHide 属性为 YES 后再使用！");
        return;
    }
    
    if ([view isKindOfClass:[self class]])
    {
        [self ba_pickViewHidden];
    }
}

- (void)handleButtonAction:(UIButton *)sender
{
    if (sender.tag == 1000)
    {
        [self ba_pickViewHidden];
    }
    else if (sender.tag == 1001)
    {
        if (self.pickerViewType == BAKit_PickerViewTypeCity)
        {
            if (self.province.length > 0)
            {
                BAKit_CityModel *model = [[BAKit_CityModel alloc] init];
                model.province = self.province;
                model.city = self.city;
                model.area = self.area;
                
                CLLocationCoordinate2D coordie;
                coordie.latitude = 0;
                coordie.longitude = 0;
                
                if (m_local2DString.length > 0)
                {
                    NSArray *arr = [m_local2DString componentsSeparatedByString:NSLocalizedString(@",", nil)];
                    if([arr count] > 1)
                    {
                        coordie.latitude = [arr[0] floatValue];
                        coordie.longitude = [arr[1] floatValue];
                    }
                }
                model.coordie = coordie;
                if (self.block)
                {
                    self.block(model);
                }
            }
        }
        else if (self.pickerViewType == BAKit_PickerViewTypeArray ||
                 self.pickerViewType == BAKit_PickerViewTypeDate ||
                 self.pickerViewType == BAKit_PickerViewTypeDateYM  ||
                 self.pickerViewType == BAKit_PickerViewTypeDateWeek )
        {
            if (self.pickerViewType == BAKit_PickerViewTypeDate && self.dateType == BAKit_PickerViewDateTypeYMDHMS) {
                self.resultString = [NSString stringWithFormat:@"%@%@%@ %@%@%@",self.defaultYearString,self.defaultMounthString,self.defaultDayString,self.defaultHoursString,self.defaultMinutesString,self.defaultSecondsString];
            }
            if (self.resultString.length > 0)
            {
                if (self.resultBlock)
                {
                    self.resultBlock(self.resultString);
                }
            }
            else
            {
                
            }
        }
        
        [self ba_pickViewHidden];
    }
}

#pragma mark 默认配置：城市选择器
- (void)setupCityData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BAPickView.bundle/BACity" ofType:@"plist"];
    NSArray *provinceArray = [[NSArray alloc]initWithContentsOfFile:path];

    [self ba_removcArray:self.provinceArray];
    [self ba_removcArray:self.cityArray];
    [self ba_removcArray:self.areaArray];

    [provinceArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.provinceArray addObject:obj[@"state"]];
    }];
    
    NSMutableArray *citys = provinceArray[0][@"cities"];
    [citys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.cityArray addObject:obj[@"city"]];
    }];
    
    self.areaArray = citys[0][@"areas"];
    
    // 设置城市选择器的默认值
    self.province = [self cutLocalString:self.provinceArray[0]];
    self.city = [self cutLocalString:self.cityArray[0]];
    self.area = 0 == self.areaArray.count ? @"" : [self cutLocalString:self.areaArray[0]];
}

- (void)ba_removcArray:(NSMutableArray *)array
{
    if (array.count > 0)
    {
        [array removeAllObjects];
    }
}

- (NSString *)cutLocalStringForShow:(NSString *)iStr
{
    // 对显示坐标进行去重
    NSArray *arr = [iStr componentsSeparatedByString:NSLocalizedString(@"|", nil)];
    if([arr count] < 2) return iStr;
    return arr[0];
}

- (NSString *)cutLocalString:(NSString *)iStr
{
    // 对显示坐标进行去重
    NSArray * arr = [iStr componentsSeparatedByString:NSLocalizedString(@"|", nil)];
    if([arr count] < 2) return iStr;
    m_local2DString = arr[1];
    return arr[0];
}

#pragma mark 默认配置：日期选择器-年月
- (void)setupDateYM
{
    NSDate *current_date = [NSDate date];
    NSInteger current_year = current_date.year;
    
    self.defaultYearString = [NSString stringWithFormat:@"%04li", current_year];
    if (self.pickerViewType == BAKit_PickerViewTypeDateWeek)
    {
        self.defaultWeekString = [NSString stringWithFormat:@"%ld", (long)current_date.weekOfYear];
    }
    else
    {
        NSInteger current_mounth = current_date.month;
        self.defaultMounthString = [NSString stringWithFormat:@"%02li", current_mounth];
    }
    
    NSInteger index_year = [self.defaultYearString integerValue];
    NSInteger index_mounth = [self.defaultMounthString integerValue];
    NSInteger index_week = [self.defaultWeekString integerValue];

    [self.pickView selectRow:(index_year - 1900) inComponent:0 animated:YES];

    // 设置年月、年周选择器的默认值
    if (self.pickerViewType == BAKit_PickerViewTypeDateWeek)
    {
        [self ba_refreshWeeksByYear:self.defaultYearString];
        [self.pickView reloadComponent:1];
        [self.pickView selectRow:(index_week - 1) inComponent:1 animated:YES];

        self.resultString = [NSString stringWithFormat:@"%@年，第 %@ 周", self.defaultYearString, self.defaultWeekString];
    }
    else
    {
        [self.pickView selectRow:(index_mounth - 1) inComponent:1 animated:YES];

        self.resultString = [NSString stringWithFormat:@"%@-%@", self.defaultYearString, self.defaultMounthString];
        
        if (self.customDateFormatter)
        {
            self.resultString = [self.resultString stringByAppendingString:@"-10"];
            NSDateFormatter *formatter = [NSDateFormatter ba_setupDateFormatterWithYMD];
            NSDate *date = [formatter dateFromString:self.resultString];
            self.resultString = [self.customDateFormatter stringFromDate:date];
        }
    }
}

#pragma mark 刷新年份的最大周数
- (void)ba_refreshWeeksByYear:(NSString *)year
{
    [self ba_removcArray:self.weekArray];
    
    for (NSInteger i = 1; i < [NSDate ba_dateGetWeekNumbersOfYear:[year integerValue]]+1; i++)
    {
        [self.weekArray addObject:[NSString stringWithFormat:@"第 %ld 周", i]];
    }
}

#pragma mark 日期选择器数据更新
- (void)datePickValueChanged:(UIDatePicker *)sender
{
    self.resultString = [self.formatter stringFromDate:sender.date];
}
-(void)refreshDay
{
    [self.dayArray removeAllObjects];
    NSString *year = self.defaultYearString;
    if ([self.defaultYearString containsString:@"年"]) {
         year = [self.defaultYearString substringToIndex:self.defaultYearString.length - 1];
    }
    NSString *mounth = self.defaultMounthString;
    if ([self.defaultMounthString containsString:@"月"]) {
        mounth = [self.defaultMounthString substringToIndex:self.defaultMounthString.length - 1];
    }
    
    NSString * dateStr = [NSString stringWithFormat:@"%@-%@",year,mounth];
    NSDateFormatter *formatter = [NSDateFormatter ba_setupDateFormatterWithYM];
    NSDate * date = [formatter dateFromString:dateStr];
    NSInteger count =  [self ba_totaldaysInMonth:date];
    for (int i = 1; i < count + 1; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%02i日",i];
        [_dayArray addObject:str];
    }
    [self.pickView reloadComponent:2];

}
#pragma mark 计算出当月有多少天
- (NSInteger)ba_totaldaysInMonth:(NSDate *)date
{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}

- (void)ba_removeSelf
{
    if (self.toolBarView)
    {
        [self.toolBarView removeFromSuperview];
        self.toolBarView = nil;
    }
    
    if (self.bgView)
    {
        [self.bgView removeFromSuperview];
        self.bgView = nil;
    }
    
    if (self.pickView)
    {
        [self.pickView removeFromSuperview];
        self.pickView = nil;
    }
    
//    if (self.datePicker)
//    {
//        [self.datePicker removeFromSuperview];
//        self.datePicker = nil;
//    }
    self.alertWindow = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeAllSubviews];
    [self removeFromSuperview];
}

- (void)removeAllSubviews
{
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

- (void)dealloc
{
    [self ba_removeSelf];
}

#pragma mark - setter / getter

- (UIView *)bgView
{
    if (!_bgView)
    {
        _bgView = [UIView new];
        self.bgView.backgroundColor = BAKit_Color_Clear_pod;
        
        [self addSubview:self.bgView];
    }
    return _bgView;
}

- (UIPickerView *)pickView
{
    if (!_pickView)
    {
        _pickView = [UIPickerView new];
        
        [self.bgView addSubview:self.pickView];
    }
    return _pickView;
}

- (UIDatePicker *)datePicker
{
    if (!_datePicker)
    {
        _datePicker = [[UIDatePicker alloc] init];
        
        /*! 跟踪所有可用的地区，取出想要的地区 */
//        NSLog(@"%@", [NSLocale availableLocaleIdentifiers]);
        
        /*! 1、设置日期选择控件的地区 */
        [_datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        /*! 英文 */
//            [_datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_SC"]];
         //[_datePicker setLocale:[NSLocale systemLocale]];
        /*! 2、设置DatePicker的日历。默认为当天。 */
        [_datePicker setCalendar:[NSCalendar currentCalendar]];
        
        /*! 3、设置DatePicker的时区。*/
        [_datePicker setTimeZone:[NSTimeZone defaultTimeZone]];
        
        /*! 4、设置DatePicker的日期。 */
        //[_datePicker setDate:BAKit_Current_Date];
        
        /*! 5、设置DatePicker的允许的最小日期。 */
        //        NSDate *minDate = [[NSDate alloc]initWithTimeIntervalSince1970:NSTimeIntervalSince1970];
        //        _datePicker.minimumDate = minDate;
        
        /*! 6、设置DatePicker的允许的最大日期。 */
        NSDateComponents *dc = [[NSDateComponents alloc] init];
        dc.year = 2099;
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _datePicker.maximumDate = [gregorian dateFromComponents:dc];
        
        /*! 6.1 限定UIDatePicker的时间范围 */
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        comps.year = 30;
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        comps.year = -30;
        
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        
        NSString *selfStr = [formatter stringFromDate:minDate];
        NSString *maxStr = [formatter stringFromDate:maxDate];
       
        _datePicker.minimumDate = [formatter dateFromString:selfStr];
        _datePicker.maximumDate = [formatter dateFromString:maxStr];
        
//        /*! 7、显示年月日，名称根据本地设置，显示小时，分钟和AM/PM,这个的名称是根据本地设置的 */
//        [_datePicker setDatePickerMode:UIDatePickerModeDate];
//        
        /*! 8、当值发生改变的时候调用的方法 */
        [_datePicker addTarget:self action:@selector(datePickValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        /*! 9、用 runtime 和 KVC 改变字体颜色 */
//        [self setTextColor];
    }
    return _datePicker;
}

- (UIView *)toolBarView
{
    if (!_toolBarView)
    {
        _toolBarView = [UIView new];
        
        [self.bgView addSubview:self.toolBarView];
    }
    return _toolBarView;
}

- (UIButton *)cancleButton
{
    if (!_cancleButton)
    {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancleButton setTitleColor:BAKit_Color_Black_pod forState:UIControlStateNormal];
        [self.cancleButton addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.cancleButton.tag = 1000;
        [self.toolBarView addSubview:self.cancleButton];
    }
    return _cancleButton;
}

- (UIButton *)sureButton
{
    if (!_sureButton)
    {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.sureButton setTitleColor:BAKit_Color_Black_pod forState:UIControlStateNormal];
        [self.sureButton addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.sureButton.tag = 1001;
        [self.toolBarView addSubview:self.sureButton];
    }
    return _sureButton;
}

- (UIWindow *)alertWindow
{
    if (!_alertWindow)
    {
        _alertWindow = [UIApplication sharedApplication].keyWindow;
        
        if (self.alertWindow.windowLevel != UIWindowLevelNormal)
        {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"windowLevel == %ld AND hidden == 0 " , UIWindowLevelNormal];
            self.alertWindow = [[UIApplication sharedApplication].windows filteredArrayUsingPredicate:predicate].firstObject;
        }
        self.alertWindow.backgroundColor = BAKit_Color_Translucent_pod;
    }
    return _alertWindow;
}

- (NSMutableArray *)provinceArray
{
    if (!_provinceArray)
    {
        _provinceArray = @[].mutableCopy;
    }
    return _provinceArray;
}

- (NSMutableArray *)cityArray
{
    if (!_cityArray)
    {
        _cityArray = @[].mutableCopy;
    }
    return _cityArray;
}

- (NSMutableArray *)areaArray
{
    if (!_areaArray)
    {
        _areaArray = @[].mutableCopy;
    }
    return _areaArray;
}

- (NSMutableArray *)selectedArray
{
    if (!_selectedArray)
    {
        _selectedArray = @[].mutableCopy;
    }
    return _selectedArray;
}

- (NSMutableArray *)yearArray
{
    if (!_yearArray)
    {
        _yearArray = @[].mutableCopy;
        for (int i = 1900; i < 2100; i++)
        {
            NSString *str = [NSString stringWithFormat:@"%04i%@",i,@"年"];
            [self.yearArray addObject:str];
        }
    }
    return _yearArray;
}

- (NSMutableArray *)mounthArray
{
    if (!_mounthArray)
    {
        _mounthArray = @[].mutableCopy;
        for (int i = 1; i < 13; i++)
        {
            NSString *str = [NSString stringWithFormat:@"%02i%@",i,@"月"];
            [self.mounthArray addObject:str];
        }
    }
    return _mounthArray;
}

- (NSMutableArray *)dayArray
{
    if (!_dayArray)
    {
        _dayArray = @[].mutableCopy;
        [self refreshDay];
    }
    
    return _dayArray;
}

- (NSMutableArray *)hoursArray
{
    if (!_hoursArray)
    {
        _hoursArray = @[].mutableCopy;
        
        for (int i = 0; i < 24; i++)
        {
            NSString *str = [NSString stringWithFormat:@"%02i时",i];
            [_hoursArray addObject:str];
        }
    }
    return _hoursArray;
}

- (NSMutableArray *)minutesArray
{
    if (!_minutesArray)
    {
        _minutesArray = @[].mutableCopy;
        
        for (int i = 0; i < 60; i++)
        {
            NSString *str = [NSString stringWithFormat:@"%02i分",i];
            [_minutesArray addObject:str];
        }
    }
    return _minutesArray;
}

- (NSMutableArray *)secondsArray
{
    if (!_secondsArray)
    {
        _secondsArray = @[].mutableCopy;
        
        for (int i = 0; i < 60; i++)
        {
            NSString *str = [NSString stringWithFormat:@"%02i秒",i];
            [_secondsArray addObject:str];
        }
    }
    return _secondsArray;
}

- (NSMutableArray *)weekArray
{
    if (!_weekArray)
    {
        _weekArray = @[].mutableCopy;
    }
    return _weekArray;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    self.resultString = dataArray[0];
}

- (void)setBa_backgroundColor_toolBar:(UIColor *)ba_backgroundColor_toolBar
{
    _ba_backgroundColor_toolBar = ba_backgroundColor_toolBar;
    self.toolBarView.backgroundColor = ba_backgroundColor_toolBar;
}

- (void)setBa_backgroundColor_pickView:(UIColor *)ba_backgroundColor_pickView
{
    _ba_backgroundColor_pickView = ba_backgroundColor_pickView;
    self.pickView.backgroundColor = ba_backgroundColor_pickView;
    self.datePicker.backgroundColor = ba_backgroundColor_pickView;
}

- (void)setBa_buttonTitleColor_cancle:(UIColor *)ba_buttonTitleColor_cancle
{
    _ba_buttonTitleColor_cancle = ba_buttonTitleColor_cancle;
    [self.cancleButton setTitleColor:ba_buttonTitleColor_cancle forState:UIControlStateNormal];
}

- (void)setBa_buttonTitleColor_sure:(UIColor *)ba_buttonTitleColor_sure
{
    _ba_buttonTitleColor_sure = ba_buttonTitleColor_sure;
    [self.sureButton setTitleColor:ba_buttonTitleColor_sure forState:UIControlStateNormal];
}

- (void)setPickerViewType:(BAKit_PickerViewType)pickerViewType
{
    _pickerViewType = pickerViewType;
    
    switch (pickerViewType) {
        case BAKit_PickerViewTypeCity:
        {
            if (self.datePicker)
            {
                [self.datePicker removeFromSuperview];
            }
            
            [self setupCityData];
        }
            break;
        case BAKit_PickerViewTypeArray:
        {
            if (self.datePicker)
            {
                [self.datePicker removeFromSuperview];
            }
        }
            break;
        case BAKit_PickerViewTypeDate:
        {
            if (self.dateType == BAKit_PickerViewDateTypeYMDHMS)
            {
                NSDate *nowDate = [NSDate date];
                
                self.defaultYearString = [NSString stringWithFormat:@"%04li年",(long)nowDate.year];
                
                
                self.defaultMounthString = [NSString stringWithFormat:@"%02li月",(long)nowDate.month];
                NSInteger mounthIndex =[self.mounthArray indexOfObject:self.defaultMounthString];
                if (mounthIndex <self.mounthArray.count) {
                    [self.pickView selectRow:[self.mounthArray indexOfObject:self.defaultMounthString] inComponent:1 animated:NO];
                }
                
                self.defaultDayString = [NSString stringWithFormat:@"%02li日",(long)nowDate.day];
                NSInteger dayIndex =[self.dayArray indexOfObject:self.defaultDayString];
                if (dayIndex <self.dayArray.count) {
                   [self.pickView selectRow:[self.dayArray indexOfObject:self.defaultDayString] inComponent:2 animated:NO];
                }
                
                
                self.defaultHoursString = [NSString stringWithFormat:@"%02li时",(long)nowDate.hour];
                NSInteger hourIndex =[self.hoursArray indexOfObject:self.defaultHoursString];
                if (hourIndex <self.hoursArray.count) {
                     [self.pickView selectRow:[self.hoursArray indexOfObject:self.defaultHoursString] inComponent:3 animated:NO];
                }
               
                
                self.defaultMinutesString = [NSString stringWithFormat:@"%02li分",(long)nowDate.minute];
                NSInteger minutesIndex =[self.minutesArray indexOfObject:self.defaultMinutesString];
                if (minutesIndex <self.minutesArray.count) {
                    [self.pickView selectRow:[self.minutesArray indexOfObject:self.defaultMinutesString] inComponent:4 animated:NO];
                }
                
                
                self.defaultSecondsString = [NSString stringWithFormat:@"%02li秒",(long)nowDate.second];
                NSInteger secondsIndex =[self.secondsArray indexOfObject:self.defaultSecondsString];
                
                if (secondsIndex <self.secondsArray.count) {
                   [self.pickView selectRow:[self.secondsArray indexOfObject:self.defaultSecondsString] inComponent:5 animated:NO];
                }
                
                NSInteger yearIndex =[self.yearArray indexOfObject:self.defaultYearString];
                if (yearIndex <self.yearArray.count) {
                    [self.pickView selectRow:[self.yearArray indexOfObject:self.defaultYearString] inComponent:0 animated:NO];
                }
                [self.datePicker removeFromSuperview];
            }
            else
            {
                if (self.pickView)
                {
                    [self.pickView removeFromSuperview];
                }
                [self.bgView addSubview:self.datePicker];
            }
            
        }
            break;
        case BAKit_PickerViewTypeDateYM:
        {
            if (self.datePicker)
            {
                [self.datePicker removeFromSuperview];
            }
            self.dateType = BAKit_PickerViewDateTypeYM;
            [self setupDateYM];
        }
            break;
        case BAKit_PickerViewTypeDateWeek:
        {
            if (self.datePicker)
            {
                [self.datePicker removeFromSuperview];
            }
            self.dateType = BAKit_PickerViewDateTypeYM;
            [self setupDateYM];
        }
            break;
        default:
            break;
    }
}

- (void)setDateType:(BAKit_PickerViewDateType)dateType
{
    _dateType = dateType;
    
    if (self.customDateFormatter)
    {
        self.resultString = [self.resultString stringByAppendingString:@"-10"];
        NSDateFormatter *formatter = [NSDateFormatter ba_setupDateFormatterWithYMD];
        NSDate *date = [formatter dateFromString:self.resultString];
        self.resultString = [self.customDateFormatter stringFromDate:date];
    }
    else
    {
        switch (self.dateType) {
            case BAKit_PickerViewDateTypeYY:
                self.formatter = [NSDateFormatter ba_setupDateFormatterWithYY];
                break;
            case BAKit_PickerViewDateTypeYM:
                self.formatter = [NSDateFormatter ba_setupDateFormatterWithYM];
                break;
            case BAKit_PickerViewDateTypeYMD:
                self.formatter = [NSDateFormatter ba_setupDateFormatterWithYMD];
                break;
            case BAKit_PickerViewDateTypeYMDHMS:
                self.formatter = [NSDateFormatter ba_setupDateFormatterWithYMDHMS];
                break;
            case BAKit_PickerViewDateTypeYMDEHMS:
                self.formatter = [NSDateFormatter ba_setupDateFormatterWithYMDEHMS];
                break;
            case BAKit_PickerViewDateTypeHM:
                self.formatter = [NSDateFormatter ba_setupDateFormatterWithHM];
                break;
            case BAKit_PickerViewDateTypeHMS:
                self.formatter = [NSDateFormatter ba_setupDateFormatterWithHMS];
                break;
                
            default:
                break;
        }
        self.resultString = [self.formatter stringFromDate:BAKit_Current_Date()];
    }
}

- (void)setDateMode:(BAKit_PickerViewDateMode)dateMode
{
    _dateMode = dateMode;
    switch (dateMode) {
        case BAKit_PickerViewDateModeTime:
            /*! 7、显示年月日，名称根据本地设置，显示小时，分钟和AM/PM,这个的名称是根据本地设置的 */
            [self.datePicker setDatePickerMode:UIDatePickerModeTime];
            break;
        case BAKit_PickerViewDateModeDate:
//            self.dateType = BAKit_PickerViewDateTypeYMD;
            [self.datePicker setDatePickerMode:UIDatePickerModeDate];
            break;
        case BAKit_PickerViewDateModeDateAndTime:
            self.dateType = BAKit_PickerViewDateTypeYMDEHMS;
            [self.datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
            break;
        case BAKit_PickerViewDateModeCountDownTimer:
            [self.datePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
            break;
            
        default:
            break;
    }
}

- (void)setCustomDateFormatter:(NSDateFormatter *)customDateFormatter
{
    _customDateFormatter = customDateFormatter;
    self.formatter =  customDateFormatter;
}

- (void)setIsAnimating:(BOOL)isAnimating
{
    _isAnimating = isAnimating;
}

- (void)setIsTouchEdgeHide:(BOOL)isTouchEdgeHide
{
    _isTouchEdgeHide = isTouchEdgeHide;
}

- (void)setAnimationType:(BAKit_PickerViewAnimationType)animationType
{
    _animationType = animationType;
}

- (void)setBa_pickViewFont:(UIFont *)ba_pickViewFont
{
    _ba_pickViewFont = ba_pickViewFont;
}

- (void)setBa_pickViewTextColor:(UIColor *)ba_pickViewTextColor
{
    _ba_pickViewTextColor = ba_pickViewTextColor;
}


@end

@implementation BAKit_CityModel

@end
