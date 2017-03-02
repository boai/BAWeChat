//
//  BADiscoveryViewController.m
//  博爱微信
//
//  Created by 博爱 on 2016/10/20.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "BADiscoveryViewController.h"
#import "BATimeLineVC.h"


#define BADiscovery_Title   @"title"
#define BADiscovery_Image   @"image"

#define BADiscovery_CellID @"BADiscovery_CellID"

@interface BADiscoveryViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BADiscoveryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupUI
{
    self.tableView.hidden = NO;
    

}

- (void)viewWillLayoutSubviews
{
    self.tableView.frame = self.view.bounds;
    
    BAKit_UITableViewSetSeparatorInset(self.tableView, TableViewSeparatorColor, UIEdgeInsetsMake(0, 15, 0, 0));
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (0 == section) ? 1:2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BADiscovery_CellID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *dict = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.text  = dict[BADiscovery_Title];
    cell.imageView.image = BAKit_ImageName(dict[BADiscovery_Image]);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FLT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
        {
            [self.navigationController pushViewController:[BATimeLineVC new] animated:YES];
        }
            break;
        case 1:
        case 2:
        case 3:
        {
            BAKit_ShowAlertWithMsg(@"正在努力开发中...");
        }
            break;
        
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = TableViewBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:BADiscovery_CellID];
    }
    return _tableView;
}

- (NSArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[
                       @[@{
                             BADiscovery_Title : @"朋友圈",
                             BADiscovery_Image : @"BADiscovery.bundle/ff_IconShowAlbum"
                             }],
                       @[@{
                             BADiscovery_Title : @"扫一扫",
                             BADiscovery_Image : @"BADiscovery.bundle/ff_IconQRCode"
                             },
                         @{
                             BADiscovery_Title : @"摇一摇",
                             BADiscovery_Image : @"BADiscovery.bundle/ff_IconShake"
                             }],
                       @[@{
                             BADiscovery_Title : @"附近的人",
                             BADiscovery_Image : @"BADiscovery.bundle/ff_IconLocationService"
                             },
                         @{
                             BADiscovery_Title : @"漂流瓶",
                             BADiscovery_Image : @"BADiscovery.bundle/ff_IconBottle"
                             }],
                       @[@{
                             BADiscovery_Title : @"购物",
                             BADiscovery_Image : @"BADiscovery.bundle/CreditCard_ShoppingBag"
                             },
                         @{
                             BADiscovery_Title : @"游戏",
                             BADiscovery_Image : @"BADiscovery.bundle/MoreGame"
                             }]
                       ];
        
    }
    return _dataArray;
}

@end
