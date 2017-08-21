//
//  UIColor+BAKit.m
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UIColor+BAKit.h"

@implementation UIColor (BAKit)


/**
 创建一个 hex 颜色

 @param hexstring hex
 @param alpha alpha
 @return 颜色
 */
+ (UIColor *)ba_colorWithHex:(NSString *)hexstring andAlpha:(CGFloat)alpha
{
    if (hexstring.length == 0)
    {
        return [UIColor clearColor];
    }
    
    if('#' != [hexstring characterAtIndex:0])
    {
        hexstring = [NSString stringWithFormat:@"#%@", hexstring];
    }
    
    // RETURNING NO OBJECT ON WRONG ALPHA VALUES
    NSArray *validHexStringLengths = @[@7,];
    NSNumber *hexStringLengthNumber = [NSNumber numberWithUnsignedInteger:hexstring.length];
    if ([validHexStringLengths indexOfObject:hexStringLengthNumber] == NSNotFound)
    {
        return nil;
    }
    
    unsigned value = 0;
    NSScanner *hexValueScanner = nil;
    
    NSString *redHex = [NSString stringWithFormat:@"0x%@", [hexstring substringWithRange:NSMakeRange(1, 2)]];
    hexValueScanner = [NSScanner scannerWithString:redHex];
    [hexValueScanner scanHexInt:&value];
    unsigned redInt = value;
    hexValueScanner = nil;
    
    NSString *greenHex = [NSString stringWithFormat:@"0x%@", [hexstring substringWithRange:NSMakeRange(3, 2)]];
    hexValueScanner = [NSScanner scannerWithString:greenHex];
    [hexValueScanner scanHexInt:&value];
    unsigned greenInt = value;
    hexValueScanner = nil;
    
    NSString *blueHex = [NSString stringWithFormat:@"0x%@", [hexstring substringWithRange:NSMakeRange(5, 2)]];
    hexValueScanner = [NSScanner scannerWithString:blueHex];
    [hexValueScanner scanHexInt:&value];
    unsigned blueInt = value;
    hexValueScanner = nil;
    
    alpha = MIN(alpha, 1.0f);
    alpha = MAX(0, alpha);
    
    return [UIColor colorWithRed:redInt/255.0f green:greenInt/255.0f blue:blueInt/255.0f alpha:alpha];
}

@end
