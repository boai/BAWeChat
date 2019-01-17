//
//  BAContactsModel.h
//  BAQMUIDemo
//
//  Created by boai on 2017/3/20.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAContactsModel : NSObject

@property (nonatomic, copy) NSString *user_Name;
@property (nonatomic, copy) NSString *user_Id;
@property (nonatomic, copy) NSString *user_Image_url;
@property (nonatomic, copy) UIImage  *user_Image;
@property (nonatomic, copy) NSString *user_PhoneNumber;

@end
