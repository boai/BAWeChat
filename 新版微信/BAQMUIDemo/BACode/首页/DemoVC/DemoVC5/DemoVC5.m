//
//  DemoVC5.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/20.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "DemoVC5.h"


@interface DemoVC5 ()

@property (nonatomic, strong) UIButton *clickButton;
@property (nonatomic, strong) BAKit_KeyboardView *keyboardBar;

@property (nonatomic, strong) UILabel *label;

@end

@implementation DemoVC5

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    self.clickButton.hidden = NO;
//    self.keyboardBar.hidden = NO;
    self.label.hidden = NO;

    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.keyboardBar.frame = CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.keyboardBar ba_hideKeyboardView];
}

- (void)clickButtonAction:(UIButton *)sender
{
    NSLog(@"你点击了按钮，弹出键盘！");
    
    [self.keyboardBar ba_showKeyboardView];
    
//    [self.label ba_animation_showFromPositionType:BAKit_RandomNumber(3) duration:1.0f finishBlock:^{
//        
//    }];
    
    [self.label.layer ba_layer_animationShakeWithValue:5.0f repeatCount:2.0f];
//    [self.label ba_shakeView];
}

#pragma mark - setter / getter

- (UIButton *)clickButton {
	if(_clickButton == nil) {
		_clickButton = [[UIButton alloc] init];
        _clickButton.frame = CGRectMake(50, 100, 200, 50);
        _clickButton.backgroundColor = BAKit_Color_Green;
        _clickButton.selected = NO;
        [_clickButton setTitle:@"点我" forState:UIControlStateNormal];
        [_clickButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_clickButton];
	}
	return _clickButton;
}

- (BAKit_KeyboardView *)keyboardBar {
	if(_keyboardBar == nil) {
		_keyboardBar = [[BAKit_KeyboardView alloc] init];
        _keyboardBar.frame = CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44);
        
        _keyboardBar.showMoreButton = YES;
        _keyboardBar.showEmotionButton = YES;
        
        BAKit_WeakSelf
        [self.keyboardBar setBATimeLineKeyboardViewReturnBlock:^(id contentString) {
            NSString *msg = [NSString stringWithFormat:@"成功发送文字：%@",contentString];
            NSLog(@"%@", msg);
            
            weak_self.label.attributedText = [BAKit_EmotionString ba_getEmotionMutableAttributedStringWithContent:contentString];
            [weak_self.keyboardBar ba_hideKeyboardView];
        }];
        [self.view addSubview:self.keyboardBar];
	}
	return _keyboardBar;
}

- (UILabel *)label {
	if(_label == nil) {
		_label = [[UILabel alloc] init];
        _label.backgroundColor = BAKit_Color_Hex(@"#AEEEEE");
        _label.frame = CGRectMake(20, self.clickButton.bottom + 20, SCREEN_WIDTH - 40, 100);
        _label.numberOfLines = 0;
        
        [self.view addSubview:self.label];
	}
	return _label;
}

@end
