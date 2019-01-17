//
//  NSNumber+BARandom.m
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "NSNumber+BARandom.h"

@implementation NSNumber (BARandom)

/**
 get random int value between two values
 
 @param smallNumber smaller one
 @param bigNumber larger one
 @return result
 */
+ (int)ba_numberRandomIntBetweenSmallNumber:(int)smallNumber
                                  bigNumber:(int)bigNumber
{
    return smallNumber + arc4random() % (bigNumber - smallNumber);
}

/**
 get random float value between two values
 
 @param smallNumber smaller one
 @param bigNumber larger one
 @return result
 */
+ (float)ba_numberRandomFloatBetween:(float)smallNumber
                           bigNumber:(float)bigNumber
{
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

@end
