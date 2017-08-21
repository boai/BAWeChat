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
    min_w = view_w - self.ba_gridView_lineWidth;
    min_h = view_h * 0.4;
    min_y = CGRectGetMidY(self.bounds) - min_h / 2 - view_h * 0.15;
    self.titleLabel.frame = BAKit_CGRectFlatMake_pod(min_x, min_y, min_w, min_h);
    
    min_y = CGRectGetMaxY(self.titleLabel.frame) + self.ba_gridView_itemImageInset;
    min_h = view_h * 0.3;
    self.descLabel.frame = BAKit_CGRectFlatMake_pod(min_x, min_y, min_w, min_h);
    
//    min_w = view_h * 0.4;
//    min_h = min_w;
//    min_x = (view_w - min_w) / 2;
//    min_y = CGRectGetMidY(self.bounds) - min_w / 2 - view_h * 0.15;
//    self.imageView.frame = BAKit_CGRectFlatMake_pod(min_x, min_y, min_w, min_h);
//    
//    min_x = 0;
//    min_y = CGRectGetMaxY(self.imageView.frame) + self.ba_gridView_itemImageInset;
//    min_w = view_w - self.ba_gridView_lineWidth;
//    min_h = view_h - min_y;
//    self.titleLabel.frame = BAKit_CGRectFlatMake_pod(min_x, min_y, min_w, min_h);
    
    
    min_x = view_w - self.ba_gridView_lineWidth;
    min_y = 0;
    min_w = self.ba_gridView_lineWidth;
    min_h = view_h;
    self.lineView_h.frame = BAKit_CGRectFlatMake_pod(min_x, min_y, min_w, min_h);
    
    min_x = 0;
    min_y = view_h - self.ba_gridView_lineWidth;
    min_w = view_w;
    min_h = self.ba_gridView_lineWidth;
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

- (void)setModel:(BAGridItemModel *)model
{
    _model = model;
    
    self.descLabel.text = model.desc;
    self.titleLabel.text = model.titleString;
}

- (void)setBa_gridView_titleColor:(UIColor *)ba_gridView_titleColor
{
    _ba_gridView_titleColor = ba_gridView_titleColor;
    
    self.titleLabel.textColor = ba_gridView_titleColor;
}

- (void)setBa_gridView_titleDescColor:(UIColor *)ba_gridView_titleDescColor
{
    _ba_gridView_titleDescColor = ba_gridView_titleDescColor;
    
    self.descLabel.textColor = ba_gridView_titleDescColor;
}

- (void)setBa_gridView_lineColor:(UIColor *)ba_gridView_lineColor
{
    _ba_gridView_lineColor = ba_gridView_lineColor;
    
    self.lineView_w.backgroundColor = ba_gridView_lineColor;
    self.lineView_h.backgroundColor = ba_gridView_lineColor;
}

- (void)setBa_gridView_lineWidth:(CGFloat)ba_gridView_lineWidth
{
    _ba_gridView_lineWidth = ba_gridView_lineWidth;
}

- (void)setBa_gridView_titleFont:(UIFont *)ba_gridView_titleFont
{
    _ba_gridView_titleFont = ba_gridView_titleFont;
    self.titleLabel.font = ba_gridView_titleFont;
}

- (void)setBa_gridView_titleDescFont:(UIFont *)ba_gridView_titleDescFont
{
    _ba_gridView_titleDescFont = ba_gridView_titleDescFont;
    self.descLabel.font = ba_gridView_titleDescFont;
}

@end
