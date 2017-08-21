//
//  BALoginViewModel.m
//  BAQMUIDemo
//
//  Created by boai on 2017/3/20.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BALoginViewModel.h"
#import "BAUserSqlite.h"

@interface BALoginViewModel ()

@property (nonatomic, strong) RACSignal *userName_signal;
@property (nonatomic, strong) RACSignal *userPwd_signal;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BALoginViewModel

- (instancetype)init
{
    if (self = [super init])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    _userName_signal = RACObserve(self, user_name);
    _userPwd_signal = RACObserve(self, user_pwd);
    _success_object = [RACSubject subject];
    _failure_object = [RACSubject subject];
    _error_object = [RACSubject subject];
}

- (id)ba_loginButtonIsValid
{
    RACSignal *validSignal = [RACSignal combineLatest:@[_userName_signal, _userPwd_signal] reduce:^(NSString *user_name, NSString *user_pwd){
        return @(user_name.length >= 6 && user_pwd.length >= 6);
    }];
//    RAC(self.loginButton , enabled) = [RACSignal combineLatest:@[self.accountTxt.rac_textSignal , self.pwdTxt.rac_textSignal, self.agreeSw.rac_newOnChannel] reduce:^(NSString *account, NSString *pwd, NSNumber *isOn){
//        return @((account.length > )&&(pwd.length >)&&[isOn boolValue]);
//    }];
    return validSignal;
}

- (void)ba_login
{
    /*! 网络请求进行登录 */
    _dataArray = @[_user_name, _user_pwd];
    
    /*! 业务逻辑失败和网络请求失败发送fail或者error信号并传参 */
    if (![_user_name isNotBlank] || ![_user_pwd isNotBlank])
    {
        BAKit_ShowAlertWithMsg(@"账号或密码不能为空！");
        return;
    }
    
    NSString *db_phone = [NSString stringWithFormat:@" WHERE user_PhoneNumber = %@ ", _user_name];
    
    BAUserSqlite *userSqlite = [BAUserSqlite findFirstByCriteria:db_phone];
    if (userSqlite.user_PhoneNumber)
    {
        if ([_user_pwd isEqualToString:userSqlite.pwd])
        {
//            BAKit_JumpManagerShare.isLogin = YES;
            /*! 成功发送成功的信号 */
            [_success_object sendNext:userSqlite];
        }
        else
        {
            [_failure_object sendNext:_dataArray];
        }
    }
    else
    {
        [_error_object sendNext:_dataArray];
    }
}

- (void)dealloc
{
    _success_object = nil;
    _failure_object = nil;
    _error_object = nil;
    _userName_signal = nil;
    _userPwd_signal = nil;
    
}

@end
