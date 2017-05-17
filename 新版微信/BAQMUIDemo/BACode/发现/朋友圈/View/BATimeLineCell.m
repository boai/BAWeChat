//
//  BATimeLineCell.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/9.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BATimeLineCell.h"

#import "BATimeLineContentView.h"

#import "BATimeLineViewModel.h"

@interface BATimeLineCell ()


@end

@implementation BATimeLineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUpSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setUpSubViews
{
    self.originalContentView.hidden = NO;
}

+ (instancetype)timeLineCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
//    NSString *cellID = [NSString stringWithFormat:@"%ld%ldcell", indexPath.section, indexPath.row];
    static NSString *cellID = @"BATimeLineCell";
    BATimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (!cell)
    {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    else
    {

    }
    return cell;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
//    self.originalContentView.frame = CGRectZero;
//    self.originalContentView.timeLineViewModel = nil;
}

- (void)setTimeLineViewModel:(BATimeLineViewModel *)timeLineViewModel
{
    _timeLineViewModel = timeLineViewModel;
    
    self.originalContentView.frame = _timeLineViewModel.originalContentViewFrame;
    self.originalContentView.height = _timeLineViewModel.cellHeight;
    self.originalContentView.timeLineViewModel = _timeLineViewModel;
}

//- (void)layoutSubviews
//{
////    self.originalContentView.frame = _timeLineViewModel.originalContentViewFrame;
//}

- (BATimeLineContentView *)originalContentView {
	if(_originalContentView == nil) {
		_originalContentView = [[BATimeLineContentView alloc] init];
        
        [self.contentView addSubview:self.originalContentView];
	}
	return _originalContentView;
}

@end
