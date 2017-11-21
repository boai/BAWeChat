//
//  NSString+BAGridView.h
//  BAGridView
//
//  Created by boai on 2017/7/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BAGridView)

#pragma mark - ***** 验证输入的是否是URL地址
+ (BOOL)ba_regularIsUrl:(NSString *)urlStr;

@end
