//
//  BAContactViewController.m
//  博爱微信
//
//  Created by 博爱 on 2016/10/20.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "BAContactViewController.h"
#import "BAContactsModel.h"

#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>


static NSString * const cellID = @"BAContactViewCell";

#define cellHeight        50
#define cellImageViewSize cellHeight * 0.8

#define tableViewEdgeInsets UIEdgeInsetsMake(0, 15, 0, 0)

@interface BAContactViewController ()<QMUISearchControllerDelegate>

@property (nonatomic, strong) NSMutableArray <BAContactsModel *>*dataArray;

@property (nonatomic, strong) NSMutableArray <BAContactsModel *>*searchResultsKeywordsArray;

/*! 索引 */
@property (nonatomic, strong) NSMutableArray <NSString *>*indexArray;
@property (nonatomic, strong) NSMutableArray *sectionArray;

@property (nonatomic, strong) QMUISearchController *mySearchController;

@property (nonatomic, strong) CNContactPickerViewController *contactPickerViewController;

@end

@implementation BAContactViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)setupUI
{
    self.mySearchController = [[QMUISearchController alloc] initWithContentsViewController:self];
    self.mySearchController.searchResultsDelegate = self;
    self.tableView.tableHeaderView = self.mySearchController.searchBar;
    
    [self getSectionData];
}

- (void)setupNavi
{
    
    
}

- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated
{
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithImage:UIImageMake(@"icon_nav_about") position:QMUINavigationButtonPositionRight target:self action:@selector(handleAboutItemEvent)];
}

- (void)getSectionData
{
    NSDictionary *dict = [BAKit_LocalizedIndexedCollation ba_localizedWithDataArray:self.dataArray localizedNameSEL:@selector(user_Name)];
    self.indexArray   = dict[kBALocalizedIndexArrayKey];
    self.sectionArray = dict[kBALocalizedGroupArrayKey];
    
    NSMutableArray *tempModel = [[NSMutableArray alloc] init];
    NSArray *dicts = @[@{@"user_Name" : @"新的朋友",
                         @"user_Image_url" : @"plugins_FriendNotify"},
                       @{@"user_Name" : @"群聊",
                         @"user_Image_url" : @"add_friend_icon_addgroup"},
                       @{@"user_Name" : @"标签",
                         @"user_Image_url" : @"Contact_icon_ContactTag"},
                       @{@"user_Name" : @"公众号",
                         @"user_Image_url" : @"add_friend_icon_offical"}];
    for (NSDictionary *dict in dicts)
    {
        BAContactsModel *model = [BAContactsModel new];
        model.user_Name = dict[@"user_Name"];
        model.user_Image_url = dict[@"user_Image_url"];
        [tempModel addObject:model];
    }
    
    [self.sectionArray insertObject:tempModel atIndex:0];
    [self.indexArray insertObject:@"🔍" atIndex:0];
    
    [self.tableView reloadData];
}

#pragma mark - QMUITableView Delegate & DataSource
//- (instancetype)initWithStyle:(UITableViewStyle)style
//{
//    if (self = [super initWithStyle:style])
//    {
//
//    }
//    return self;
//}

- (BOOL)shouldShowSearchBarInTableView:(QMUITableView *)tableView
{
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView)
    {
        return self.indexArray.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        return [self.sectionArray[section] count];
    }
    return self.searchResultsKeywordsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID ];
    if (!cell)
    {
        cell = [[QMUITableViewCell alloc] initForTableView:self.tableView withStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    BAContactsModel *model = nil;
    if (tableView == self.tableView)
    {
        model = self.sectionArray[section][row];
        cell.textLabel.text = model.user_Name;
    }
    else
    {
        model = self.searchResultsKeywordsArray[row];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.user_Name attributes:@{NSForegroundColorAttributeName:UIColorBlack}];
        
        NSRange range = [model.user_Name rangeOfString:self.mySearchController.searchBar.text];
        if (range.location != NSNotFound)
        {
            [attributedString addAttributes:@{NSForegroundColorAttributeName:UIColorBlue} range:range];
        }
        cell.textLabel.attributedText = attributedString;
    }
    
    if (model.user_Image_url)
    {
        cell.imageView.image = [UIImage ba_imageToChangeCellRoundImageViewSizeWithCell:cell image:UIImageMake(model.user_Image_url) imageSize:CGSizeMake(cellImageViewSize, cellImageViewSize)];
    }
    else if (model.user_Image)
    {
        cell.imageView.image = [UIImage ba_imageToChangeCellRoundImageViewSizeWithCell:cell image:model.user_Image imageSize:CGSizeMake(cellImageViewSize, cellImageViewSize)];
    }
    if (model.user_PhoneNumber)
    {
        cell.detailTextLabel.text = model.user_PhoneNumber;
        cell.detailTextLabel.font = UIFontMake(12);
        cell.detailTextLabelEdgeInsets = UIEdgeInsetsMake(2, -3, 0, 0);
    }
    else
    {
        cell.detailTextLabel.text = nil;
    }
    
    cell.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    cell.textLabelEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    [cell updateCellAppearanceWithIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    
    BAContactsModel *model = nil;
    if (tableView == self.tableView)
    {
        model = self.sectionArray[section][row];
    }
    else
    {
        model = self.searchResultsKeywordsArray[row];
    }
    [self ba_showAlertWithModel:model];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        return self.indexArray[section];
    }
    return @"最佳匹配";
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

#pragma mark - QMUISearchControllerDelegate
- (void)searchController:(QMUISearchController *)searchController updateResultsForSearchString:(NSString *)searchString
{
    [self.searchResultsKeywordsArray removeAllObjects];
    
    for (BAContactsModel *model in self.dataArray)
    {
        if ([model.user_Name qmui_includesString:searchString])
        {
            [self.searchResultsKeywordsArray addObject:model];
        }
    }
    
    [searchController.tableView reloadData];
    
    if (self.searchResultsKeywordsArray.count == 0)
    {
        [searchController showEmptyViewWithText:@"没有匹配结果！" detailText:nil buttonTitle:nil buttonAction:NULL];
    }
    else
    {
        [searchController hideEmptyView];
    }
}

- (void)willPresentSearchController:(QMUISearchController *)searchController
{
    [QMUIHelper renderStatusBarStyleDark];
}

- (void)willDismissSearchController:(QMUISearchController *)searchController
{
    BOOL oleStatusBarLight = NO;
    if ([self respondsToSelector:@selector(shouldSetStatusBarStyleLight)])
    {
        oleStatusBarLight = [self shouldSetStatusBarStyleLight];
    }
    if (oleStatusBarLight)
    {
        [QMUIHelper renderStatusBarStyleLight];
    }
    else
    {
        [QMUIHelper renderStatusBarStyleDark];
    }
}

#pragma mark - CNContactPickerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts
{
    for (CNContact *cont in contacts)
    {
        NSMutableDictionary *userDic = [[NSMutableDictionary alloc] init];
        // 名字
        NSString *name = @"";
        if (cont.familyName)
        {
            name = [NSString stringWithFormat:@"%@",cont.familyName];
        }
        if (cont.givenName)
        {
            name = [NSString stringWithFormat:@"%@%@",name,cont.givenName];
        }
        [userDic setObject:name forKey:@"name"];
        if (cont.organizationName)
        {
            
            [userDic setObject:cont.organizationName forKey:@"organizationName"];
        }
        if (cont.imageData)
        {
            [userDic setObject:[UIImage imageWithData:cont.imageData] forKey:@"image"];
        }
        if (cont.phoneNumbers)
        {
            for (CNLabeledValue *labeValue in cont.phoneNumbers)
            {
                CNPhoneNumber *phoneNumber = labeValue.value;
                NSString *phone = [[phoneNumber.stringValue componentsSeparatedByString:@"-"] componentsJoinedByString:@""];
                if (phone.length == 11)
                {
                    [userDic setObject:phone forKey:@"phone"];
                }
            }
        }
        
        BAContactsModel *model = [[BAContactsModel alloc] init];
        model.user_Name = userDic[@"name"];
        model.user_Image = userDic[@"image"];
        model.user_PhoneNumber = userDic[@"phone"];
        
        if (![BAKit_Helper ba_helperIsNSStringNULL:model.user_Name])
        {
            if ([self ba_isArray:self.dataArray containsObject:model])
            {
                BAKit_ShowAlertWithMsg(@"此联系人已添加，请勿重复添加！");
            }
            else
            {
                [self.dataArray addObject:model];
            }
        }
    }
    
    [self getSectionData];
}

#pragma mark - custom Method
- (BOOL)ba_isArray:(NSArray <BAContactsModel *>*)array containsObject:(BAContactsModel *)object
{
    __block BOOL isExist = NO;
    [array enumerateObjectsUsingBlock:^(BAContactsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        if ([obj.user_Name isEqualToString:object.user_Name])
        {
            // 数组中已经存在该对象
            *stop = YES;
            isExist = YES;
        }
    }];
    if (!isExist)
    {
        // 如果不存在就添加进去
        isExist = NO;
    }
    return isExist;
}

- (void)handleAboutItemEvent
{
    self.contactPickerViewController = [[CNContactPickerViewController alloc] init];
    self.contactPickerViewController.delegate = (id<CNContactPickerDelegate>)self;
    [self presentViewController:self.contactPickerViewController animated:YES completion:nil];
    
    [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
}

- (void)ba_showAlertWithModel:(BAContactsModel *)model
{
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"博爱温馨提示" attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    
    NSString *message = [NSString stringWithFormat:@"你点击了 %@ ！", model.user_Name];
    NSString *keyWord = model.user_Name;
    
    /*! 关键字添加效果 */
    NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc]initWithString:message];
    
    /*! 获取关键字位置 */
    NSRange range = [message rangeOfString:keyWord];
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor],NSKernAttributeName:@2.0,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrokeColorAttributeName:[UIColor blueColor],NSStrokeWidthAttributeName:@2.0,NSVerticalGlyphFormAttributeName:@(0)};
    
    /*! 设置关键字属性 */
    [attributedMessage ba_changeAttributeDict:dic range:range];
    
    [UIAlertController ba_alertControllerShowAlertInViewController:self withTitle:@"博爱温馨提示" mutableAttributedTitle:attributedTitle message:@"" mutableAttributedMessage:attributedMessage buttonTitlesArray:@[@"取 消", @"确 定"] buttonTitleColorArray:@[UIColorGreen, UIColorRed] tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        if (buttonIndex == 0)
        {
            NSLog(@"你点击了取消按钮！");
        }
        else if (buttonIndex == 1)
        {
            NSLog(@"你点击了确定按钮！");
        }
        return;
    }];
}

#pragma mark - setter / getter
- (NSMutableArray <BAContactsModel *> *)searchResultsKeywordsArray
{
    if(_searchResultsKeywordsArray == nil)
    {
        _searchResultsKeywordsArray = [[NSMutableArray <BAContactsModel *> alloc] init];
    }
    return _searchResultsKeywordsArray;
}

- (NSMutableArray <BAContactsModel *> *)dataArray
{
    if(_dataArray == nil)
    {
        _dataArray = [[NSMutableArray <BAContactsModel *> alloc] init];
        
        NSArray *iconImageNamesArray = @[@"0.jpg",
                                         @"1.jpg",
                                         @"2.jpg",
                                         @"icon3.jpg",
                                         @"icon4.jpg",
                                         @"5.jpg",
                                         @"6.jpg",
                                         @"7.jpg",
                                         ];
        NSArray *namesArray = @[@"博爱",
                                @"boai",
                                @"小明",
                                @"陆晓峰",
                                @"石少庸是小明的老师",
                                @"石少庸",
                                @"Alix",
                                @"Tom",
                                @"Lucy",
                                @"123",
                                @"cydn",
                                @"mami",
                                @"888",
                                @"zhangSan",
                                @"王二",
                                @"微信",
                                @"张小龙"];
        
        NSMutableArray *iconArray = [NSMutableArray array];
        for (NSInteger i = 0; i < namesArray.count; i ++)
        {
            if (iconImageNamesArray.count < namesArray.count)
            {
                for (NSInteger j = 0; j < iconImageNamesArray.count; j ++)
                {
                    [iconArray addObject:iconImageNamesArray[BAKit_RandomNumber(iconImageNamesArray.count)]];
                }
            }
            BAContactsModel *model = [[BAContactsModel alloc] init];
            model.user_Image_url = iconArray[i];
            model.user_Name = namesArray[i];
            
            [self.dataArray addObject:model];
        }
    }
    return _dataArray;
}

- (NSMutableArray <NSString *> *)indexArray
{
    if(_indexArray == nil)
    {
        _indexArray = [[NSMutableArray <NSString *> alloc] init];
    }
    return _indexArray;
}

- (NSMutableArray *)sectionArray
{
    if(_sectionArray == nil)
    {
        _sectionArray = [[NSMutableArray alloc] init];
    }
    return _sectionArray;
}

- (BOOL)willDealloc
{
    return NO;
}

@end
