//
//  BATimeLineViewModel.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/9.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BATimeLineModel;
@interface BATimeLineViewModel : NSObject

/*! 原始数据 */
@property (nonatomic, strong) BATimeLineModel *model;

/*! 头像的 frame */
@property (nonatomic, assign) CGRect iconImageViewFrame;

/*! 昵称的 frame */
@property (nonatomic, assign) CGRect nameLabelFrame;

/*! 正文的 frame */
@property (nonatomic, assign) CGRect contentLabelFrame;

/*! 时间的 frame */
@property (nonatomic, assign) CGRect timeLabelFrame;

/*! 点赞和评论按钮的 frame */
@property (nonatomic, assign) CGRect operationButtonFrame;

/*! 来源的 frame */
@property (nonatomic, assign) CGRect sourceLabelFrame;

/*! 原创朋友圈的 frame */
@property (nonatomic, assign) CGRect originalContentViewFrame;

/*! 图片 View 的 frame */
@property (nonatomic, assign) CGRect photoViewFrame;

/*! 评论 Label 的 frame */
@property (nonatomic, assign) CGRect commentLabelFrame;

/*! 评论 View 的 frame */
@property (nonatomic, assign) CGRect commentViewFrame;


/*! cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/*! cell的内容Frame */
- (void)setUpContentFrame;

@end
