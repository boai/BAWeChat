//
//  BATimeLineModel.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/9.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BAUser, BATimeLineCommentModel;
@interface BATimeLineModel : NSObject

/*!
 *  发表用户
 */
@property (nonatomic, strong) BAUser *user;

/*!
 *  创建时间
 */
@property (nonatomic, copy) NSString *created_time;

/*!
 *  发表内容
 */
@property (nonatomic, copy) NSString *content;

/*!
 *  朋友圈来源
 */
@property (nonatomic, copy) NSString *source;

/*!
 *  配图数组(BAPhoto)
 */
@property (nonatomic, strong) NSArray <NSString *>*pic_urls;

/*!
 *  内容 ID
 */
@property (nonatomic, copy) NSString *contentId;

/*!
 *  内容的评论
 */
@property (nonatomic, strong) NSArray <BATimeLineCommentModel *>*comments;


@end

@interface BATimeLineCommentModel : NSObject

@property (nonatomic, copy) NSString *commentContent;

@property (nonatomic, strong) BAUser *firstUser;
@property (nonatomic, strong) BAUser *secondUser;

@property (nonatomic, copy) NSAttributedString *attributedContent;

@end

