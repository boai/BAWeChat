//
//  BAGridView.h
//  yunlianWIFI
//
//  Created by boai on 2017/4/6.
//  Copyright © 2017年 yunlianhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BAGridItemModel;


/**
 宫格样式

 - BAGridViewTypeImageTitle: 上面是图片，下面是文字
 - BAGridViewTypeTitleDesc: 上下都是文字，上面标题字体大，下面是详情字体小
 */
typedef NS_ENUM(NSUInteger, BAGridViewType) {
    BAGridViewTypeImageTitle = 0,
    BAGridViewTypeTitleDesc
};

/**
 BAGridView 回调

 @param model 返回 BAGridItemModel
 @param indexPath indexPath
 */
typedef void (^BAGridViewBlock)(BAGridItemModel *model, NSIndexPath *indexPath);

@interface BAGridView : UIView

@property(nonatomic, assign) BAGridViewType gridViewType;

/**
 数据源：来自 BAGridItemModel
 */
@property(nonatomic, strong) NSArray <BAGridItemModel *>*dataArray;

/**
 item 点击回调
 */
@property(nonatomic, copy)   BAGridViewBlock gridViewBlock;

/**
 item 的 size，默认为4个，正方形方格
 */
@property(nonatomic, assign) CGSize gridViewItemSize;


/**
 快速创建 BAGridView

 @param type 宫格样式
 @param itemSize item 的 size
 @param dataArray 数据源：来自 BAGridItemModel
 @param block BAGridView 回调
 @return 返回 BAGridView
 */
- (instancetype)ba_creatGridViewWithType:(BAGridViewType)type
                                itemSize:(CGSize)itemSize
                               dataArray:(NSArray <BAGridItemModel *>*)dataArray
                                   block:(BAGridViewBlock)block;

@end
