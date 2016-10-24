//
//  BAProfileViewController.m
//  博爱微信
//
//  Created by 博爱 on 2016/10/20.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "BAProfileViewController.h"


#define BAProfile_Title @"title"
#define BAProfile_Image @"image"


@interface BAProfileViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BAProfileViewController

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
    }
    return _tableView;
}

- (NSArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[
                      @{
                          BAProfile_Title : @"相册",
                          BAProfile_Image : @"BAProfile.bundle/MoreMyAlbum"
                          },
                      @{
                          BAProfile_Title : @"收藏",
                          BAProfile_Image : @"BAProfile.bundle/MoreMyFavorites"
                          },
                      @{
                          BAProfile_Title : @"钱包",
                          BAProfile_Image : @"BAProfile.bundle/MoreMyBankCard"
                          },
                      @{
                          BAProfile_Title : @"卡包",
                          BAProfile_Image : @"BAProfile.bundle/MyCardPackageIcon"
                          }
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
    return (1 == section) ? 4:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        
    }
    else
    {
        static NSString *cellID = @"ProfileCellID2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (1 == indexPath.section)
        {
            NSDictionary *dict = self.dataArray[indexPath.row];
            cell.textLabel.text  = dict[BAProfile_Title];
            cell.imageView.image = BA_ImageName(dict[BAProfile_Image]);
        }
        else if (2 == indexPath.section)
        {
            cell.textLabel.text = @"表情";
            cell.imageView.image = BA_ImageName(@"BAProfile.bundle/MoreExpressionShops");
        }
        else if (3 == indexPath.section)
        {
            cell.textLabel.text = @"设置";
            cell.imageView.image = BA_ImageName(@"BAProfile.bundle/MoreSetting");
        }
        
        return cell;
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (0 == indexPath.section) ? 82:42;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (0 == section) ? 15:20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FLT_MIN;
}

#pragma mark - ***** 解决tableview的分割线短一截
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == indexPath.section)
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
