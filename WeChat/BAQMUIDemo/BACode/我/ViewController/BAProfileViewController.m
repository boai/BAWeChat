//
//  BAProfileViewController.m
//  博爱微信
//
//  Created by 博爱 on 2016/10/20.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "BAProfileViewController.h"
#import "BAProfileHeadCell.h"
//#import "BALoginViewController.h"
#import "BAUser.h"

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
    [self addNoti];

}

#pragma mark - 通知
- (void)addNoti
{
    [BAKit_NotiCenter addObserver:self selector:@selector(handleLoginFinishAction:) name:kNotioKey_LoginFinish object:nil];
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
//        if (BAKit_JumpManagerShare.isLogin)
//        {
//            BAUser *model = [BAUser sharedBAUser];
//            headCell.userNameLabel.text = model.user_Name;
//            headCell.accountLabel.text = model.user_PhoneNumber;
//            headCell.userImgView.image = BAKit_ImageName(@"icon1.jpg");
//        }
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
    
//    if (!BAKit_JumpManagerShare.isLogin)
//    {
//        [BAKit_JumpManager ba_gotoLoginVCWithViewController:self];
//    }
    
    BAKit_ShowAlertWithMsg_ios8(@"欢迎使用 iPhone SE，迄今最高性能的 4 英寸 iPhone。在打造这款手机时，我们在深得人心的 4 英寸设计基础上，从里到外重新构想。它所采用的 A9 芯片，正是在 iPhone 6s 上使用的先进芯片。1200 万像素的摄像头能拍出令人叹为观止的精彩照片和 4K 视频，而 Live Photos 则会让你的照片栩栩如生。这一切，成就了一款外形小巧却异常强大的 iPhone。\n对于 MacBook，我们给自己设定了一个几乎不可能实现的目标：在有史以来最为轻盈纤薄的 Mac 笔记本电脑上，打造全尺寸的使用体验。这就要求每个元素都必须重新构想，不仅令其更为纤薄轻巧，还要更加出色。最终我们带来的，不仅是一部新款的笔记本电脑，更是一种对笔记本电脑的前瞻性思考。现在，有了第六代 Intel 处理器、提升的图形处理性能、高速闪存和最长可达 10 小时的电池使用时间*，MacBook 的强大更进一步。\n欢迎使用 iPhone SE，迄今最高性能的 4 英寸 iPhone。在打造这款手机时，我们在深得人心的 4 英寸设计基础上，从里到外重新构想。它所采用的 A9 芯片，正是在 iPhone 6s 上使用的先进芯片。1200 万像素的摄像头能拍出令人叹为观止的精彩照片和 4K 视频，而 Live Photos 则会让你的照片栩栩如生。这一切，成就了一款外形小巧却异常强大的 iPhone。\n对于 MacBook，我们给自己设定了一个几乎不可能实现的目标：在有史以来最为轻盈纤薄的 Mac 笔记本电脑上，打造全尺寸的使用体验。这就要求每个元素都必须重新构想，不仅令其更为纤薄轻巧，还要更加出色。最终我们带来的，不仅是一部新款的笔记本电脑，更是一种对笔记本电脑的前瞻性思考。现在，有了第六代 Intel 处理器、提升的图形处理性能、高速闪存和最长可达 10 小时的电池使用时间*，MacBook 的强大更进一步。")
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event method
- (void)handleLoginFinishAction:(NSNotification *)noti
{
    NSDictionary *dict = noti.userInfo;
    if ([dict[@"isLogin"] isEqualToString:@"1"])
    {
        [self.tableView reloadData];
    }
}

#pragma mark - setter / getter
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
