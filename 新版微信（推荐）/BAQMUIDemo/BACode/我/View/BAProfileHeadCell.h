//
//  BAProfileHeadCell.h
//  博爱微信
//
//  Created by 博爱 on 2016/10/24.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAProfileHeadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView  *userImgView;
@property (weak, nonatomic) IBOutlet UILabel      *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel      *accountLabel;
@property (weak, nonatomic) IBOutlet UIImageView  *QRCodeImgView;

@end
