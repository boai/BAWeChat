//
//  NSString+BAGridView.m
//  BAGridView
//
//  Created by boai on 2017/7/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "NSString+BAGridView.h"

@implementation NSString (BAGridView)

#pragma mark - ***** 验证输入的是否是URL地址
+ (BOOL)ba_regularIsUrl:(NSString *)urlStr
{
    NSString *pattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:urlStr options:0 range:NSMakeRange(0, urlStr.length)];
    return results.count > 0;
}

@end
