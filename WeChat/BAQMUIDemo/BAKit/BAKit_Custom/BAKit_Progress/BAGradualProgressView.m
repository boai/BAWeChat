//
//  BAGradualProgressView.m
//  BAKit
//
//  Created by boai on 2017/6/26.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAGradualProgressView.h"

@interface BAGradualProgressView ()<CAAnimationDelegate>

@property(nonatomic, strong) CALayer *layer_mask;

@end

@implementation BAGradualProgressView

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
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    CAGradientLayer *layer = (CAGradientLayer *)[self layer];
    layer.startPoint = CGPointMake(0.0, 0.5);
    layer.endPoint = CGPointMake(1.0, 0.5);
    
    NSMutableArray *colorArray = @[].mutableCopy;
    for (NSInteger i = 0; i <= 360; i += 5)
    {
        UIColor *color = [UIColor colorWithHue:1.0 * i / 360 saturation:1.0 brightness:1.0 alpha:1.0];
        [colorArray addObject:(id)color.CGColor];
    }
    layer.colors = [colorArray mutableCopy];
    
    self.layer_mask = [CALayer layer];
    self.layer_mask.frame = CGRectMake(0, 0, 0, self.bounds.size.height);
    self.layer_mask.backgroundColor = BAKit_Color_Black.CGColor;
    layer.mask = self.layer_mask;
    
    [self ba_progressAnimation];
}

- (void)ba_progressAnimation
{
    CAGradientLayer *layer = (CAGradientLayer *)[self layer];
    NSMutableArray *colorArray = [[layer colors] mutableCopy];
    
    UIColor *lastColor = colorArray.lastObject;
    [colorArray removeLastObject];
    [colorArray insertObject:lastColor atIndex:0];
    
    NSArray *shiftedColors = [NSArray arrayWithArray:colorArray];
    layer.colors = shiftedColors;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.toValue = shiftedColors;
    animation.duration = 0.08f;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    
    [layer addAnimation:animation forKey:@"animateGradient"];
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    [self ba_progressAnimation];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect maskRect = self.layer_mask.frame;
    maskRect.size.width = CGRectGetWidth(self.bounds) * self.progress;
    self.layer_mask.frame = maskRect;
}

- (void)setProgress:(CGFloat)progress
{
    if (_progress != progress)
    {
        _progress = MIN(1.0, fabs(progress));
        [self setNeedsLayout];
    }
}

+ (Class)layerClass
{
    return [CAGradientLayer class];
}


@end
