//
//  BAKit_Model.h
//  yunlianWIFI
//
//  Created by boai on 2017/4/10.
//  Copyright © 2017年 yunlianhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>


/**
 *  用于解析json数据,子类模型继承此类（不包含coding跟copying，包含则继承自BaseCodingCopyingItem或BaseCodingCopyingWithResultObjectItem即可）
 *
 *  说明：
 *  1.如果属性是数组的话，需要手动（建议在数组的setter方法里面）解析，例如：
 *
 方法一：
 -(void )setArrayData:(NSArray *)arrayData
 {
     _arrayData = [arrayData modelArrayWithClass:[PModel class]];
 }
 
 方法二：
 -(void )setArrayData:(NSArray *)arrayData
 {
     NSMutableArray *arr = [NSMutableArray array];
     [arrayData enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         [arr addObject:[PModel modelWithDict:obj]];
     }];
     _arrayData = [arr copy];
 }
 *
 *  2.如果属性名跟json字段名不一样，实现协议方法
 *      + (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper;
 *  修改字段名称映射即可，不懂看YYModel源码注释
 *
 */
@class BAKit_Page;

@interface BAKit_Model : NSObject<YYModel>

@property(nonatomic, assign) int m_result;   ///结果
@property(nonatomic, retain) NSString * m_msg;      ///提示信息
@property(nonatomic, retain) id m_dataObj;          ///对象
@property(nonatomic, retain) BAKit_Page * m_page;       ///分页


+ (instancetype)ba_modelParseWith:(id)object;

@end

@interface NSArray (BAKit_Model)

- (NSArray *)ba_modelParseArrayWithClass:(Class)class;

@end

@interface NSMutableArray (BAKit_Model)

- (NSMutableArray *)ba_modelParseMutableArrayWithClass:(Class)class;

@end

/*!
 *  分页控制类
 */
@interface BAKit_Page : NSObject

@property(nonatomic, assign) int m_count; ///当前所有记录
@property(nonatomic, assign) int m_pageSize;   ///一页展示的数量
@property(nonatomic, assign) int m_cuPage;   ///当前页数

/*!
 *  是否已到最后一页
 *
 *  @return 是否
 */
- (BOOL)ba_pageIsEnd;

/*!
 *  获得下一个页面请求的页码数。
 *
 *  @return 页码数
 */
- (int)ba_pageGetNextPage;

- (BOOL)ba_pageIsEnd:(int)cupage pageSize:(int)pageSize pageCount:(int)pageCount;

- (int)ba_pageGetNextPage:(int)cupage pageSize:(int)pageSize pageCount:(int)pageCount;

@end
