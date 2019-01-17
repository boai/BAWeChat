//
//  BATimeLineOperationMenuView.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/17.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BATimeLineOperationMenuView : UIImageView

/*!
 *  是否显示操作按钮
 */
@property (nonatomic, assign, getter = isShowOperationMenuView) BOOL showOperationMenuView;

/*!
 *  点赞按钮 block
 */
@property (nonatomic, copy) void (^likedButtonActionBlock)();

/*!
 *  评论按钮 block
 */
@property (nonatomic, copy) void (^commentButtonActionBlock)();

@end
