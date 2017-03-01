
#import "UIAlertController+Blocks.h"
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "NSObject+BARunTime.h"

//static NSInteger const UIAlertControllerBlocksFirstOtherButtonIndex = 2;

@interface UIViewController (UACB_Topmost)

- (UIViewController *)uacb_topmost;

@end

@implementation UIAlertController (Blocks)

+ (instancetype)ba_alertControllerShowInViewController:(UIViewController *)viewController
                           withTitle:(NSString *)title
              mutableAttributedTitle:(nullable NSMutableAttributedString *)mutableAttributedTitle
                             message:(NSString *)message
            mutableAttributedMessage:(nullable NSMutableAttributedString *)mutableAttributedMessage
                      preferredStyle:(UIAlertControllerStyle)preferredStyle
                   buttonTitlesArray:(nullable NSArray *)buttonTitlesArray
               buttonTitleColorArray:(nullable NSArray <UIColor *>*)buttonTitleColorArray
#if TARGET_OS_IOS
  popoverPresentationControllerBlock:(void(^)(UIPopoverPresentationController *popover))popoverPresentationControllerBlock
#endif
                            tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    UIAlertController *strongController = [self alertControllerWithTitle:title
                                                                 message:message
                                                          preferredStyle:preferredStyle];
    
    __weak UIAlertController *controller = strongController;
    
    if (buttonTitlesArray)
    {
        for (NSUInteger i = 0; i < buttonTitlesArray.count; i++)
        {
            NSString *buttonTitle = buttonTitlesArray[i];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitle
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction *action){
                                                                    if (tapBlock) {
                                                                        tapBlock(controller, action, i);
                                                                    }
                                                                }];
            [controller addAction:action];
            
            if (buttonTitleColorArray)
            {
                [strongController setAlertWithAlert:strongController
                             mutableAttributedTitle:mutableAttributedTitle
                           mutableAttributedMessage:mutableAttributedMessage
                                             Action:action
                                   buttonTitleColor:buttonTitleColorArray[i]];
            }
        }
    }
    
    
#if TARGET_OS_IOS
    if (popoverPresentationControllerBlock) {
        popoverPresentationControllerBlock(controller.popoverPresentationController);
    }
#endif
    
    [viewController.uacb_topmost presentViewController:controller animated:YES completion:nil];
    
    return controller;
}

+ (instancetype)ba_alertControllerShowAlertInViewController:(UIViewController *)viewController
                                withTitle:(NSString *)title
                   mutableAttributedTitle:(nullable NSMutableAttributedString *)mutableAttributedTitle
                                  message:(NSString *)message
                 mutableAttributedMessage:(nullable NSMutableAttributedString *)mutableAttributedMessage
                        buttonTitlesArray:(nullable NSArray *)buttonTitlesArray
                    buttonTitleColorArray:(nullable NSArray <UIColor *>*)buttonTitleColorArray
                                 tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    return [self ba_alertControllerShowInViewController:viewController
                            withTitle:title
               mutableAttributedTitle:mutableAttributedTitle
                              message:message
             mutableAttributedMessage:mutableAttributedMessage
                       preferredStyle:UIAlertControllerStyleAlert
                    buttonTitlesArray:buttonTitlesArray
                buttonTitleColorArray:buttonTitleColorArray
#if TARGET_OS_IOS
            popoverPresentationControllerBlock:nil
#endif
                             tapBlock:tapBlock];
}

+ (instancetype)ba_alertControllerShowActionSheetInViewController:(UIViewController *)viewController
                                      withTitle:(NSString *)title
                         mutableAttributedTitle:(nullable NSMutableAttributedString *)mutableAttributedTitle
                                        message:(NSString *)message
                       mutableAttributedMessage:(nullable NSMutableAttributedString *)mutableAttributedMessage
                              buttonTitlesArray:(nullable NSArray *)buttonTitlesArray
                          buttonTitleColorArray:(nullable NSArray <UIColor *>*)buttonTitleColorArray
#if TARGET_OS_IOS
             popoverPresentationControllerBlock:(void(^)(UIPopoverPresentationController *popover))popoverPresentationControllerBlock
#endif
                                       tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    return [self ba_alertControllerShowInViewController:viewController
                            withTitle:title
               mutableAttributedTitle:mutableAttributedTitle
                              message:message
             mutableAttributedMessage:mutableAttributedMessage
                       preferredStyle:UIAlertControllerStyleActionSheet
                    buttonTitlesArray:buttonTitlesArray
                buttonTitleColorArray:buttonTitleColorArray
#if TARGET_OS_IOS
            popoverPresentationControllerBlock:popoverPresentationControllerBlock
#endif
                             tapBlock:tapBlock];
}

#pragma mark -

- (BOOL)visible
{
    return self.view.superview != nil;
}

- (void)setAlertWithAlert:(UIAlertController * __nonnull )alert
   mutableAttributedTitle:(NSMutableAttributedString *)mutableAttributedTitle
 mutableAttributedMessage:(nullable NSMutableAttributedString *)mutableAttributedMessage
                   Action:(UIAlertAction * __nonnull )action
         buttonTitleColor:(UIColor *)buttonTitleColor
{
    /*! 1、首先获得对应的属性 */
//    NSArray *propertysListArray = [[UIAlertController class] ba_propertysList];
//    NSLog(@"1、获取【UIAlertController】所有的属性名：%@", propertysListArray);
    
    /*! 2、获得成员变量 */
    NSArray *ivarListArray = [[UIAlertAction class] ba_ivarList];
//    NSLog(@"2、获取【UIAlertController】所有的成员变量：%@", ivarListArray);
    
    for (NSInteger i = 0; i < ivarListArray.count; i++)
    {
        NSString *ivarName = ivarListArray[i];
        if ([ivarName isEqualToString:@"_titleTextColor"])
        {
            [action setValue:buttonTitleColor forKey:@"titleTextColor"];
        }
    }
    
    /*! 3、改变显示提示字体颜色 */
    NSArray *propertysListArray2 = [[UIAlertController class] ba_ivarList];
//    NSLog(@"3、获取【UIAlertController】所有的成员变量：%@", propertysListArray2);
    for (NSInteger i = 0; i < propertysListArray2.count; i++)
    {
        NSString *ivarName = propertysListArray2[i];
        if ([ivarName isEqualToString:@"_attributedTitle"])
        {
            [alert setValue:mutableAttributedTitle forKey:@"attributedTitle"];
        }
        if ([ivarName isEqualToString:@"_attributedMessage"])
        {
            [alert setValue:mutableAttributedMessage forKey:@"attributedMessage"];
        }
    }
}

@end

@implementation UIViewController (UACB_Topmost)

- (UIViewController *)uacb_topmost
{
    UIViewController *topmost = self;
    
    UIViewController *above;
    while ((above = topmost.presentedViewController)) {
        topmost = above;
    }
    
    return topmost;
}

@end
