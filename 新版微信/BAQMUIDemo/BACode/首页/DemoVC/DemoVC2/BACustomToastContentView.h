//
//  BACustomToastContentView.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/10.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BACustomToastContentView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *detailTextLabel;

- (void)ba_renderWitherImage:(UIImage *)image
                       title:(NSString *)title
                  detailText:(NSString *)detailText;

@end
