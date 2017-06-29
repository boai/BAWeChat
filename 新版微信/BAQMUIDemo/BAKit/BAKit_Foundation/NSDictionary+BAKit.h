//
//  NSDictionary+BAKit.h
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BAKit)


/**
 NSDictionary 中是否包含 这个 key

 @param akey akey
 @return YES，NO
 */
- (BOOL)ba_dictionaryIsHasObjectWithKey:(NSString *)akey;

@end
