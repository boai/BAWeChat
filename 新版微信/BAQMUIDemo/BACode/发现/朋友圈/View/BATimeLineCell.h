//
//  BATimeLineCell.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/9.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BATimeLineViewModel, BATimeLineContentView;
@interface BATimeLineCell : UITableViewCell

@property (nonatomic, strong) BATimeLineViewModel *timeLineViewModel;

@property (nonatomic, strong) BATimeLineContentView *originalContentView;

+ (instancetype)timeLineCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

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
