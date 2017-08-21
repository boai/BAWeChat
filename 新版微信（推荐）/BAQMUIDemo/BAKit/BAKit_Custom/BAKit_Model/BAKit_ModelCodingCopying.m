//
//  BAKit_ModelCodingCopying.m
//  yunlianWIFI
//
//  Created by boai on 2017/4/10.
//  Copyright © 2017年 yunlianhui. All rights reserved.
//

#import "BAKit_ModelCodingCopying.h"

@implementation BAKit_ModelCodingCopying

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self yy_modelInitWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self yy_modelEncodeWithCoder:aCoder];
}

+ (BOOL )supportsSecureCoding
{
    return YES;
}

- (id)copyWithZone:(NSZone *)zone
{
    id object = [[self class] new];
    [self copyWithClass:[self class] zone:zone toNew:object];
    return object;
}

- (void)copyWithClass:(Class )cls zone:(NSZone *)zone toNew:(id )objectNew
{
    unsigned propertyCount;
    objc_property_t *propertyList = class_copyPropertyList(cls, &propertyCount);
    for (unsigned i = 0; i < propertyCount; i++)
    {
        objc_property_t property = propertyList[i];
        const char *name = property_getName(property);
        //得到key，value
        NSString *key = [NSString stringWithUTF8String:name];
        if (key.length > 0)
        {
            SEL _setter = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",[key substringToIndex:1].uppercaseString,[key substringFromIndex:1]]);
            SEL _getter = NSSelectorFromString(key);
            if ([self respondsToSelector:_setter] && [self respondsToSelector:_getter])
            {
                if ([[self class] accessInstanceVariablesDirectly] && ![key isEqualToString:@"observationInfo"])
                {
                    id value = [self valueForKey:key];
                    if ((nil != value) && ![value isKindOfClass:[NSNull class]] && [value respondsToSelector:@selector(copyWithZone:)])
                    {
                        if ([value isKindOfClass:[NSArray class]])
                        {
                            [objectNew setValue:[self copyArray:value] forKey:key];
                        }
                        else
                        {
                            [objectNew setValue:[value copyWithZone:zone] forKey:key];
                        }
                    }
                }
            }
        }
        
    }
    free(propertyList);
    
    Class supCls = class_getSuperclass(cls);
    if (supCls && supCls != [NSObject class])
    {
        [self copyWithClass:supCls zone:zone toNew:objectNew];
    }
}

- (id)copyArray:(NSArray *)array
{
    NSMutableArray *arr = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arr addObject:[obj copy]];
    }];
    
    return [arr copy];
}


@end
