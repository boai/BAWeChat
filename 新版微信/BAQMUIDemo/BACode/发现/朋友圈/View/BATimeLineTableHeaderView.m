//
//  BATimeLineTableHeaderView.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/23.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BATimeLineTableHeaderView.h"

@interface BATimeLineTableHeaderView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *userSignatureLabel;

@end

@implementation BATimeLineTableHeaderView

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
    self.userInteractionEnabled = YES;
//    self.backgroundColor = BAKit_ColorYellow;
//    self.image = BAKit_ImageName(@"picon.jpg");
    
}

- (void)layoutSubviews
{
    CGFloat userImageView_wh = 80;
    CGFloat userNameLabel_w = 150;
    CGFloat userNameLabel_h = 25;

    CGFloat userSignatureLabel_w = self.width - kMargin_15 * 2;
    CGFloat userSignatureLabel_h = 25;

    self.backgroundImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height - userSignatureLabel_h - kMargin_15 * 3);
    
    self.userSignatureLabel.frame = CGRectMake(kMargin_15, self.bottom - userSignatureLabel_h - kMargin_15, userSignatureLabel_w, userSignatureLabel_h);

    self.userImageView.frame = CGRectMake(self.width - userImageView_wh - kMargin_15 , self.userSignatureLabel.y - userImageView_wh - kMargin_5, userImageView_wh, userImageView_wh);
    
    self.userNameLabel.frame = CGRectMake(self.userImageView.left - kMargin_15 - userNameLabel_w, self.bottom - userNameLabel_h - kMargin_35, userNameLabel_w, userNameLabel_h);
    self.userNameLabel.centerY = self.userImageView.centerY - kMargin_5;
    
}

#pragma mark - setter / getter
- (UIImageView *)backgroundImageView {
    if(_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] init];
        self.backgroundImageView.image = BAKit_ImageName(@"picon.jpg");
        [self addSubview:self.backgroundImageView];
    }
    return _backgroundImageView;
}

- (UIImageView *)userImageView {
	if(_userImageView == nil) {
		_userImageView = [[UIImageView alloc] init];
        self.userImageView.image = [UIImage imageNamed:@"icon1.jpg"];
        self.userImageView.layer.borderColor = BAKit_ColorWhite.CGColor;
        self.userImageView.layer.borderWidth = 3;
        [self addSubview:self.userImageView];
	}
	return _userImageView;
}

- (UILabel *)userNameLabel {
	if(_userNameLabel == nil) {
		_userNameLabel = [[UILabel alloc] init];
        self.userNameLabel.text = @"博爱1616";
        self.userNameLabel.textColor = BAKit_ColorWhite;
        self.userNameLabel.textAlignment = NSTextAlignmentRight;
        self.userNameLabel.font = [UIFont boldSystemFontOfSize:17];
        [self addSubview:self.userNameLabel];
	}
	return _userNameLabel;
}

- (UILabel *)userSignatureLabel {
	if(_userSignatureLabel == nil) {
		_userSignatureLabel = [[UILabel alloc] init];
        self.userSignatureLabel.text = @"生命不息，折腾不止...";
        self.userSignatureLabel.textColor = UIColorGray5;
        self.userSignatureLabel.textAlignment = NSTextAlignmentRight;
        self.userSignatureLabel.font = [UIFont boldSystemFontOfSize:14];
        
        [self addSubview:self.userSignatureLabel];
	}
	return _userSignatureLabel;
}



@end
