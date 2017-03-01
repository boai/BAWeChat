//
//  BATimeLineCommentViewModel.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/16.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BATimeLineCommentModel;
@interface BATimeLineCommentViewModel : NSObject

@property (nonatomic, strong) BATimeLineCommentModel *model;

/*! 评论 Label 的 frame */
@property (nonatomic, assign) CGRect commentLabelFrame;

/*! 评论 View 的 frame */
@property (nonatomic, assign) CGRect commentViewFrame;



// cell的高度
@property (nonatomic, assign) CGFloat cellHeight;


@end
