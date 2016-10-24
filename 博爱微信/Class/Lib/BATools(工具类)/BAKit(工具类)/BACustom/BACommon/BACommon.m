//
//  BACommon.m
//  博爱微信
//
//  Created by 博爱 on 2016/10/24.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "BACommon.h"

@implementation BACommon

/*!
 *  将图片保存到应用程序沙盒中去,imageNameString的格式为 @"upLoad.png"
 *
 *  @param image           image description
 *  @param imageNameString imageNameString description
 */
+ (void)ba_saveImagetoLocal:(UIImage*)image imageName:(NSString *)imageNameString
{
    if (image == nil || imageNameString.length == 0) {
        return;
    }
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *saveImagePath=[documentsDirectory stringByAppendingPathComponent:imageNameString];
    NSData *imageDataJPG=UIImageJPEGRepresentation(image, 0);//将图片大小进行压缩
    //    NSData *imageData=UIImagePNGRepresentation(image);
    [imageDataJPG writeToFile:saveImagePath atomically:YES];
}

/*!
 *  与服务端连接已断开,请检查您的网络连接是否正常.
 */
+ (void)ba_showNoReachabileTips
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"与服务端连接已断开,请检查您的网络连接是否正常."
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
}

+ (void)showTipsWithHUD:(NSString *)labelText showTime:(CGFloat)time
{
    
//    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:[[[UIApplication sharedApplication] delegate] window]] ;
//    hud.mode = MBProgressHUDModeText;
//    hud.labelText = labelText;
//    hud.labelFont = [UIFont systemFontOfSize:15.0];
//    hud.removeFromSuperViewOnHide = YES;
//    [hud show:YES];
//    [[[[UIApplication sharedApplication] delegate] window] addSubview:hud];
//    
//    [hud hide:YES afterDelay:time];
}

+ (void)showTipsWithView:(UIView *)uiview labelText:(NSString *)labelText showTime:(CGFloat)time
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:uiview] ;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = labelText;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15.0];
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [uiview addSubview:hud];
    
    [hud hide:YES afterDelay:time];
}
+ (void)showProgessInView:(UIView *)view withExtBlock:(void (^)())exBlock withComBlock:(void (^)())comBlock
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:view];
    hud.color = [UIColor colorWithWhite:0.8 alpha:0.6];
    //    hud.dimBackground = NO;
    [view addSubview:hud];
    hud.labelText = @"正在加载...";
    if (exBlock) {
        [hud showAnimated:YES whileExecutingBlock:exBlock completionBlock:^{
            if (comBlock) {
                comBlock();
            }
            [hud removeFromSuperview];
        }];
        
    }else
        [hud showAnimated:YES whileExecutingBlock:exBlock completionBlock:^{
            [hud removeFromSuperview];
        }];
}

+ (void) showHudMessage:(NSString*) msg hideAfterDelay:(NSInteger) sec uiview:(UIView *)uiview
{
    MBProgressHUD* hud2 = [MBProgressHUD showHUDAddedTo:uiview animated:YES];
    hud2.mode = MBProgressHUDModeText;
    hud2.labelText = msg;
    hud2.margin = 12.0f;
    hud2.yOffset = 20.0f;
    hud2.removeFromSuperViewOnHide = YES;
    [hud2 hide:YES afterDelay:sec];
}

@end
