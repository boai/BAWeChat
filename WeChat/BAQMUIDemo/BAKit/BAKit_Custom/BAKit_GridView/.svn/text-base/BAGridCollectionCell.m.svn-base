//
//  BAGridCollectionCell.m
//  yunlianWIFI
//
//  Created by boai on 2017/4/6.
//  Copyright © 2017年 yunlianhui. All rights reserved.
//

#import "BAGridCollectionCell.h"
#import "BAGridItemModel.h"

@interface BAGridCollectionCell ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;

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
}

- (void)setModel:(BAGridItemModel *)model
{
    _model = model;
    
    self.imageView.image = BAKit_ImageName(model.imageName);
    self.titleLabel.text = model.titleString;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGFloat view_h = self.bounds.size.height;
    CGFloat view_w = self.bounds.size.width;
    CGFloat imageView_w = BAKit_Margin_40;
    CGFloat imageView_h = imageView_w;
    CGFloat imageView_x = (view_w - imageView_w)/2;
    CGFloat imageView_y = BAKit_Margin_20;

    CGFloat titleLabel_w = view_w;
    CGFloat titleLabel_h = BAKit_Margin_20;
    
    self.imageView.frame = BAKit_CGRectFlatMake(imageView_x, imageView_y, imageView_w, imageView_h);
    self.titleLabel.frame = BAKit_CGRectFlatMake(0, self.imageView.bottom + BAKit_Margin_5, titleLabel_w, titleLabel_h);
}

#pragma mark - setter / getter
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = BAKit_Color_Gray_6;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = BAKit_FontSystem_13;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = BAKit_Color_Clear;
        
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

@end
