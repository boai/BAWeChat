//
//  BAUIHelper.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BAUIHelper.h"

@implementation BAUIHelper

+ (void)ba_setupConfigurationTemplate
{
    QMUICMI.navBarTintColor = BAKit_Color_White;                                              // NavBarTintColor : UINavigationBar 的 tintColor，也即导航栏上面的按钮颜色
    QMUICMI.navBarTitleColor = BAKit_Color_White;                                    // NavBarTitleColor : UINavigationBar 的标题颜色，以及 QMUINavigationTitleView 的默认文字颜色
    QMUICMI.navBarTitleFont = nil;                                              // NavBarTitleFont : UINavigationBar 的标题字体，以及 QMUINavigationTitleView 的默认字体
    QMUICMI.navBarBackButtonTitlePositionAdjustment = UIOffsetZero;             // NavBarBarBackButtonTitlePositionAdjustment : 导航栏返回按钮的文字偏移
    QMUICMI.navBarBackIndicatorImage = nil;                                     // NavBarBackIndicatorImage : 导航栏的返回按钮的图片
    QMUICMI.navBarCloseButtonImage = [UIImage qmui_imageWithShape:QMUIImageShapeNavClose size:CGSizeMake(16, 16) tintColor:NavBarTintColor];     // NavBarCloseButtonImage : QMUINavigationButton 用到的 × 的按钮图片
    
    QMUICMI.navBarLoadingMarginRight = 3;                                       // NavBarLoadingMarginRight : QMUINavigationTitleView 里左边 loading 的右边距
    QMUICMI.navBarAccessoryViewMarginLeft = 5;                                  // NavBarAccessoryViewMarginLeft : QMUINavigationTitleView 里右边 accessoryView 的左边距
    QMUICMI.navBarActivityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;// NavBarActivityIndicatorViewStyle : QMUINavigationTitleView 里左边 loading 的主题
    QMUICMI.navBarAccessoryViewTypeDisclosureIndicatorImage = [UIImage qmui_imageWithShape:QMUIImageShapeTriangle size:CGSizeMake(8, 5) tintColor:UIColorWhite];     // NavBarAccessoryViewTypeDisclosureIndicatorImage : QMUINavigationTitleView 右边箭头的图片
    QMUICMI.navBarBackgroundImage = [UIImageMake(@"navigationbar_background") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 2, 0, 2)];                                            // NavBarBackgroundImage
    
#pragma mark - TabBar
    
    QMUICMI.tabBarBackgroundImage = [UIImage qmui_imageWithColor:UIColorMake(249, 249, 249)];                                                                  // TabBarBackgroundImage : UITabBar 的背景图
    QMUICMI.tabBarBarTintColor = nil;                                           // TabBarBarTintColor : UITabBar 的 barTintColor
    QMUICMI.tabBarShadowImageColor = nil;                                       // TabBarShadowImageColor : UITabBar 的 shadowImage 的颜色，会自动创建一张 1px 高的图片
    QMUICMI.tabBarTintColor = UIColorMake(4, 189, 231);                                                                  // TabBarTintColor : UITabBar 的 tintColor
    QMUICMI.tabBarItemTitleColor = BAKit_Color_Gray_6;                                                   // TabBarItemTitleColor : 未选中的 UITabBarItem 的标题颜色
    QMUICMI.tabBarItemTitleColorSelected = TabBarTintColor;                     // TabBarItemTitleColorSelected : 选中的 UITabBarItem 的标题颜色
    QMUICMI.tabBarItemTitleFont = nil;                                          // TabBarItemTitleFont : UITabBarItem 的标题字体
    
#pragma mark - Toolbar
    
    QMUICMI.toolBarHighlightedAlpha = 0.4f;                                     // ToolBarHighlightedAlpha : QMUIToolbarButton 在 highlighted 状态下的 alpha
    QMUICMI.toolBarDisabledAlpha = 0.4f;                                        // ToolBarDisabledAlpha : QMUIToolbarButton 在 disabled 状态下的 alpha
    QMUICMI.toolBarTintColor = nil;                                             // ToolBarTintColor : UIToolbar 的 tintColor，以及 QMUIToolbarButton normal 状态下的文字颜色
    QMUICMI.toolBarTintColorHighlighted = [ToolBarTintColor colorWithAlphaComponent:ToolBarHighlightedAlpha];   // ToolBarTintColorHighlighted : QMUIToolbarButton 在 highlighted 状态下的文字颜色
    QMUICMI.toolBarTintColorDisabled = [ToolBarTintColor colorWithAlphaComponent:ToolBarDisabledAlpha];         // ToolBarTintColorDisabled : QMUIToolbarButton 在 disabled 状态下的文字颜色
    QMUICMI.toolBarBackgroundImage = nil;                                       // ToolBarBackgroundImage : UIToolbar 的背景图
    QMUICMI.toolBarBarTintColor = nil;                                          // ToolBarBarTintColor : UIToolbar 的 tintColor
    QMUICMI.toolBarShadowImageColor = nil;                                      // ToolBarShadowImageColor : UIToolbar 的 shadowImage 的颜色，会自动创建一张 1px 高的图片
    QMUICMI.toolBarButtonFont = nil;                                            // ToolBarButtonFont : QMUIToolbarButton 的字体
    
#pragma mark - SearchBar
    
    QMUICMI.searchBarTextFieldBackground = nil;                                 // SearchBarTextFieldBackground : QMUISearchBar 里的文本框的背景颜色
    QMUICMI.searchBarTextFieldBorderColor = nil;                                // SearchBarTextFieldBorderColor : QMUISearchBar 里的文本框的边框颜色
    QMUICMI.searchBarBottomBorderColor = nil;                                   // SearchBarBottomBorderColor : QMUISearchBar 底部分隔线颜色
    QMUICMI.searchBarBarTintColor = nil;                                        // SearchBarBarTintColor : QMUISearchBar 的 barTintColor，也即背景色
    QMUICMI.searchBarTintColor = nil;                                           // SearchBarTintColor : QMUISearchBar 的 tintColor，也即上面的操作控件的主题色
    QMUICMI.searchBarTextColor = nil;                                           // SearchBarTextColor : QMUISearchBar 里的文本框的文字颜色
    QMUICMI.searchBarPlaceholderColor = UIColorPlaceholder;                     // SearchBarPlaceholderColor : QMUISearchBar 里的文本框的 placeholder 颜色
    QMUICMI.searchBarSearchIconImage = nil;                                     // SearchBarSearchIconImage : QMUISearchBar 里的放大镜 icon
    QMUICMI.searchBarClearIconImage = nil;                                      // SearchBarClearIconImage : QMUISearchBar 里的文本框输入文字时右边的清空按钮的图片
    QMUICMI.searchBarTextFieldCornerRadius = 2.0;                               // SearchBarTextFieldCornerRadius : QMUISearchBar 里的文本框的圆角大小
    
#pragma mark - TableView / TableViewCell
    
    QMUICMI.tableViewBackgroundColor = nil;                                     // TableViewBackgroundColor : Plain 类型的 QMUITableView 的背景色颜色
    QMUICMI.tableViewGroupedBackgroundColor = nil;                              // TableViewGroupedBackgroundColor : Grouped 类型的 QMUITableView 的背景色
    QMUICMI.tableSectionIndexColor = nil;                                       // TableSectionIndexColor : 列表右边的字母索引条的文字颜色
    QMUICMI.tableSectionIndexBackgroundColor = nil;                             // TableSectionIndexBackgroundColor : 列表右边的字母索引条的背景色
    QMUICMI.tableSectionIndexTrackingBackgroundColor = nil;                     // TableSectionIndexTrackingBackgroundColor : 列表右边的字母索引条在选中时的背景色
    QMUICMI.tableViewSeparatorColor = UIColorSeparator;                         // TableViewSeparatorColor : 列表的分隔线颜色
    
    QMUICMI.tableViewCellNormalHeight = 44;                                     // TableViewCellNormalHeight : 列表默认的 cell 高度
    QMUICMI.tableViewCellTitleLabelColor = nil;                                 // TableViewCellTitleLabelColor : QMUITableViewCell 的 textLabel 的文字颜色
    QMUICMI.tableViewCellDetailLabelColor = nil;                                // TableViewCellDetailLabelColor : QMUITableViewCell 的 detailTextLabel 的文字颜色
    QMUICMI.tableViewCellBackgroundColor = UIColorWhite;                        // TableViewCellBackgroundColor : QMUITableViewCell 的背景色
    QMUICMI.tableViewCellSelectedBackgroundColor = UIColorMake(238, 239, 241);  // TableViewCellSelectedBackgroundColor : QMUITableViewCell 点击时的背景色
    QMUICMI.tableViewCellWarningBackgroundColor = UIColorYellow;                // TableViewCellWarningBackgroundColor : QMUITableViewCell 用于表示警告时的背景色，备用
    QMUICMI.tableViewCellDisclosureIndicatorImage = nil;                        // TableViewCellDisclosureIndicatorImage : QMUITableViewCell 当 accessoryType 为 UITableViewCellAccessoryDisclosureIndicator 时的箭头的图片
    QMUICMI.tableViewCellCheckmarkImage = nil;                                  // TableViewCellCheckmarkImage : QMUITableViewCell 当 accessoryType 为 UITableViewCellAccessoryCheckmark 时的打钩的图片
    QMUICMI.tableViewCellDetailButtonImage = nil; // TableViewCellDetailButtonImage : QMUITableViewCell 当 accessoryType 为 UITableViewCellAccessoryDetailButton 或 UITableViewCellAccessoryDetailDisclosureButton 时右边的 i 按钮图片
    QMUICMI.tableViewCellSpacingBetweenDetailButtonAndDisclosureIndicator = 12; // TableViewCellSpacingBetweenDetailButtonAndDisclosureIndicator : 列表 cell 右边的 i 按钮和向右箭头之间的间距（仅当两者都使用了自定义图片并且同时显示时才生效）
    
    QMUICMI.tableViewSectionHeaderBackgroundColor = UIColorMake(244, 244, 244);                         // TableViewSectionHeaderBackgroundColor : Plain 类型的 QMUITableView sectionHeader 的背景色
    QMUICMI.tableViewSectionFooterBackgroundColor = UIColorMake(244, 244, 244);                         // TableViewSectionFooterBackgroundColor : Plain 类型的 QMUITableView sectionFooter 的背景色
    QMUICMI.tableViewSectionHeaderFont = UIFontBoldMake(12);                                            // TableViewSectionHeaderFont : Plain 类型的 QMUITableView sectionHeader 里的文字字体
    QMUICMI.tableViewSectionFooterFont = UIFontBoldMake(12);                                            // TableViewSectionFooterFont : Plain 类型的 QMUITableView sectionFooter 里的文字字体
    QMUICMI.tableViewSectionHeaderTextColor = UIColorGrayDarken;                                        // TableViewSectionHeaderTextColor : Plain 类型的 QMUITableView sectionHeader 里的文字颜色
    QMUICMI.tableViewSectionFooterTextColor = UIColorGray;                                              // TableViewSectionFooterTextColor : Plain 类型的 QMUITableView sectionFooter 里的文字颜色
    QMUICMI.tableViewSectionHeaderHeight = 20;                                                          // TableViewSectionHeaderHeight : Plain 类型的 QMUITableView sectionHeader 的默认高度
    QMUICMI.tableViewSectionFooterHeight = 0;                                                           // TableViewSectionFooterHeight : Plain 类型的 QMUITableView sectionFooter 的默认高度
    QMUICMI.tableViewSectionHeaderContentInset = UIEdgeInsetsMake(4, 15, 4, 15);                        // TableViewSectionHeaderContentInset : Plain 类型的 QMUITableView sectionHeader 里的内容的 padding
    QMUICMI.tableViewSectionFooterContentInset = UIEdgeInsetsMake(4, 15, 4, 15);                        // TableViewSectionFooterContentInset : Plain 类型的 QMUITableView sectionFooter 里的内容的 padding
    
    QMUICMI.tableViewGroupedSectionHeaderFont = UIFontMake(12);                                         // TableViewGroupedSectionHeaderFont : Grouped 类型的 QMUITableView sectionHeader 里的文字字体
    QMUICMI.tableViewGroupedSectionFooterFont = UIFontMake(12);                                         // TableViewGroupedSectionFooterFont : Grouped 类型的 QMUITableView sectionFooter 里的文字字体
    QMUICMI.tableViewGroupedSectionHeaderTextColor = UIColorGrayDarken;                                 // TableViewGroupedSectionHeaderTextColor : Grouped 类型的 QMUITableView sectionHeader 里的文字颜色
    QMUICMI.tableViewGroupedSectionFooterTextColor = UIColorGray;                                       // TableViewGroupedSectionFooterTextColor : Grouped 类型的 QMUITableView sectionFooter 里的文字颜色
    QMUICMI.tableViewGroupedSectionHeaderHeight = 15;                                                   // TableViewGroupedSectionHeaderHeight : Grouped 类型的 QMUITableView sectionHeader 的默认高度
    QMUICMI.tableViewGroupedSectionFooterHeight = 1;                                                    // TableViewGroupedSectionFooterHeight : Grouped 类型的 QMUITableView sectionFooter 的默认高度
    QMUICMI.tableViewGroupedSectionHeaderContentInset = UIEdgeInsetsMake(16, 15, 8, 15);                // TableViewGroupedSectionHeaderContentInset : Grouped 类型的 QMUITableView sectionHeader 里的内容的 padding
    QMUICMI.tableViewGroupedSectionFooterContentInset = UIEdgeInsetsMake(8, 15, 2, 15);                 // TableViewGroupedSectionFooterContentInset : Grouped 类型的 QMUITableView sectionFooter 里的内容的 padding
    
#pragma mark - UIWindowLevel
    QMUICMI.windowLevelQMUIAlertView = UIWindowLevelAlert - 4.0;                // UIWindowLevelQMUIAlertView : QMUIModalPresentationViewController、QMUIPopupContainerView 里使用的 UIWindow 的 windowLevel
    QMUICMI.windowLevelQMUIImagePreviewView = UIWindowLevelStatusBar + 1.0;     // UIWindowLevelQMUIImagePreviewView : QMUIImagePreviewViewController 里使用的 UIWindow 的 windowLevel
    
#pragma mark - Others
    
    QMUICMI.supportedOrientationMask = UIInterfaceOrientationMaskAllButUpsideDown;      // SupportedOrientationMask : 默认支持的横竖屏方向
    QMUICMI.automaticallyRotateDeviceOrientation = YES;                          // AutomaticallyRotateDeviceOrientation : 是否在界面切换或 viewController.supportedOrientationMask 发生变化时自动旋转屏幕
    QMUICMI.statusbarStyleLightInitially = YES;                                  // StatusbarStyleLightInitially : 默认的状态栏内容是否使用白色，默认为 NO，也即黑色
    QMUICMI.needsBackBarButtonItemTitle = NO;                                   // NeedsBackBarButtonItemTitle : 全局是否需要返回按钮的 title，不需要则只显示一个返回image
    QMUICMI.hidesBottomBarWhenPushedInitially = YES;                             // HidesBottomBarWhenPushedInitially : QMUICommonViewController.hidesBottomBarWhenPushed 的初始值，默认为 NO，以保持与系统默认值一致，但通常建议改为 YES，因为一般只有 tabBar 首页那几个界面要求为 NO
    QMUICMI.navigationBarHiddenStateUsable = NO;                                // NavigationBarHiddenStateUsable : 是否使用 navigationBarHiddenState 来管理导航栏的显示隐藏的初始值，默认为NO
    QMUICMI.navigationBarHiddenStateInitially = QMUINavigationBarHiddenStateShowWithAnimated; // NavigationBarHiddenStateInitially : QMUINavigationControllerDelegate preferredNavigationBarHiddenState 的初始值，默认为QMUINavigationBarHiddenStateShowWithAnimated
}

+ (void)ba_renderGlobalAppearances
{
    [BAUIHelper ba_uiHelper_customMoreOperationAppearance];
    [BAUIHelper ba_uiHelper_customAlertControllerAppearance];
}

@end

@implementation BAUIHelper (QMUIModalPresentationViewController)

+ (void)ba_uiHelper_customMoreOperationAppearance
{
    /*! 如果需要统一修改全局的 QMUIMoreOperationController 样式，在这里修改 appearance 的值即可 */
}

@end

@implementation BAUIHelper (QMUIAlertControllerAppearance)

+ (void)ba_uiHelper_customAlertControllerAppearance
{
    /*! 如果需要统一修改全局的 QMUIAlertController 样式，在这里修改 appearance 的值即可 */
}

@end

@implementation BAUIHelper (UITabBarItem)

+ (UITabBarItem *)ba_uiHelper_tabbarItemWithTitle:(NSString *)title
                                            image:(UIImage *)image
                                    selectedImage:(UIImage *)selectedImage
                               selectedTitleColor:(UIColor *)selectedTitleColor
                                              tag:(NSInteger)tag
{
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:tag];
    tabBarItem.selectedImage = selectedImage;
    if (selectedTitleColor)
    {
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : selectedTitleColor} forState:UIControlStateSelected];
    }
    
    
    return tabBarItem;
}

@end

@implementation BAUIHelper (Button)

+ (QMUIButton *)ba_uiHelper_generateDarkFilledButton
{
    QMUIButton *button                 = [[QMUIButton alloc] initWithFrame:CGRectMakeWithSize(CGSizeMake(200, 40))];
    button.adjustsImageWhenHighlighted = YES;
    button.titleLabel.font             = UIFontBoldMake(14);
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    button.backgroundColor             = UIColorGreen;
    button.highlightedBackgroundColor  = UIColorMake(0, 168, 255);
    button.layer.cornerRadius          = 5.0f;
    
    return button;
}

+ (QMUIButton *)ba_uiHelper_generateLightBorderedButton
{
    QMUIButton *button                 = [[QMUIButton alloc] initWithFrame:CGRectMakeWithSize(CGSizeMake(200, 40))];
    button.adjustsImageWhenHighlighted = YES;
    button.titleLabel.font             = UIFontBoldMake(14);
    [button setTitleColor:UIColorGreen forState:UIControlStateNormal];
    button.backgroundColor             = UIColorMake(235, 249, 255);
    button.highlightedBackgroundColor  = UIColorMake(211, 239, 252);
    button.layer.cornerRadius          = 5.0f;
    button.layer.borderColor           = UIColorMake(142, 219, 249).CGColor;
    button.layer.borderWidth           = 1.0f;
    button.highlightedBorderColor      = UIColorMake(0, 168, 225);
    
    return button;
}

+ (QMUIButton *)ba_uiHelper_creatButtonWithTitle:(NSString *)title
                                        selTitle:(NSString *)selTitle
                                      titleColor:(UIColor *)titleColor
                                   titleFontSize:(CGFloat)titleFontSize
                                           image:(UIImage *)image
                                        selImage:(UIImage *)selImage
                                          target:(id)target
                                        selector:(SEL)sel
{
    QMUIButton *button                 = [QMUIButton new];
    button.adjustsImageWhenHighlighted = YES;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selTitle forState:UIControlStateSelected];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selImage forState:UIControlStateSelected];
    
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    button.titleLabel.font             = UIFontBoldMake(titleFontSize);
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    
    return button;
}

+ (QMUIButton *)ba_uiHelper_creatYLButtonWithTitle:(NSString *)title
                                        titleColor:(UIColor *)titleColor
                                   backgroundColor:(UIColor *)backgroundColor
                                            target:(id)target
                                          selector:(SEL)sel
{
    QMUIButton *button = [BAUIHelper ba_uiHelper_creatButtonWithTitle:title selTitle:nil titleColor:titleColor titleFontSize:15 image:nil selImage:nil target:target selector:sel];
    button.backgroundColor = backgroundColor;
    button.height = BAKit_Margin_40;
    
    return button;
}

@end

@implementation NSString (Code)

- (void)ba_uiHelper_enumerateCodeStringBlock:(void (^)(NSString *codeString, NSRange codeRange))block
{
    NSString *pattern = @"\\[?[A-Za-z0-9_.]+\\s?[A-Za-z0-9_:.]+\\]?";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    [regex enumerateMatchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        if (block)
        {
            block([self substringWithRange:result.range], result.range);
        }
    }];
}

@end

@implementation BAUIHelper (SavePhoto)


@end

@implementation BAUIHelper (Calculate)

+ (NSString *)ba_uiHelper_humanReadableFileSize:(long long)size
{
    NSString * strSize = nil;
    if (size >= 1048576.0) {
        strSize = [NSString stringWithFormat:@"%.2fM", size / 1048576.0f];
    } else if (size >= 1024.0) {
        strSize = [NSString stringWithFormat:@"%.2fK", size / 1024.0f];
    } else {
        strSize = [NSString stringWithFormat:@"%.2fB", size / 1.0f];
    }
    return strSize;
}

@end
