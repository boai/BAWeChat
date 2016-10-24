//
//  BADiscoveryViewController.m
//  博爱微信
//
//  Created by 博爱 on 2016/10/20.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "BADiscoveryViewController.h"


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

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = ba_RGBAColor(241, 241, 241, 1.0);
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

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupUI
{
    self.tableView.hidden = NO;
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
    cell.imageView.image = BA_ImageName(dict[BADiscovery_Image]);
    
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
    
}

#pragma mark - ***** 解决tableview的分割线短一截
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
