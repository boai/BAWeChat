//
//  BALoginViewController.m
//  test
//
//  Created by 博爱 on 2016/11/25.
//  Copyright © 2016年 博爱. All rights reserved.
//

#import "BALoginViewController.h"
#import "BAUserSqlite.h"
#import "BARegistViewController.h"
#import "BAProfileViewController.h"



@interface BALoginViewController ()
@property (weak, nonatomic) IBOutlet BAKit_TextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet BAKit_TextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton    *loginButton;


- (IBAction)loginButtonAction:(UIButton *)sender;
- (IBAction)registButtonAction:(UIButton *)sender;

@end

@implementation BALoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.title = @"登  录";

    _phoneNumTextField.phoneRestrict = YES;
//    _phoneNumTextField.textfieldStyle = BAKit_TextFieldStylePhone;
    
    NSString *dbPath = [JKDBHelper dbPath];
    NSLog(@"数据库路径：%@", dbPath);
}

- (IBAction)loginButtonAction:(UIButton *)sender
{
    if ([BAKit_Helper ba_helperIsNSStringNULL:_phoneNumTextField.text] || [BAKit_Helper ba_helperIsNSStringNULL:_pwdTextField.text])
    {
        BAKit_ShowAlertWithMsg(@"手机号码或密码不能为空！");
        return;
    }
    
    NSString *db_phone = [NSString stringWithFormat:@" WHERE user_PhoneNumber = %@ ", _phoneNumTextField.text];

    BAUserSqlite *userSqlite = [BAUserSqlite findFirstByCriteria:db_phone];
    
    if (userSqlite.user_PhoneNumber)
    {
        if ([_pwdTextField.text isEqualToString:userSqlite.pwd])
        {
            /*! 登陆成功后，将数据库获取信息赋值给 BAUserModel，并发送通知 */
            BAUser *model = [BAUser new];
            model.user_PhoneNumber        = userSqlite.user_PhoneNumber;
            model.user_Name     = userSqlite.user_Name;
            model.pwd          = userSqlite.pwd;
            BAKit_JumpManagerShare.isLogin      = YES;

            BAKit_ShowAlertWithMsg(@"登陆成功！");
            NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"isLogin", nil];
            
            NSNotification *notification = [NSNotification notificationWithName:kNotioKey_LoginFinish object:nil userInfo:dict];
            
            [BAKit_NotiCenter postNotification:notification];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            BAKit_ShowAlertWithMsg(@"密码错误！，请重新登陆！");
        }
    }
    else
    {
        _phoneNumTextField.text = nil;
        _pwdTextField.text      = nil;

        BAKit_ShowAlertWithMsg(@"账号不存在，请注册！");
        [self.navigationController pushViewController:[BARegistViewController new] animated:YES];
    }
}

- (IBAction)registButtonAction:(UIButton *)sender
{
    [self.navigationController pushViewController:[BARegistViewController new] animated:YES];
}

- (void)dealloc
{
    /*! 移除监听 */
//    [self.phoneNumTextField removeObserver:self forKeyPath:@"text"];
    
}

@end
