//
//  BAGridViewTypeTitleDescCell.m
//  yunlianWIFI
//
//  Created by boai on 2017/4/14.
//  Copyright © 2017年 yunlianhui. All rights reserved.
//

#import "BAGridViewTypeTitleDescCell.h"
#import "BAGridItemModel.h"

@interface BAGridViewTypeTitleDescCell ()

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *descLabel;

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
}

- (void)setModel:(BAGridItemModel *)model
{
    _model = model;
    
    self.descLabel.text = model.desc;
    self.titleLabel.text = model.titleString;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat view_w = self.bounds.size.width;
    CGFloat view_h = self.bounds.size.height;

    CGFloat titleLabel_x = 0;
    CGFloat titleLabel_w = view_w;
    CGFloat titleLabel_h = BAKit_Margin_25;
    CGFloat titleLabel_y = view_h/2 - titleLabel_h;

    CGFloat descLabel_w = view_w;
    CGFloat descLabel_h = BAKit_Margin_20;
    CGFloat descLabel_x = 0;
    CGFloat descLabel_y = view_h/2;
    
    self.titleLabel.frame = BAKit_CGRectFlatMake(titleLabel_x, titleLabel_y, titleLabel_w, titleLabel_h);
    self.descLabel.frame = BAKit_CGRectFlatMake(descLabel_x, descLabel_y, descLabel_w, descLabel_h);
}

#pragma mark - setter / getter

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel new];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = BAKit_Color_ThemYellow;
        self.titleLabel.font = BAKit_FontSystem_25;
        
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
        self.descLabel.textColor = BAKit_Color_Gray_7;
        self.descLabel.font = BAKit_FontSystem_12;
        
        [self addSubview:_descLabel];
    }
    return _descLabel;
}



@end
