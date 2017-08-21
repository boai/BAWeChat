//
//  BATimeLineContentView.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/9.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BATimeLineViewModel, BATimeLineOperationMenuView;
@interface BATimeLineContentView : UIImageView

@property (nonatomic, strong) BATimeLineViewModel *timeLineViewModel;

/*! 操作 View */
@property (nonatomic, strong) BATimeLineOperationMenuView *operationMenuView;

/*!
 *  操作 View block
 */
@property (nonatomic, copy) void (^handleOperationMenuViewButtonActionBlock)(BATimeLineOperationMenuView *tempView);

@end
