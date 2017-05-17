//
//  BARegistViewController.m
//  test
//
//  Created by 博爱 on 2016/11/25.
//  Copyright © 2016年 博爱. All rights reserved.
//

#import "BARegistViewController.h"
#import "BAUserSqlite.h"

@interface BARegistViewController ()

@property (weak, nonatomic) IBOutlet BAKit_TextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet BAKit_TextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet BAKit_TextField *pwd1TextField;
@property (weak, nonatomic) IBOutlet BAKit_TextField *pwd2TextField;
@property (weak, nonatomic) IBOutlet UIButton    *registButton;

- (IBAction)registButtonAction:(UIButton *)sender;

@end

@implementation BARegistViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.title = @"注  册";
    
//    _phoneNumTextField.phoneRestrict = YES;
//    _phoneNumTextField.textfieldStyle = BAKit_TextFieldStylePhone;
    
}

- (IBAction)registButtonAction:(UIButton *)sender
{
    if (![BAKit_RegularExpression ba_regularIsPhoneNumber:_phoneNumTextField.text])
    {
        BAKit_ShowAlertWithMsg(@"请输入合法的手机号码！");
        return;
    }
    if ([BAKit_Helper ba_helperIsNSStringNULL:_nickNameTextField.text])
    {
        BAKit_ShowAlertWithMsg(@"昵称不能为空！");

        return;
    }
    if (![BAKit_RegularExpression ba_regularIsPasswordQualified:_pwd1TextField.text])
    {
        BAKit_ShowAlertWithMsg(@"密码必须为6-18位的字母数字混合！");
        return;
    }
    if (![_pwd1TextField.text isEqualToString:_pwd2TextField.text])
    {
        BAKit_ShowAlertWithMsg(@"两次密码输入不一致！");
        return;
    }
    
    BAUserSqlite *userSqlite = [BAUserSqlite new];
    userSqlite.user_PhoneNumber = _phoneNumTextField.text;
    userSqlite.user_Name      = _nickNameTextField.text;
    userSqlite.pwd           = _pwd1TextField.text;
    
    BAWeak;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [userSqlite save];
//        BAKit_ShowAlertWithMsg(@"注册成功！");
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
//        });
    });
}
@end
