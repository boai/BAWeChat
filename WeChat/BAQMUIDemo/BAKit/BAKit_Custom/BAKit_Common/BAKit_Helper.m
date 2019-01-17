//
//  BAKit_Helper.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/17.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BAKit_Helper.h"
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "BAKit_RegularExpression.h"

#import <AssetsLibrary/AssetsLibrary.h>

@implementation BAKit_Helper

/*!
 *  拨打电话
 *
 *  @param phoneNumber 电话号码
 */
+ (void)ba_helperTelWithPhoneNumber:(NSString *)phoneNumber
{
    if (![BAKit_RegularExpression ba_regularIsMobileNumber:phoneNumber])
    {
        if ([phoneNumber isEqualToString:@"10010"] ||
            [phoneNumber isEqualToString:@"10086"] ||
            [phoneNumber isEqualToString:@"10000"])
        {

        }
        else
        {
            BAKit_ShowAlertWithMsg(@"电话号码格式错误！");
            return;
        }
    }
    
    [BAKit_SharedApplication openURL:[NSURL URLWithString:[@"tel:" stringByAppendingString: phoneNumber]]];
    // 打电话
//    UIWebView *webView=[[UIWebView alloc] init];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]]];
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [app.window.rootViewController.view addSubview:webView];
    
    /*!
     
     拨打电话 的几种常用方法
     
     1，这种方法，拨打完电话回不到原来的应用，会停留在通讯录里，而且是直接拨打，不弹出提示
     NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"186xxxx6979"];
     //            NSLog(@"str======%@",str);
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
     
     2，这种方法，打完电话后还会回到原来的程序，也会弹出提示，推荐这种
     NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"186xxxx6979"];
     UIWebView * callWebview = [[UIWebView alloc] init];
     [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
     [self.view addSubview:callWebview];
     [callWebview release];
     [str release];
     
     3,这种方法也会回去到原来的程序里（注意这里的telprompt），也会弹出提示
     NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"186xxxx6979"];
     //            NSLog(@"str======%@",str);
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]]
     
     */
}

/*!
 *  跳转Safari浏览器
 */
+ (void)ba_helperGotoSafariBrowserWithURL:(NSString *)url
{
    if ([BAKit_RegularExpression ba_regularIsUrl:url])
    {
        /*! 跳转系统通知 */
        BAKit_OpenUrl(url);
    }
    else
    {
        NSLog(@"url错误，请重新输入！");
    }
}



@end

@implementation BAKit_Helper (NSNULL)

#pragma mark - ***** 判断字符串为空和只为空格
+ (BOOL)ba_helperIsBlankString:(NSString *)string
{
    if (string == nil)
    {
        return YES;
    }
    
    if (string == NULL)
    {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    
    if (string.length==0)
    {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
    {
        return YES;
    }
    
    return NO;
}


@end

@implementation BAKit_Helper (Location)

/*! 判断是否打开定位 */
+ (BOOL)ba_helperIsLocationOpen
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end

@implementation BAKit_Helper (NSArray)

/*!
 *  判断数组是否包含有某个 object
 *
 *  @param array  需要判断的数组
 *  @param object 需要判断的数组字段
 *
 *  @return YES / NO
 */
+ (BOOL)ba_helperIsArray:(NSArray *)array containsObject:(NSString *)object
{
    if ([array containsObject:object])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end

@implementation BAKit_Helper (PathExtension)

/*!
 *  判断 URL 是否是 MP4
 *
 *  @return YES / NO
 */
+ (BOOL)ba_helperURLIsMp4WithUrl:(NSString *)url
{
    NSString *pathExtention = [url pathExtension];
    if([pathExtention isEqualToString:@"mp4"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end


