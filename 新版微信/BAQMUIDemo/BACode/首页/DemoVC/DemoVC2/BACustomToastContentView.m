//
//  BACustomToastContentView.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/10.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BACustomToastContentView.h"

static UIEdgeInsets const kInsets = {12, 12, 12, 12};
static CGFloat const kImageViewHeight = 86;
static CGFloat const kImageViewMarginRight = 12;
static CGFloat const kTextLabelMarginBottom = 4;

@implementation BACustomToastContentView

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
    _imageView                         = [[UIImageView alloc] init];
    self.imageView.contentMode         = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds       = YES;
    self.imageView.layer.cornerRadius  = 4;
    
    _titleLabel                        = [[UILabel alloc] init];
    self.titleLabel.textColor          = UIColorWhite;
    self.titleLabel.font               = UIFontBoldMake(17);
    self.titleLabel.opaque             = NO;
    
    _detailTextLabel                   = [[UILabel alloc] init];
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.textAlignment = NSTextAlignmentJustified;
    self.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.detailTextLabel.textColor     = UIColorWhite;
    self.detailTextLabel.font          = UIFontMake(14);
    self.detailTextLabel.opaque        = NO;
    
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailTextLabel];
}

- (void)ba_renderWitherImage:(UIImage *)image
                       title:(NSString *)title
                  detailText:(NSString *)detailText
{
    self.imageView.image = image;
    self.titleLabel.text = title;
    self.detailTextLabel.text = detailText;
    
    [self.imageView sizeToFit];
    [self.titleLabel sizeToFit];
    [self.detailTextLabel sizeToFit];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    /*! 
     fminf 函数 (fast_math) 【Visual Studio 2015】
     确保参数的最小数值
     返回参数的最小数值
     inline float fminf(
         float _X,
         float _Y
     ) restrict(amp);

     */
    CGFloat view_width = fminf(size.width, SCREEN_WIDTH);
    CGFloat view_height = kImageViewHeight + UIEdgeInsetsGetVerticalValue(kInsets);
    return CGSizeMake(fminf(size.width, view_width), fminf(size.height, view_height));
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.imageView qmui_sizeToFitKeepingImageAspectRatioInSize:CGSizeMake(kCGFontIndexMax, kImageViewHeight)];
    
    CGFloat content_width = CGRectGetWidth(self.bounds);
    CGFloat maxContent_width = content_width - UIEdgeInsetsGetVerticalValue(kInsets);
    CGFloat label_width = maxContent_width - self.imageView.width - kImageViewMarginRight;
    
    self.imageView.frame = CGRectSetXY(self.imageView.frame, kInsets.left, kInsets.top);
    
    self.titleLabel.frame = CGRectFlatMake(CGRectGetMaxX(self.imageView.frame) + kImageViewMarginRight, CGRectGetMinY(self.imageView.frame) + 5, label_width, CGRectGetHeight(self.titleLabel.bounds));
    
    CGFloat detailLimitHeight = CGRectGetHeight(self.bounds) - CGRectGetMaxY(self.titleLabel.frame) - kTextLabelMarginBottom - kInsets.bottom;
    CGSize detailSize = [self.detailTextLabel sizeThatFits:CGSizeMake(label_width, detailLimitHeight)];
    self.detailTextLabel.frame = CGRectFlatMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + kTextLabelMarginBottom, label_width, fminf(detailLimitHeight, detailSize.height));
}





@end
