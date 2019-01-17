//
//  BAGridViewTypeTitleDescCell.m
//  BAKit
//
//  Created by boai on 2017/4/14.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BAGridViewTypeTitleDescCell.h"
#import "BAGridItemModel.h"
#import "BAKit_ConfigurationDefine.h"
#import "BAGridView_Config.h"

@interface BAGridViewTypeTitleDescCell ()

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *descLabel;

@property(nonatomic, strong) UIView *lineView_w;
@property(nonatomic, strong) UIView *lineView_h;

@end

@implementation BAGridViewTypeTitleDescCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.titleLabel.hidden = NO;
    self.descLabel.hidden = NO;
    
    self.lineView_w.backgroundColor = BAKit_Color_Gray_11_pod;
    self.lineView_h.backgroundColor = BAKit_Color_Gray_11_pod;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat view_w = self.bounds.size.width;
    CGFloat view_h = self.bounds.size.height;
    
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    
    min_x = 0;
    min_w = view_w - self.config.ba_gridView_lineWidth;
    min_h = view_h * 0.4;
    min_y = CGRectGetMidY(self.bounds) - min_h / 2 - view_h * 0.15;
    self.titleLabel.frame = BAKit_CGRectFlatMake_pod(min_x, min_y, min_w, min_h);
    
    min_y = CGRectGetMaxY(self.titleLabel.frame) + self.config.ba_gridView_itemImageInset;
    min_h = view_h * 0.3;
    self.descLabel.frame = BAKit_CGRectFlatMake_pod(min_x, min_y, min_w, min_h);
    
    min_x = view_w - self.config.ba_gridView_lineWidth;
    min_y = 0;
    min_w = self.config.ba_gridView_lineWidth;
    min_h = view_h;
    self.lineView_h.frame = BAKit_CGRectFlatMake_pod(min_x, min_y, min_w, min_h);
    
    min_x = 0;
    min_y = view_h - self.config.ba_gridView_lineWidth;
    min_w = view_w;
    min_h = self.config.ba_gridView_lineWidth;
    self.lineView_w.frame = BAKit_CGRectFlatMake_pod(min_x, min_y, min_w, min_h);
}

#pragma mark - setter / getter

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel new];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:25];
        
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)descLabel
{
    if (!_descLabel)
    {
        _descLabel = [UILabel new];
        self.descLabel.textAlignment = NSTextAlignmentCenter;
        self.descLabel.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:_descLabel];
    }
    return _descLabel;
}

- (UIView *)lineView_w
{
    if (!_lineView_w)
    {
        _lineView_w = [UIView new];
        
        [self.contentView addSubview:_lineView_w];
    }
    return _lineView_w;
}

- (UIView *)lineView_h
{
    if (!_lineView_h)
    {
        _lineView_h = [UIView new];
        
        [self.contentView addSubview:_lineView_h];
    }
    return _lineView_h;
}

- (void)setConfig:(BAGridView_Config *)config {
    _config = config;
    
    self.titleLabel.text = config.model.titleString;
    self.titleLabel.font = config.ba_gridView_titleFont;
    self.titleLabel.textColor = config.ba_gridView_titleColor;
    
    self.descLabel.text = config.model.desc;
    self.descLabel.font = config.ba_gridView_titleDescFont;
    self.descLabel.textColor = config.ba_gridView_titleDescColor;
    
    self.lineView_h.backgroundColor = config.ba_gridView_lineColor;
    self.lineView_w.backgroundColor = config.ba_gridView_lineColor;

}



@end
