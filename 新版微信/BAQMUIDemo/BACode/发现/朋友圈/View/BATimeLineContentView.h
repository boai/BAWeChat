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

///*!
// *  点赞按钮 block
// */
//@property (nonatomic, copy) void (^likedButtonActionBlock)();
//
///*!
// *  评论按钮 block
// */
//@property (nonatomic, copy) void (^commentButtonActionBlock)();

@end
