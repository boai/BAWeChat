//
//  BAHomeViewController.m
//  博爱微信
//
//  Created by 博爱 on 2016/10/20.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "BAHomeViewController.h"
#import "BALaunchADNet.h"
#import "YYModel.h"

@interface BAHomeViewController () <QMUITableViewDelegate, QMUITableViewDataSource>

@property (nonatomic, strong) QMUITableView *tableView;

@property (nonatomic, strong) NSMutableArray  *titlesArray;
@property (nonatomic, strong) NSMutableArray  *classNamesArray;
@property (nonatomic, strong) NSMutableArray  *contentsArray;

@end

@implementation BAHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)setupUI
{
    self.tableView.hidden = NO;
    
    [self creatDatas];
    
    [self testAFNWithYYModel];
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[QMUITableViewCell alloc] initForTableView:self.tableView withStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.detailTextLabel.numberOfLines = 0;
    cell.textLabel.text = self.titlesArray[indexPath.row];
    cell.detailTextLabel.text = self.contentsArray[indexPath.row];
    cell.textLabel.font = UIFontMake(15);
    cell.detailTextLabel.font = UIFontMake(13);
    
    cell.detailTextLabelEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    
    [cell updateCellAppearanceWithIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TableViewCellNormalHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    NSString *className = self.classNamesArray[indexPath.row];
    Class class = NSClassFromString(className);
    if (class)
    {
        UIViewController *vc = class.new;
        vc.title = self.titlesArray[indexPath.row];
        
        /*! 转场动画 */
        [self ba_animationWithBATransitionType:BAKit_RandomNumber(12) animationView:self.navigationController.view];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
}

#pragma mark - custom method
- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated
{
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    
    self.navigationItem.leftBarButtonItem = [QMUINavigationButton barButtonItemWithImage:UIImageMake(@"CodeScan.bundle/device_scan") position:QMUINavigationButtonPositionLeft target:self action:@selector(handleLeftNaviEvent)];\
    
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithImage:UIImageMake(@"CodeScan.bundle/device_scan") position:QMUINavigationButtonPositionRight target:self action:@selector(handleRightNaviEvent)];
    
    
//    CGRect frame2 = CGRectMake(0, 0, 30, 30);
//    BAButton *navibutton = [[BAButton alloc] creatButtonWithFrame:frame2 title:nil selTitle:nil titleColor:nil titleFont:BAKit_FontSystem_15 image:[UIImage imageNamed:@"CodeScan.bundle/device_scan"] selImage:nil buttonPositionStyle:BAButtonPositionStyleNormal target:self selector:@selector(handleRightNaviEvent:)];
//    navibutton.backgroundColor = BAKit_Color_RandomRGB();
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navibutton];
//    [navibutton ba_alertDot_showWithText:@"新" textFontSize:10 topOffset:0 rightOffset:0];

    self.navigationItem.rightBarButtonItem.badgeValue = @" ";
    
    self.navigationItem.rightBarButtonItem.badgeMinSize = 0;
    self.navigationItem.rightBarButtonItem.badgePadding = 0;
    self.navigationItem.rightBarButtonItem.badgeBGColor = BAKit_Color_Red;
}

- (void)testAFNWithYYModel
{
    QMUITips *tips = [QMUITips showLoading:@"加载中..." inView:self.view];
    [[BALaunchADNet sharedBALaunchADNet] ba_getVideosWithStartIndex:1 completionHandle:^(BAVideoModel *data, NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tips removeFromSuperview];
        });
        if (data)
        {
            //            Videolist *list0 = data.videoList[0];
            //            NSLog(@"data title:  %@", list0.title);
        }
        
    }];
    
}

- (void)creatDatas
{
    //    [self addCell:@"1、朋友圈" content:@"微信朋友圈" class:@"DemoVC1"];
    [self addCell:@"1、QMUITips 用法" content:@"各种加载提示" class:@"DemoVC2"];
    //    [self addCell:@"3、微信通讯录" content:@"一个微信通讯录，并按A~Z顺序排列，实现搜索功能" class:@"DemoVC3"];
    [self addCell:@"2、定制系统通讯录" content:@"获取本机通讯录列表，并按A~Z顺序排列" class:@"DemoVC4"];
    [self addCell:@"3、定制键盘" content:@"定制键盘" class:@"DemoVC5"];
    
}

- (void)addCell:(NSString *)title
        content:(NSString *)content
          class:(NSString *)className
{
    [self.titlesArray addObject:title];
    [self.contentsArray  addObject:content];
    [self.classNamesArray addObject:className];
}

- (void)handleLeftNaviEvent
{
    [self gotoScanVC];
}

- (void)handleRightNaviEvent
{
    // 隐藏小圆点
    self.navigationItem.rightBarButtonItem.shouldHideBadgeAtZero = YES;
    [self gotoWebWithUrl:@"https://www.baidu.com"];
}

#pragma mark - setter / getter
- (QMUITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[QMUITableView alloc] init];
        
        _tableView.backgroundColor = TableViewBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)titlesArray
{
    if (!_titlesArray)
    {
        _titlesArray = @[].mutableCopy;
    }
    return _titlesArray;
}

- (NSMutableArray *)classNamesArray
{
    if (!_classNamesArray)
    {
        _classNamesArray = @[].mutableCopy;
    }
    return _classNamesArray;
}

- (NSMutableArray *)contentsArray
{
    if (!_contentsArray)
    {
        _contentsArray = @[].mutableCopy;
    }
    return _contentsArray;
}


@end
