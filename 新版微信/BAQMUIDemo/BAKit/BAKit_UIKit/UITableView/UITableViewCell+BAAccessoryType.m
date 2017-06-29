
/*!
 *  @header BAKit.h
 *          BABaseProject
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright    Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

/*
 
 *********************************************************************************
 *
 * 在使用BAKit的过程中如果出现bug请及时以以下任意一种方式联系我，我会及时修复bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * 博客    : http://boaihome.com
 
 *********************************************************************************
 
 */


#import "UITableViewCell+BAAccessoryType.h"

@interface BATableViewCellAccessoryView : UIView
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BATableViewCellAccessoryView
-(void )layoutSubviews
{
    [super layoutSubviews];
    
    [self setSubView];
    [self layout];
}


-(void )setSubView
{
    if (self.imageView == nil)
    {
        self.imageView = [UIImageView new];
        [self addSubview:self.imageView];
    }
}

-(void )layout
{    
    self.imageView.image = self.image;
    self.imageView.contentMode = UIViewContentModeCenter;
    CGSize size = [self.imageView sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (size.width < size.height)
    {
        size.width = size.height;
    }
    else
    {
        size.height = size.width;
    }
    self.imageView.frame = CGRectMake(0, 0, size.width, size.height);
    self.frame = CGRectMake(0, 0, size.width, size.height);
}
@end

@interface BATableViewCellAccessoryView_switch : UIView

@property (nonatomic, strong) UISwitch *m_switch;

@end

@implementation BATableViewCellAccessoryView_switch

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setSubView];
    [self layout];
}


- (void )setSubView
{
//    self.m_switch.hidden = NO;
    if (!_m_switch)
    {
        _m_switch = [UISwitch new];
        [self addSubview:self.m_switch];
    }
}

//- (UISwitch *)m_switch
//{
//    if (!_m_switch)
//    {
//        _m_switch = [UISwitch new];
//        [self addSubview:self.m_switch];
//    }
//    return _m_switch;
//}

- (void )layout
{
    self.frame = CGRectMake(0, 0, self.width, self.height);
}

@end

@implementation UITableViewCell (BAAccessoryType)
//normal
-(void )setBAAccessoryType:(BATableViewCellAccessoryType )BAAccessoryType
{
    switch (BAAccessoryType)
    {
        case BATableViewCellAccessoryNone:
            [self setBAAccessoryImage:nil];
            break;
        case BATableViewCellAccessoryDisclosureIndicator:
            [self setBAAccessoryImage:[UIImage imageNamed:@"Icon_Arrow_Right"]];
            break;
        default:
            [self setBAAccessoryImage:nil];
            break;
    }
}

-(void )setBAAccessoryImage:(UIImage *)image
{
    if (image)
    {
        BATableViewCellAccessoryView *view = [[BATableViewCellAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
        view.image = image;
        self.accessoryView = view;
    }
    else
    {
        self.accessoryView = nil;
    }
}


//edit
-(void )setBAEditAccessoryType:(BATableViewCellAccessoryType )BAAccessoryType
{
    switch (BAAccessoryType)
    {
        case BATableViewCellAccessoryNone:
            [self setBAAccessoryImage:nil];
            break;
        case BATableViewCellAccessoryDisclosureIndicator:
            [self setBAAccessoryImage:[UIImage imageNamed:@"Icon_Arrow_Right1"]];
            break;
        default:
            [self setBAAccessoryImage:nil];
            break;
    }
}

-(void )setBAEditAccessoryImage:(UIImage *)image
{
    BATableViewCellAccessoryView *view = [[BATableViewCellAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    view.image = image;
    self.editingAccessoryView = view;
}

@end
