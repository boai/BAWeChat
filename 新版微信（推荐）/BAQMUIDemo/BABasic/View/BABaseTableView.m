//
//  BABaseTableView.m
//  BAQMUIDemo
//
//  Created by boai on 2017/3/18.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BABaseTableView.h"

@implementation BABaseTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupUI];
    }
    return self;
}

//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//        [self setupUI];
//    }
//    return self;
//}

- (void)setupUI
{
    self.delaysContentTouches = NO;
    self.canCancelContentTouches = YES;
//    self.separatorStyle = UITableViewCellSelectionStyleNone;
//    self.backgroundColor = BAKit_Color_Clear;
    
    self.isNeedFootView = NO;
    UIView *wrapView = self.subviews.firstObject;
    if (wrapView && [NSStringFromClass(wrapView.class) hasSuffix:@"WrapperView"])
    {
        for (UIGestureRecognizer *gesture in wrapView.gestureRecognizers)
        {
            if ([NSStringFromClass(gesture.class) containsString:@"DelayedTouchesBegan"])
            {
                gesture.enabled = NO;
                break;
            }
        }
    }
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ([view isKindOfClass:[UIControl class]])
    {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

- (void)setIsNeedFootView:(BOOL)isNeedFootView
{
    _isNeedFootView = isNeedFootView;
    
    if (!isNeedFootView)
    {
        self.tableFooterView = [UIView new];
    }
    
    [self reloadData];
}


@end
