//
//  BAGridCollectionCell.m
//  BAKit
//
//  Created by boai on 2017/4/14.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BAGridCollectionCell.h"
#import "BAGridItemModel.h"
#import "BAKit_ConfigurationDefine.h"

#import "NSString+BAGridView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BAGridCollectionCell ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIView *lineView_w;
@property(nonatomic, strong) UIView *lineView_h;

@end

@implementation BAGridCollectionCell

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
    self.imageView.hidden = NO;
    
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
    
    min_w = view_h * 0.4;
    min_h = min_w;
    min_x = (view_w - min_w) / 2;
    min_y = CGRectGetMidY(self.bounds) - min_w / 2 - view_h * 0.15;
    self.imageView.frame = BAKit_CGRectFlatMake_pod(min_x, min_y, min_w, min_h);
    
    min_x = 0;
    min_y = CGRectGetMaxY(self.imageView.frame) + self.ba_gridView_itemImageInset;
    min_w = view_w - self.ba_gridView_lineWidth;
    min_h = view_h - min_y;
    self.titleLabel.frame = BAKit_CGRectFlatMake_pod(min_x, min_y, min_w, min_h);
    
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
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = BAKit_Color_Clear_pod;
        
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
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
    
    if ([NSString ba_regularIsUrl:model.imageName])
    {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:BAKit_ImageName(model.placdholderImageName)];
    }
    else
    {
        self.imageView.image = BAKit_ImageName(model.imageName);
    }
    self.titleLabel.text = model.titleString;
    
}

- (void)setBa_gridView_titleColor:(UIColor *)ba_gridView_titleColor
{
    _ba_gridView_titleColor = ba_gridView_titleColor;
    
    self.titleLabel.textColor = ba_gridView_titleColor;
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

@end
