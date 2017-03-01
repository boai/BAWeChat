//
//  BATimeLineLikeView.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/9.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BATimeLineLikeView.h"
#import "BATimeLineModel.h"
#import "BATimeLineViewModel.h"

@implementation BATimeLineLikeView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    self.userInteractionEnabled = YES;
    self.backgroundColor = UIColorGray8;
}


#pragma mark - custom method
- (void)setupFrame
{
    
}

- (void)setupData
{
    
}

#pragma mark - setter / getter
- (void)setTimeLineViewModel:(BATimeLineViewModel *)timeLineViewModel
{
    _timeLineViewModel = timeLineViewModel;
    [self setupFrame];
    [self setupData];
}

@end
