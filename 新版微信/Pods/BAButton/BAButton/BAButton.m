

#import "BAButton.h"
//#import <QuartzCore/QuartzCore.h>

/*! 定义宏：按钮中文本和图片的间隔 */
#define BA_btnRadio       0.6
/*! 获得按钮的大小 */
#define BA_btnWidth       self.bounds.size.width
#define BA_btnHeight      self.bounds.size.height
/*! 获得按钮中UILabel文本的大小 */
#define BA_labelWidth     self.titleLabel.bounds.size.width
#define BA_labelHeight    self.titleLabel.bounds.size.height
/*! 获得按钮中image图标的大小 */
#define BA_imageWidth     self.imageView.bounds.size.width
#define BA_imageHeight    self.imageView.bounds.size.height

/*! 图标在上，文本在下按钮的图文间隔比例（0-1），默认0.8 */
#define BA_ButtonTopRadio 0.8

/*! 图标在下，文本在上按钮的图文间隔比例（0-1），默认0.5 */
#define BA_ButtonBottomRadio 0.5

#pragma mark - 根据文字内容和大小返回 size
CG_INLINE CGSize
BAKit_LabelSizeWithTextAndFont(NSString *text, UIFont *font){
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    CGSize newSize = CGSizeMake(size.width, size.height);
    return newSize;
}

@implementation BAButton

- (instancetype __nonnull)init
{
    if (self = [super init])
    {
        [self setupSubViews];
    }
    return self;
}

- (instancetype __nonnull)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupSubViews];
    }
    return self;
}

- (instancetype __nonnull)initWithCoder:(NSCoder * __nonnull)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    self.padding = 0;
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupSubViews];
}

/*!
 *  创建 button
 *
 *  @param frame               frame
 *  @param title               title
 *  @param selTitle            selTitle
 *  @param titleColor          标题颜色，默认：黑色
 *  @param titleFont           标题字体，默认：16
 *  @param image               image
 *  @param selImage            selImage
 *  @param buttonPositionStyle buttonPositionStyle
 *  @param target              target
 *  @param sel                 sel
 *
 *  @return button
 */
- (instancetype __nonnull)creatButtonWithFrame:(CGRect)frame
                                         title:(NSString * __nullable)title
                                      selTitle:(NSString * __nullable)selTitle
                                    titleColor:(UIColor * __nullable)titleColor
                                     titleFont:(UIFont * __nullable)titleFont
                                         image:(UIImage * __nullable)image
                                      selImage:(UIImage * __nullable)selImage
                           buttonPositionStyle:(BAButtonPositionStyle)buttonPositionStyle
                                        target:(id __nullable)target
                                      selector:(SEL __nullable)sel
{
    BAButton *button = [[BAButton alloc] init];
    button.frame = frame;
    if (title)
    {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (selTitle)
    {
        [button setTitle:selTitle forState:UIControlStateSelected];
    }
    if (titleColor)
    {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    else
    {
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (titleFont)
    {
        button.titleLabel.font             = titleFont;
    }
    else
    {
        button.titleLabel.font             = [UIFont systemFontOfSize:16.0f];
    }
    if (selImage)
    {
        [button setImage:selImage forState:UIControlStateSelected];
    }
    if (image)
    {
        [button setImage:image forState:UIControlStateNormal];
    }
    button.buttonPositionStyle = buttonPositionStyle;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

#pragma mark - 系统默认
- (void)alignmentNormal
{
    /*! 获得按钮的文本的frame */
    CGRect titleFrame = self.titleLabel.frame;
    /*! 获得按钮的图片的frame */
    CGRect imageFrame = self.imageView.frame;
    /*! 设置按钮的文本的x坐标 */
    titleFrame.origin.x += self.padding;
    
    self.imageView.frame = imageFrame;
    self.titleLabel.frame = titleFrame;
}

#pragma mark - 左对齐
- (void)alignmentLeft
{
    /*! 获得按钮的文本的frame */
    CGRect titleFrame = self.titleLabel.frame;
    /*! 设置按钮的文本的x坐标为0-－－左对齐 */
    titleFrame.origin.x = 0;
    /*! 获得按钮的图片的frame */
    CGRect imageFrame = self.imageView.frame;
    /*! 设置按钮的图片的x坐标紧跟文本的后面 */
    imageFrame.origin.x = CGRectGetWidth(titleFrame) + self.padding;
    
    self.titleLabel.frame = titleFrame;
    self.imageView.frame = imageFrame;
}

#pragma mark - 右对齐【文字在左，图片在右】
- (void)alignmentRight
{
    CGRect frame = [self getTitleLabelWith];
    CGRect imageFrame = self.imageView.frame;
    imageFrame.origin.x = BA_btnWidth - BA_imageWidth - self.padding;
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = imageFrame.origin.x - frame.size.width - self.padding;
    
    /*! 重写赋值frame */
    self.titleLabel.frame = titleFrame;
    self.imageView.frame = imageFrame;
}

#pragma mark - 计算文本的的宽度
- (CGRect)getTitleLabelWith
{
    CGSize size = BAKit_LabelSizeWithTextAndFont(self.titleLabel.text, self.titleLabel.font);
    CGRect frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    return frame;
}

#pragma mark - 居中对齐
- (void)alignmentCenter
{
    /*! 设置文本的坐标 */
    CGFloat labelX = (BA_btnWidth - BA_labelWidth - BA_imageWidth - self.padding) * 0.5;
    CGFloat labelY = (BA_btnHeight - BA_labelHeight) * 0.5;
    /*! 设置label的frame */
    self.titleLabel.frame = CGRectMake(labelX, labelY, BA_labelWidth, BA_labelHeight);
    
    /*! 设置图片的坐标 */
    CGFloat imageX = CGRectGetMaxX(self.titleLabel.frame) + self.padding;
    CGFloat imageY = (BA_btnHeight - BA_imageHeight) * 0.5;
    /*! 设置图片的frame */
    self.imageView.frame = CGRectMake(imageX, imageY, BA_imageWidth, BA_imageHeight);
}

#pragma mark - 图标在上，文本在下(居中)
- (void)alignmentTop
{
    CGRect frame = [self getTitleLabelWith];
    
    CGFloat imageX = (BA_btnWidth - BA_imageWidth) * 0.5;
    self.imageView.frame = CGRectMake(imageX, BA_btnHeight * 0.5 - BA_imageHeight * BA_ButtonTopRadio, BA_imageWidth, BA_imageHeight);
    self.titleLabel.frame = CGRectMake((self.center.x - frame.size.width) * 0.5, BA_btnHeight * 0.5 + BA_labelHeight * BA_ButtonTopRadio, BA_btnWidth, BA_labelHeight);
    CGPoint labelCenter = self.titleLabel.center;
    labelCenter.x = self.imageView.center.x;
    self.titleLabel.center = labelCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - 图标在下，文本在上(居中)
- (void)alignmentBottom
{
    CGRect frame = [self getTitleLabelWith];
    
    CGFloat imageX = (BA_btnWidth - BA_imageWidth) * 0.5;
    self.titleLabel.frame = CGRectMake((self.center.x - frame.size.width) * 0.5, BA_btnHeight * 0.5 - BA_labelHeight * (1 + BA_ButtonBottomRadio), BA_btnWidth, BA_labelHeight);
    self.imageView.frame = CGRectMake(imageX, BA_btnHeight * 0.5, BA_imageWidth, BA_imageHeight);
    CGPoint labelCenter = self.titleLabel.center;
    labelCenter.x = self.imageView.center.x;
    self.titleLabel.center = labelCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - setter / getter
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (!self.buttonRectCornerStyle)
    {
        self.buttonRectCornerStyle = BAButtonRectCornerStyleAllCorners;
    }
    if (!self.buttonPositionStyle)
    {
        self.buttonPositionStyle = BAButtonPositionStyleNormal;
    }
    [self setupButtonCornerStyle];
    [self setupButtonPositionStyle];
}

- (void)setButtonRectCornerStyle:(BAButtonRectCornerStyle)buttonRectCornerStyle
{
    _buttonRectCornerStyle = buttonRectCornerStyle;
    [self setupButtonCornerStyle];
}

- (void)setButtonPositionStyle:(BAButtonPositionStyle)buttonPositionStyle
{
    _buttonPositionStyle = buttonPositionStyle;
    [self setupButtonPositionStyle];
}

- (void)setButtonCornerRadii:(CGSize)buttonCornerRadii
{
    _buttonCornerRadii = buttonCornerRadii;
}

- (void)setButtonCornerRadii:(CGSize)buttonCornerRadii buttonRectCornerStyle:(BAButtonRectCornerStyle)buttonRectCornerStyle
{
    self.buttonCornerRadii = buttonCornerRadii;
    self.buttonRectCornerStyle = buttonRectCornerStyle;
}

- (void)setButtonCornerRadius:(CGFloat)buttonCornerRadius
{
    _buttonCornerRadius = buttonCornerRadius;
    
    self.buttonCornerRadii = CGSizeMake(buttonCornerRadius, buttonCornerRadius);
    self.buttonRectCornerStyle = BAButtonRectCornerStyleAllCorners;
}

- (void)setPadding:(CGFloat)padding
{
    _padding = padding;
}

#pragma mark - layoutSubviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setupButtonPositionStyle];
}

#pragma mark - 设置 buttonPosition 样式
- (void)setupButtonPositionStyle
{
    switch (self.buttonPositionStyle) {
        case BAButtonPositionStyleNormal:
        {
            [self alignmentNormal];
        }
            break;
        case BAButtonPositionStyleLeft:
        {
            [self alignmentLeft];
        }
            break;
        case BAButtonPositionStyleCenter:
        {
            [self alignmentCenter];
        }
            break;
        case BAButtonPositionStyleRight:
        {
            [self alignmentRight];
        }
            break;
        case BAButtonPositionStyleTop:
        {
            [self alignmentTop];
        }
            break;
        case BAButtonPositionStyleBottom:
        {
            [self alignmentBottom];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - button 的 角半径，默认 CGSizeMake(20, 20)
- (void)setupButtonCornerStyle
{
    UIRectCorner corners;
    
    if (CGSizeEqualToSize(self.buttonCornerRadii, CGSizeZero))
    {
        self.buttonCornerRadii = CGSizeMake(0, 0);
    }
    switch (self.buttonRectCornerStyle)
    {
        case BAButtonRectCornerStyleBottomLeft:
        {
            corners = UIRectCornerBottomLeft;
        }
            break;
        case BAButtonRectCornerStyleBottomRight:
        {
            corners = UIRectCornerBottomRight;
        }
            break;
        case BAButtonRectCornerStyleTopLeft:
        {
            corners = UIRectCornerTopLeft;
        }
            break;
        case BAButtonRectCornerStyleTopRight:
        {
            corners = UIRectCornerTopRight;
        }
            break;
        case BAButtonRectCornerStyleBottomLeftAndBottomRight:
        {
            corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        }
            break;
        case BAButtonRectCornerStyleTopLeftAndTopRight:
        {
            corners = UIRectCornerTopLeft | UIRectCornerTopRight;
        }
            break;
        case BAButtonRectCornerStyleBottomLeftAndTopLeft:
        {
            corners = UIRectCornerBottomLeft | UIRectCornerTopLeft;
        }
            break;
        case BAButtonRectCornerStyleBottomRightAndTopRight:
        {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight;
        }
            break;
        case BAButtonRectCornerStyleBottomRightAndTopRightAndTopLeft:
        {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerTopLeft;
        }
            break;
        case BAButtonRectCornerStyleBottomRightAndTopRightAndBottomLeft:
        {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft;
        }
            break;
        case BAButtonRectCornerStyleAllCorners:
        {
            corners = UIRectCornerAllCorners;
        }
            break;
            
        default:
            break;
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:self.buttonCornerRadii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = self.bounds;
    maskLayer.path          = maskPath.CGPath;
    self.layer.mask         = maskLayer;
}

@end


