//
//  NSDictionary+BAKit.m
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "NSDictionary+BAKit.h"

@implementation NSDictionary (BAKit)

/**
 NSDictionary 中是否包含 这个 key
 
 @param akey akey
 @return YES，NO
 */
- (BOOL)ba_dictionaryIsHasObjectWithKey:(NSString *)akey
{
    if (self.allKeys.count == 0 || ![self.allKeys containsObject:akey])
    {
        return NO;
    }
    
    if ([self[akey] isEqual:[NSNull null]])
    {
        return NO;
    }
    
    if ([self[akey] isKindOfClass:[NSString class]] && [self[akey] isEqualToString:@""])
    {
        return NO;
    }
    
    if ([self[akey] isEqual:[NSNull null]])
    {
        return NO;
    }
    
    return YES;
}

@end
