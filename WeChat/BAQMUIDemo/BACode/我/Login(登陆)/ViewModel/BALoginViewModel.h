//
//  BALoginViewModel.h
//  BAQMUIDemo
//
//  Created by boai on 2017/3/20.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BALoginViewModel : NSObject

@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *user_pwd;

@property (nonatomic, strong) RACSubject *success_object;
@property (nonatomic, strong) RACSubject *failure_object;
@property (nonatomic, strong) RACSubject *error_object;

- (id)ba_loginButtonIsValid;
- (void)ba_login;

@end
