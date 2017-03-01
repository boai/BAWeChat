//
//  BAProfileViewController.m
//  博爱微信
//
//  Created by 博爱 on 2016/10/20.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "BAProfileViewController.h"
#import "BAProfileHeadCell.h"
#import "BALoginViewController.h"


#define BAProfile_Title   @"title"
#define BAProfile_Image   @"image"

#define BAProfile_CellID  @"BAProfileHeadCell"
#define BAProfile_CellID2 @"BAProfileCell"

@interface BAProfileViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BAProfileViewController

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
    return (1 == section) ? 4:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        BAProfileHeadCell *headCell = [BAProfileHeadCell dequeueCellFromNibIndex:indexPath.section identify:BAProfile_CellID tableView:tableView];

        return headCell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BAProfile_CellID2];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (1 == indexPath.section)
        {
            NSDictionary *dict = self.dataArray[indexPath.row];
            cell.textLabel.text  = dict[BAProfile_Title];
            cell.imageView.image = BAKit_ImageName(dict[BAProfile_Image]);
        }
        else if (2 == indexPath.section)
        {
            cell.textLabel.text = @"表情";
            cell.imageView.image = BAKit_ImageName(@"BAProfile.bundle/MoreExpressionShops");
        }
        else if (3 == indexPath.section)
        {
            cell.textLabel.text = @"设置";
            cell.imageView.image = BAKit_ImageName(@"BAProfile.bundle/MoreSetting");
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (!BAKit_JumpManagerShare.isLogin)
    {
        [BAKit_JumpManager ba_gotoLoginVCWithViewController:self];
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
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:BAProfile_CellID2];
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



@end
