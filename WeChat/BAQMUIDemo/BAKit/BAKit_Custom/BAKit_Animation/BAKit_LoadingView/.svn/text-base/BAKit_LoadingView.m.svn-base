//
//  BALoadingView.m
//  BAAnimation
//
//  Created by 博爱 on 2016/12/30.
//  Copyright © 2016年 DS-Team. All rights reserved.
//

#import "BAKit_LoadingView.h"


/*!
 *  获取屏幕宽度和高度
 */
#define BA_SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define BA_SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define BA_ORIGIN_X    self.frame.origin.x
#define BA_ORIGIN_Y    self.frame.origin.y


@interface BAKit_LoadingView ()

@property (nonatomic, strong) UIView *loadingView1;
@property (nonatomic, strong) UIView *loadingView2;
@property (nonatomic, strong) UIView *loadingView4;

@property (nonatomic, strong) UIView *shapeView1;
@property (nonatomic, strong) UIView *shapeView2;
@property (nonatomic, strong) UIView *shapeView3;

@property (nonatomic, strong) UIView *shapeView4;
@property (nonatomic, strong) UIView *shapeView5;
@property (nonatomic, strong) UIView *shapeView6;
@property (nonatomic, strong) UIView *shapeView7;
@property (nonatomic, strong) UIView *shapeView8;

@property (nonatomic, strong) UIView *shapeView9;
@property (nonatomic, strong) UIView *shapeView10;
@property (nonatomic, strong) UIView *shapeView11;


@end

@implementation BAKit_LoadingView

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
    self.loadingType = BALoadingViewTypeBall;
//    self.themColor = [UIColor colorWithRed:0 green:165 blue:255 alpha:1.0f];
    self.ballSize = 20;
    self.ballColorsArray = @[[UIColor greenColor], [UIColor redColor], [UIColor blueColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [self setupAnimateView];
}

- (BOOL)willDealloc
{
    return NO;
}

- (void)dealloc
{
    [BAKit_NotiCenter removeObserver:self];
    
    if (self.shapeView1)
    {
        [self.shapeView1 removeFromSuperview];
        self.shapeView1 = nil;
    }
    if (self.shapeView2)
    {
        [self.shapeView2 removeFromSuperview];
        self.shapeView2 = nil;
    }
    if (self.shapeView3)
    {
        [self.shapeView3 removeFromSuperview];
        self.shapeView3 = nil;
    }
    if (self.shapeView4)
    {
        [self.shapeView4 removeFromSuperview];
        self.shapeView4 = nil;
    }
    if (self.shapeView5)
    {
        [self.shapeView5 removeFromSuperview];
        self.shapeView5 = nil;
    }
    if (self.shapeView6)
    {
        [self.shapeView6 removeFromSuperview];
        self.shapeView6 = nil;
    }
    if (self.shapeView7)
    {
        [self.shapeView7 removeFromSuperview];
        self.shapeView7 = nil;
    }
    if (self.shapeView8)
    {
        [self.shapeView8 removeFromSuperview];
        self.shapeView8 = nil;
    }
    if (self.shapeView9)
    {
        [self.shapeView9 removeFromSuperview];
        self.shapeView9 = nil;
    }
    if (self.shapeView10)
    {
        [self.shapeView10 removeFromSuperview];
        self.shapeView10 = nil;
    }
    if (self.shapeView11)
    {
        [self.shapeView11 removeFromSuperview];
        self.shapeView11 = nil;
    }
    
    if (self.loadingView1)
    {
        [self.loadingView1 removeFromSuperview];
        self.loadingView1 = nil;
    }
    if (self.loadingView2)
    {
        [self.loadingView2 removeFromSuperview];
        self.loadingView2 = nil;
    }
    
    if (self.loadingView4)
    {
        [self.loadingView4 removeFromSuperview];
        self.loadingView4 = nil;
    }
}

- (void)handleWillEnterForeground:(NSNotification *)notification
{
    [self beginAnimation];
}

- (void)setupAnimateView
{
    self.shapeView1 = [[UIView alloc] init];
    self.shapeView2 = [[UIView alloc] init];
    self.shapeView3 = [[UIView alloc] init];

    self.shapeView4 = [[UIView alloc] init];
    self.shapeView5 = [[UIView alloc] init];
    self.shapeView6 = [[UIView alloc] init];
    self.shapeView7 = [[UIView alloc] init];
    self.shapeView8 = [[UIView alloc] init];

    self.shapeView9 = [[UIView alloc] init];
    self.shapeView10 = [[UIView alloc] init];
    self.shapeView11 = [[UIView alloc] init];

    [self ba_setBallColor];
    [self ba_setBallCornerRadius];

    [self.loadingView1 addSubview:self.shapeView1];
    [self.loadingView1 addSubview:self.shapeView2];
    [self.loadingView1 addSubview:self.shapeView3];
    
    [self.loadingView2 addSubview:self.shapeView4];
    [self.loadingView2 addSubview:self.shapeView5];
    [self.loadingView2 addSubview:self.shapeView6];
    [self.loadingView2 addSubview:self.shapeView7];
    [self.loadingView2 addSubview:self.shapeView8];
    
    [self.loadingView4 addSubview:self.shapeView9];
    [self.loadingView4 addSubview:self.shapeView10];
    [self.loadingView4 addSubview:self.shapeView11];
    
    self.shapeView10.backgroundColor = [UIColor blackColor];

    [self beginAnimation];
}

- (void)beginAnimation
{
    [self updateWithType];

    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animation];
    positionAnimation.keyPath = @"position.x";
    positionAnimation.values = @[@-5, @0, @10, @40, @70, @80, @75];
    positionAnimation.keyTimes = @[@0, @(5 / 90.0), @(15 / 90.0), @(45 / 90.0), @(75 / 90.0), @(85 / 90.0), @1];
    positionAnimation.additive = YES;
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animation];
    scaleAnimation.keyPath = @"transform.scale";
    scaleAnimation.values = @[@.7, @.9, @1, @.9, @.7];
    scaleAnimation.keyTimes = @[@0, @(15 / 90.0), @(45 / 90.0), @(75 / 90.0), @1];
    
    CAKeyframeAnimation *alphaAnimation = [CAKeyframeAnimation animation];
    alphaAnimation.keyPath = @"opacity";
    alphaAnimation.values = @[@0, @1, @1, @1, @0];
    alphaAnimation.keyTimes = @[@0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[positionAnimation, scaleAnimation, alphaAnimation];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.repeatCount = HUGE_VALF;
    group.duration = 1.3f;
    
    [self.shapeView1.layer addAnimation:group forKey:@"basic1"];
    group.timeOffset = .43;
    [self.shapeView2.layer addAnimation:group forKey:@"basic2"];
    group.timeOffset = .86;
    [self.shapeView3.layer addAnimation:group forKey:@"basic3"];
    
    /*! win 10 加载风格动画 */
    CAKeyframeAnimation *positionAnimation2 = [CAKeyframeAnimation animation];
    positionAnimation2.keyPath = @"position.x";
    positionAnimation2.duration = 2.5f;
    positionAnimation2.values = @[ @0, @90, @110, @220 ];
    positionAnimation2.keyTimes = @[ @0, @.35, @.65, @1 ];
    positionAnimation2.timingFunctions = @[
                                           [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                           [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                           [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    positionAnimation2.additive = YES;
    
    CAKeyframeAnimation *scaleAnimation2 = [CAKeyframeAnimation animation];
    scaleAnimation2.keyPath = @"transform.scale";
    scaleAnimation2.values = @[@.9, @.7, @.5, @.3, @.2];
    scaleAnimation2.keyTimes = @[@0, @(15 / 90.0), @(45 / 90.0), @(75 / 90.0), @1];
    
    CAKeyframeAnimation *alphaAnimation2 = [CAKeyframeAnimation animation];
    alphaAnimation2.keyPath = @"opacity";
    alphaAnimation2.fillMode = kCAFillModeForwards;
    alphaAnimation2.removedOnCompletion = NO;
    alphaAnimation2.duration = 2.4f;
    alphaAnimation2.values = @[ @0, @1, @1, @1, @0 ];
    alphaAnimation2.keyTimes = @[ @0, @(.5 / 6.0), @(3 / 6.0), @(5.5 / 6.0), @1 ];
    
    CAAnimationGroup *group2 = [CAAnimationGroup animation];
    group2.animations = @[positionAnimation2, scaleAnimation2, alphaAnimation2];
    group2.repeatCount = HUGE_VALF;
    group2.duration = 3.2f;
    
    [self.shapeView4.layer addAnimation:group2 forKey:nil];
    group2.timeOffset = .2;
    [self.shapeView5.layer addAnimation:group2 forKey:nil];
    group2.timeOffset = .4;
    [self.shapeView6.layer addAnimation:group2 forKey:nil];
    group2.timeOffset = .6;
    [self.shapeView7.layer addAnimation:group2 forKey:nil];
    group2.timeOffset = .8;
    [self.shapeView8.layer addAnimation:group2 forKey:nil];
}

- (void)ba_beginBallRotationAnimation
{
    /*! 三个小球旋转动画 */
    /*! 1.1 取得围绕中心轴的点 */
    CGPoint centerPoint = CGPointMake(CGRectGetWidth(self.bounds) / 2 , CGRectGetHeight(self.bounds) / 2);
    /*! 1.2 获得第一个圆的中点 */
    CGPoint centerBall_1 = CGPointMake(centerPoint.x - _ballSize, centerPoint.y);
    /*! 1.3 获得第三个圆的中点 */
    CGPoint centerBall_2 = CGPointMake(centerPoint.x + _ballSize, centerPoint.y);
    
    /*! 2.1 第1个圆的曲线 */
    UIBezierPath *path_ball_1 = [UIBezierPath bezierPath];
    [path_ball_1 moveToPoint:centerBall_1];
    
    [path_ball_1 addArcWithCenter:centerPoint radius:_ballSize startAngle:M_PI endAngle:2*M_PI clockwise:NO];
    UIBezierPath *path_ball_1_1 = [UIBezierPath bezierPath];
    [path_ball_1_1 addArcWithCenter:centerPoint radius:_ballSize startAngle:0 endAngle:M_PI clockwise:NO];
    [path_ball_1 appendPath:path_ball_1_1];
    
    /*! 2.2 第1个圆的动画 */
    CAKeyframeAnimation *animation_ball_1=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation_ball_1.path = path_ball_1.CGPath;
    animation_ball_1.removedOnCompletion = NO;
    animation_ball_1.fillMode = kCAFillModeForwards;
    animation_ball_1.calculationMode = kCAAnimationCubic;
    animation_ball_1.repeatCount = 1;
    animation_ball_1.duration = 1.4;
    animation_ball_1.delegate = self;
    animation_ball_1.autoreverses = NO;
    animation_ball_1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.shapeView9.layer addAnimation:animation_ball_1 forKey:nil];
    
    /*! 2.1 第3个圆的曲线 */
    UIBezierPath *path_ball_3 = [UIBezierPath bezierPath];
    [path_ball_3 moveToPoint:centerBall_2];
    
    [path_ball_3 addArcWithCenter:centerPoint radius:_ballSize startAngle:0 endAngle:M_PI clockwise:NO];
    UIBezierPath *path_ball_3_1 = [UIBezierPath bezierPath];
    [path_ball_3_1 addArcWithCenter:centerPoint radius:_ballSize startAngle:M_PI endAngle:M_PI * 2 clockwise:NO];
    [path_ball_3 appendPath:path_ball_3_1];
    
    /*! 2.2 第3个圆的动画 */
    CAKeyframeAnimation *animation_ball_3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation_ball_3.path = path_ball_3.CGPath;
    animation_ball_3.removedOnCompletion = NO;
    animation_ball_3.fillMode = kCAFillModeForwards;
    animation_ball_3.calculationMode = kCAAnimationCubic;
    animation_ball_3.repeatCount = 1;
    animation_ball_3.duration = 1.4;
    //    animation_ball_3.delegate = self;
    animation_ball_3.autoreverses = NO;
    animation_ball_3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.shapeView11.layer addAnimation:animation_ball_3 forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (_loadingType == BALoadingViewTypeBallRotation)
    {
        [self ba_beginBallRotationAnimation];
    }
}

- (void)animationDidStart:(CAAnimation *)anim
{
    BAKit_WeakSelf
    if (_loadingType == BALoadingViewTypeBallRotation)
    {
        [UIView animateWithDuration:0.3f delay:0.1f options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            weak_self.shapeView9.transform = CGAffineTransformMakeTranslation(-_ballSize, 0);
            weak_self.shapeView9.transform = CGAffineTransformScale(weak_self.shapeView9.transform, 0.6f, 0.6f);
            
            weak_self.shapeView11.transform = CGAffineTransformMakeTranslation(_ballSize, 0);
            weak_self.shapeView11.transform = CGAffineTransformScale(weak_self.shapeView11.transform, 0.6f, 0.6f);
            
            weak_self.shapeView10.transform = CGAffineTransformScale(weak_self.shapeView10.transform, 0.6f, 0.6f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3f delay:0.1f options:UIViewAnimationOptionCurveEaseIn  | UIViewAnimationOptionBeginFromCurrentState animations:^{
                weak_self.shapeView9.transform = CGAffineTransformIdentity;
                weak_self.shapeView10.transform = CGAffineTransformIdentity;
                weak_self.shapeView11.transform = CGAffineTransformIdentity;
            } completion:NULL];
            
        }];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat minY = (CGRectGetHeight(self.bounds) - _ballSize) / 2;
    CGFloat minX = (CGRectGetWidth(self.bounds) - 100) / 2;
    
    _loadingView1.frame = self.bounds;
    _loadingView2.frame = self.bounds;
    _loadingView4.frame = self.bounds;

    self.shapeView1.frame = CGRectMake(minX, minY, _ballSize, _ballSize);
    self.shapeView2.frame = CGRectMake(minX, minY, _ballSize, _ballSize);
    self.shapeView3.frame = CGRectMake(minX, minY, _ballSize, _ballSize);
    
    minY = (CGRectGetHeight(self.bounds) - _ballSize / 2) / 2;
    minX = (CGRectGetWidth(self.bounds) - 220) / 2;
    
    self.shapeView4.frame = CGRectMake(minX, minY, _ballSize, _ballSize);
    self.shapeView5.frame = CGRectMake(minX, minY, _ballSize, _ballSize);
    self.shapeView6.frame = CGRectMake(minX, minY, _ballSize, _ballSize);
    self.shapeView7.frame = CGRectMake(minX, minY, _ballSize, _ballSize);
    self.shapeView8.frame = CGRectMake(minX, minY, _ballSize, _ballSize);
    
    minY = (CGRectGetHeight(self.bounds) - _ballSize) / 2;
    minX = CGRectGetWidth(self.bounds)/2 - _ballSize * 1.5;
    
    self.shapeView9.frame  = CGRectMake(minX, minY, _ballSize, _ballSize);
    minX = CGRectGetWidth(self.bounds)/2 - _ballSize * 0.5;
    self.shapeView10.frame = CGRectMake(minX, minY, _ballSize, _ballSize);
    minX = CGRectGetWidth(self.bounds)/2 + _ballSize * 0.5;
    self.shapeView11.frame = CGRectMake(minX, minY, _ballSize, _ballSize);
    
    [self ba_beginBallRotationAnimation];
}

- (void)setLoadingType:(BALoadingViewType)loadingType
{
    _loadingType = loadingType;
    [self updateWithType];
}

- (void)updateWithType
{
    switch (_loadingType) {
        case BALoadingViewTypeBall:
            self.loadingView1.hidden = NO;
            self.loadingView2.hidden = YES;
            self.loadingView4.hidden = YES;
            break;
            
        case BALoadingViewTypeBallRotation:
            self.loadingView1.hidden = YES;
            self.loadingView2.hidden = YES;
            self.loadingView4.hidden = NO;
            self.themColor = [UIColor redColor];
            break;
            
        case BALoadingViewTypeWin10:
            self.loadingView1.hidden = YES;
            self.loadingView2.hidden = NO;
            self.loadingView4.hidden = YES;
            self.themColor = [UIColor cyanColor];
            break;
            
        default:
            break;
    }
}

- (void)setThemColor:(UIColor *)themColor
{
    _themColor = themColor;
    
    [self ba_setBallColor];
}

- (void)setBallColorsArray:(NSArray<UIColor *> *)ballColorsArray
{
    _ballColorsArray = ballColorsArray;
    [self ba_setBallColor];
}

- (void)ba_setBallColor
{
    if (_ballColorsArray.count < 3)
    {
        _ballColorsArray = @[[UIColor greenColor], [UIColor redColor], [UIColor blueColor]];
    }
    self.shapeView1.backgroundColor  = _ballColorsArray[0];
    self.shapeView2.backgroundColor  = _ballColorsArray[1];
    self.shapeView3.backgroundColor  = _ballColorsArray[2];

    self.shapeView4.backgroundColor  = _themColor;
    self.shapeView5.backgroundColor  = _themColor;
    self.shapeView6.backgroundColor  = _themColor;
    self.shapeView7.backgroundColor  = _themColor;
    self.shapeView8.backgroundColor  = _themColor;
    
    self.shapeView9.backgroundColor  = _themColor;
    self.shapeView10.backgroundColor = _themColor;
    self.shapeView11.backgroundColor = _themColor;
}

- (void)ba_setBallCornerRadius
{
    self.shapeView1.layer.cornerRadius   = _ballSize / 2;
    self.shapeView2.layer.cornerRadius   = _ballSize / 2;
    self.shapeView3.layer.cornerRadius   = _ballSize / 2;
    
    self.shapeView4.layer.cornerRadius   = _ballSize / 2;
    self.shapeView5.layer.cornerRadius   = _ballSize / 2;
    self.shapeView6.layer.cornerRadius   = _ballSize / 2;
    self.shapeView7.layer.cornerRadius   = _ballSize / 2;
    self.shapeView8.layer.cornerRadius   = _ballSize / 2;
    
    self.shapeView9.layer.cornerRadius   = _ballSize / 2;
    self.shapeView10.layer.cornerRadius  = _ballSize / 2;
    self.shapeView11.layer.cornerRadius  = _ballSize / 2;
    
    self.shapeView1.layer.masksToBounds  = YES;
    self.shapeView2.layer.masksToBounds  = YES;
    self.shapeView3.layer.masksToBounds  = YES;
    
    self.shapeView4.layer.masksToBounds  = YES;
    self.shapeView5.layer.masksToBounds  = YES;
    self.shapeView6.layer.masksToBounds  = YES;
    self.shapeView7.layer.masksToBounds  = YES;
    self.shapeView8.layer.masksToBounds  = YES;
    
    self.shapeView9.layer.masksToBounds  = YES;
    self.shapeView10.layer.masksToBounds = YES;
    self.shapeView11.layer.masksToBounds = YES;
    
    [self ba_setBallColor];
}

- (void)setBallSize:(CGFloat)ballSize
{
    _ballSize = ballSize;
    [self ba_setBallCornerRadius];
}

- (UIView *)loadingView1
{
    if (!_loadingView1)
    {
        _loadingView1 = [UIView new];
        
        [self addSubview:_loadingView1];
    }
    return _loadingView1;
}

- (UIView *)loadingView2
{
    if (!_loadingView2)
    {
        _loadingView2 = [UIView new];
        
        [self addSubview:_loadingView2];
    }
    return _loadingView2;
}

- (UIView *)loadingView4
{
    if (!_loadingView4)
    {
        _loadingView4 = [UIView new];
        
        [self addSubview:_loadingView4];
    }
    return _loadingView4;
}

@end
