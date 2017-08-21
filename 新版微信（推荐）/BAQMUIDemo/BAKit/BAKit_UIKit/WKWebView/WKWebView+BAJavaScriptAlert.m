//
//  WKWebView+BAJavaScriptAlert.m
//  BAWebViewController
//
//  Created by boai on 2017/6/13.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "WKWebView+BAJavaScriptAlert.h"

@implementation WKWebView (BAJavaScriptAlert)

static BOOL diagStat = NO;

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    
    [alert show];;
}

- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"Ok") otherButtonTitles:NSLocalizedString(@"Cancel", @"Cancel"), nil];
    
    [alert show];
    
    while (alert.isVisible) {
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01f]];
    }
    
    return diagStat;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0)
    {
        diagStat = YES;
    }
    else if (buttonIndex == 1)
    {
        diagStat = NO;
    }
}

@end
