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

#import "BALoginViewModel.h"
#import "BAUser.h"


@interface BALoginViewController ()
@property (weak, nonatomic) IBOutlet BAKit_TextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet BAKit_TextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton    *loginButton;

@property (nonatomic, strong) BALoginViewModel *loginViewModel;

//- (IBAction)loginButtonAction:(UIButton *)sender;
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
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.title = @"登  录";

    NSString *dbPath = [JKDBHelper dbPath];
    NSLog(@"数据库路径：%@", dbPath);
    
    [self setupViewModel];
//    RACDisposable
    @weakify(self);
//    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        @strongify(self);
//        NSLog(@"1111111111111111");
////        [self.loginViewModel ba_login];
//    }];
//    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        NSLog(@"9999999999  : %@", x);
//    }];
    
    self.loginButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^(id _) {
        @strongify(self);
        NSLog(@"button was pressed!");
        [self.loginViewModel ba_login];
        return [RACSignal empty];
    }];
}

- (void)setupViewModel
{
//    self.loginButton.enabled = YES;
    self.loginViewModel = [[BALoginViewModel alloc] init];
    RAC(self.loginViewModel, user_name) = self.phoneNumTextField.rac_textSignal;
    RAC(self.loginViewModel, user_pwd) = self.pwdTextField.rac_textSignal;
//    RAC(self.loginButton, enabled) = [self.loginViewModel ba_loginButtonIsValid];
    
    @weakify(self);
    [self.loginViewModel.success_object subscribeNext:^(BAUserSqlite *userSqlite) {
        @strongify(self);
        
        /*! 登录成功后，将数据库获取信息赋值给 BAUserModel，并发送通知 */
        BAUser *model = [BAUser sharedBAUser];
        model.user_PhoneNumber = userSqlite.user_PhoneNumber;
        model.user_Name        = userSqlite.user_Name;
        model.pwd              = userSqlite.pwd;
//        BAKit_JumpManagerShare.isLogin = YES;
        
        BAKit_ShowAlertWithMsg(@"登录成功！");
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"isLogin", nil];
        
        NSNotification *notification = [NSNotification notificationWithName:kNotioKey_LoginFinish object:nil userInfo:dict];
        
        [BAKit_NotiCenter postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.loginViewModel.failure_object subscribeNext:^(id  _Nullable x) {
        BAKit_ShowAlertWithMsg(@"账号或密码错误！，请重新登录！");
        _pwdTextField.text      = nil;
    }];
    [self.loginViewModel.error_object subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        
        dispatch_main_async_safe(^{
        
            _phoneNumTextField.text = nil;
            _pwdTextField.text      = nil;
            
//            BAKit_ShowAlertWithMsg(@"账号不存在，请注册！");
            [self.navigationController pushViewController:[BARegistViewController new] animated:NO];
        });

    }];
}

- (IBAction)loginButtonAction:(UIButton *)sender
{
//    [self.loginViewModel ba_login];
//    if ([BAKit_Helper ba_helperIsNSStringNULL:_phoneNumTextField.text] || [BAKit_Helper ba_helperIsNSStringNULL:_pwdTextField.text])
//    {
//        BAKit_ShowAlertWithMsg(@"手机号码或密码不能为空！");
//        return;
//    }
//    
//    NSString *db_phone = [NSString stringWithFormat:@" WHERE user_PhoneNumber = %@ ", _phoneNumTextField.text];
//
//    BAUserSqlite *userSqlite = [BAUserSqlite findFirstByCriteria:db_phone];
//    
//    if (userSqlite.user_PhoneNumber)
//    {
//        if ([_pwdTextField.text isEqualToString:userSqlite.pwd])
//        {
//            /*! 登陆成功后，将数据库获取信息赋值给 BAUserModel，并发送通知 */
//            BAUser *model = [BAUser new];
//            model.user_PhoneNumber        = userSqlite.user_PhoneNumber;
//            model.user_Name     = userSqlite.user_Name;
//            model.pwd          = userSqlite.pwd;
//            BAKit_JumpManagerShare.isLogin      = YES;
//
//            BAKit_ShowAlertWithMsg(@"登陆成功！");
//            NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"isLogin", nil];
//            
//            NSNotification *notification = [NSNotification notificationWithName:kNotioKey_LoginFinish object:nil userInfo:dict];
//            
//            [BAKit_NotiCenter postNotification:notification];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        else
//        {
//            BAKit_ShowAlertWithMsg(@"密码错误！，请重新登陆！");
//        }
//    }
//    else
//    {
//        _phoneNumTextField.text = nil;
//        _pwdTextField.text      = nil;
//
//        BAKit_ShowAlertWithMsg(@"账号不存在，请注册！");
//        [self.navigationController pushViewController:[BARegistViewController new] animated:YES];
//    }
}

- (IBAction)registButtonAction:(UIButton *)sender
{
    [self.navigationController pushViewController:[BARegistViewController new] animated:YES];
}

- (void)dealloc
{
    _loginViewModel = nil;
    
}

/*! 
 
 static void *ObservationContext = &ObservationContext;
 
 - (void)viewDidLoad {
	[super viewDidLoad];
 
	[LoginManager.sharedManager addObserver:self forKeyPath:@"loggingIn" options:NSKeyValueObservingOptionInitial context:&ObservationContext];
	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(loggedOut:) name:UserDidLogOutNotification object:LoginManager.sharedManager];
 
	[self.usernameTextField addTarget:self action:@selector(updateLogInButton) forControlEvents:UIControlEventEditingChanged];
	[self.passwordTextField addTarget:self action:@selector(updateLogInButton) forControlEvents:UIControlEventEditingChanged];
	[self.logInButton addTarget:self action:@selector(logInPressed:) forControlEvents:UIControlEventTouchUpInside];
 }
 
 - (void)dealloc {
	[LoginManager.sharedManager removeObserver:self forKeyPath:@"loggingIn" context:ObservationContext];
	[NSNotificationCenter.defaultCenter removeObserver:self];
 }
 
 - (void)updateLogInButton {
	BOOL textFieldsNonEmpty = self.usernameTextField.text.length > 0 && self.passwordTextField.text.length > 0;
	BOOL readyToLogIn = !LoginManager.sharedManager.isLoggingIn && !self.loggedIn;
	self.logInButton.enabled = textFieldsNonEmpty && readyToLogIn;
 }
 
 - (IBAction)logInPressed:(UIButton *)sender {
	[[LoginManager sharedManager]
 logInWithUsername:self.usernameTextField.text
 password:self.passwordTextField.text
 success:^{
 self.loggedIn = YES;
 } failure:^(NSError *error) {
 [self presentError:error];
 }];
 }
 
 - (void)loggedOut:(NSNotification *)notification {
	self.loggedIn = NO;
 }
 
 - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if (context == ObservationContext) {
 [self updateLogInButton];
	} else {
 [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
 }
 
 */

/*! 
 
 - (void)viewDidLoad {
	[super viewDidLoad];
 
	@weakify(self);
 
	RAC(self.logInButton, enabled) = [RACSignal
 combineLatest:@[
 self.usernameTextField.rac_textSignal,
 self.passwordTextField.rac_textSignal,
 RACObserve(LoginManager.sharedManager, loggingIn),
 RACObserve(self, loggedIn)
 ] reduce:^(NSString *username, NSString *password, NSNumber *loggingIn, NSNumber *loggedIn) {
 return @(username.length > 0 && password.length > 0 && !loggingIn.boolValue && !loggedIn.boolValue);
 }];
 
	[[self.logInButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
 @strongify(self);
 
 RACSignal *loginSignal = [LoginManager.sharedManager
 logInWithUsername:self.usernameTextField.text
 password:self.passwordTextField.text];
 
 [loginSignal subscribeError:^(NSError *error) {
 @strongify(self);
 [self presentError:error];
 } completed:^{
 @strongify(self);
 self.loggedIn = YES;
 }];
	}];
 
	RAC(self, loggedIn) = [[NSNotificationCenter.defaultCenter
 rac_addObserverForName:UserDidLogOutNotification object:nil]
 mapReplace:@NO];
 }
 
 */

@end
