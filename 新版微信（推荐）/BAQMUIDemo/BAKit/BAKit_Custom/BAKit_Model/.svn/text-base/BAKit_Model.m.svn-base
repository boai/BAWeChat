//
//  BAKit_Model.m
//  yunlianWIFI
//
//  Created by boai on 2017/4/10.
//  Copyright © 2017年 yunlianhui. All rights reserved.
//

#import "BAKit_Model.h"

@implementation BAKit_Model

- (instancetype)init
{
    if ([self isMemberOfClass:[BAKit_Model class]])
    {
        NSAssert(0, @"基类不能创建对象！");
        return nil;
    }
    return [super init];
}

+ (instancetype )allocWithZone:(struct _NSZone *)zone
{
    return [[super allocWithZone:zone] init];
}

+ (instancetype)ba_modelParseWith:(id)object
{
    if ([object isKindOfClass:[NSDictionary class]])
    {
        return [[self class] yy_modelWithDictionary:object];
    }
    return [[self class] yy_modelWithJSON:object];
}

@end

@implementation NSArray (BAKit_Model)

- (NSArray *)ba_modelParseArrayWithClass:(Class)class
{
    if (self.count > 0)
    {
        NSObject *obj = self[0];
        if ([obj isMemberOfClass:class])
        {
            return self;
        }
    }
    return [NSArray yy_modelArrayWithClass:class json:self];
}

@end

@implementation NSMutableArray (BAKit_Model)

- (NSMutableArray *)ba_modelParseMutableArrayWithClass:(Class)class
{
    if (self.count > 0)
    {
        NSObject *obj = self[0];
        if ([obj isKindOfClass:class])
        {
            return self;
        }
    }
    return [[self ba_modelParseArrayWithClass:class] mutableCopy];
}

@end

@implementation BAKit_Page

- (id)init
{
    self = [super init];
    if(self)
    {
        _m_count = 0;
        _m_pageSize = 10;
        _m_cuPage = 1;
    }
    return self;
}

/*!
 *  是否已到最后一页
 *
 *  @return 是否
 */
- (BOOL)ba_pageIsEnd
{
    int maxNum = _m_cuPage * _m_pageSize;
    NSLog(@"%d,%d,%d",_m_cuPage,_m_pageSize,_m_count);
    if(maxNum >= _m_count) return YES;
    return NO;
}

/*!
 *  获得下一个页面请求的页码数。
 *
 *  @return 页码数
 */
- (int)ba_pageGetNextPage
{
    NSLog(@"%d,%d,%d",_m_cuPage,_m_pageSize,_m_count);
    if([self ba_pageIsEnd])
        return -1;
    else
        return _m_cuPage+1;
}


- (BOOL)ba_pageIsEnd:(int)cupage pageSize:(int)pageSize pageCount:(int)pageCount
{
    _m_cuPage = cupage;
    _m_pageSize = pageSize;
    _m_count = pageCount;
    
    NSLog(@"%d,%d,%d",_m_cuPage,_m_pageSize,_m_count);
    
    int maxNum = _m_cuPage * _m_pageSize;
    if(maxNum >= _m_count) return YES;
    return NO;
}

- (int)ba_pageGetNextPage:(int)cupage pageSize:(int)pageSize pageCount:(int)pageCount
{
    _m_cuPage = cupage;
    _m_pageSize = pageSize;
    _m_count = pageCount;
    
    NSLog(@"页码：%d,%d,%d",_m_cuPage,_m_pageSize,_m_count);
    if([self ba_pageIsEnd])
        return -1;
    else
        return _m_cuPage+1;
}

@end

