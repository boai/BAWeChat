//
//  BAProfileHeadCell.m
//  博爱微信
//
//  Created by 博爱 on 2016/10/24.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "BAProfileHeadCell.h"

@interface BAProfileHeadCell ()

@property (weak, nonatomic) IBOutlet UIImageView  *userImgView;
@property (weak, nonatomic) IBOutlet UILabel      *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel      *accountLabel;
@property (weak, nonatomic) IBOutlet UIImageView  *QRCodeImgView;

@end

@implementation BAProfileHeadCell


- (void)awakeFromNib
{
////    _userImgView.maskToBounds = YES;
//    _userImgView.image   = BA_ImageName(@"BAProfile.bundle/xhr");
//    _QRCodeImgView.image = BA_ImageName(@"BAProfile.bundle/qrcode");
//    _userNameLabel.text  = @"博爱";
//    _accountLabel.text   = @"boai1616";
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
