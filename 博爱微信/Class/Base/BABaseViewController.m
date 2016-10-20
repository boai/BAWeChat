//
//  BABaseViewController.m
//  博爱微信
//
//  Created by 博爱 on 2016/10/20.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "BABaseViewController.h"

@interface BABaseViewController ()

@end

@implementation BABaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupCommonUI
{
    self.view.backgroundColor = BA_White_Color;
}

- (void)setupUI
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
