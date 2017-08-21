//
//  NSNumber+BARandom.h
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (BARandom)

/**
 get random int value between two values
 
 @param smallNumber smaller one
 @param bigNumber larger one
 @return result
 */
+ (int)ba_numberRandomIntBetweenSmallNumber:(int)smallNumber
                                  bigNumber:(int)bigNumber;

/**
 get random float value between two values
 
 @param smallNumber smaller one
 @param bigNumber larger one
 @return result
 */
+ (float)ba_numberRandomFloatBetween:(float)smallNumber
                           bigNumber:(float)bigNumber;

@end
