//
//  UINavigationBar+BAKit.m
//  BABaseProject
//
//  Created by 博爱 on 16/7/18.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "UINavigationBar+BAKit.h"

@implementation UINavigationBar (BAKit)

static char overlayKey;

- (UIView *)overlay
{
    return BAKit_Objc_getObj;
}

- (void)setOverlay:(UIView *)overlay
{
    BAKit_Objc_setObj(@selector(overlay), overlay);
}

- (void)ba_naviSetBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight`
        [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)ba_naviSetTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)ba_naviSetElementsAlpha:(CGFloat)alpha
{
    // 通过KVC拿到这个属性，然后对其子控件进行修改
    UIView *backgroundViewObject = [self valueForKey:@"backgroundView"];
    for (UIView *childView in backgroundViewObject.subviews) {
        childView.alpha = alpha;
    }
    
//{
//     transitionNavigationBar,
//     hash,
//     superclass,
//     description,
//     debugDescription,
//     "_backIndicatorLeftMargin",
//     "_barTranslucence",
//     "_overrideBackgroundExtension",
//     "_deferShadowToSearchBar",
//     "_animationIds",
//     "_startedAnimationTracking",
//     "_stack",
//     "_isContainedInPopover",
//     "_heightIncludingBackground",
//     refreshControlHost,
//     "_wantsLargeTitleDisplayed",
//     backgroundEffects,
//     largeTitleBackgroundImage,
//     largeTitleTextAttributes,
//     requestedContentSize,
//     currentContentSize,
//     "_userContentGuide",
//     state,
//     locked,
//     currentBackButton,
//     currentLeftView,
//     currentRightView,
//     isMinibar,
//     forceFullHeightInLandscape,
//     "_useInlineBackgroundHeightWhenLarge",
//     "_backgroundOpacity",
//     "_titleOpacity",
//     alwaysUseDefaultMetrics,
//     "_hidesShadow",
//     "_wantsLetterpressContent",
//     "_backgroundView",
//     "_shadowAlpha",
//     "_disableBlurTinting",
//     "_backdropViewLayerGroupName",
//     "_requestedMaxBackButtonWidth",
//}

////    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
////        view.alpha = alpha;
////    }];
//    [[self valueForKey:@"currentLeftView"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
//        view.alpha = alpha;
//    }];
////    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
////        view.alpha = alpha;
////    }];
//    
//    UIView *titleView = [self valueForKey:@"_titleView"];
//    titleView.alpha = alpha;
////    when viewController first load, the titleView maybe nil
//    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
//        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
//            obj.alpha = alpha;
//            *stop = YES;
//        }
//    }];
}

- (void)ba_naviReset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}


@end
