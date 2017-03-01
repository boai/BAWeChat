//
//  DemoVC4.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/17.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "DemoVC4.h"
#import "PPGetAddressBook.h"


#define cellHeight        50
#define cellImageViewSize cellHeight * 0.8


@interface DemoVC4 ()

@property (nonatomic, strong) NSDictionary *contactPeopleDict;
@property (nonatomic, strong) NSArray *namesArray;

@end

@implementation DemoVC4

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
}

- (void)setupUI
{
    [self getSystermContacts];
    
}

- (void)getSystermContacts
{
    QMUITips *tips = [QMUITips showLoading:@"加载中..." inView:self.view];
    [PPGetAddressBook getOrderAddressBook:^(NSDictionary<NSString *,NSArray *> *addressBookDict, NSArray *namenamesArray) {
        
        [tips removeFromSuperview];
        
        /*! 装着所有联系人的字典 */
        self.contactPeopleDict = addressBookDict;
        /*! 联系人分组按拼音分组的Key值 */
        self.namesArray = namenamesArray;
        
        [self.tableView reloadData];
    } authorizationFailure:^{
        [tips removeFromSuperview];
        [UIAlertController ba_alertControllerShowAlertInViewController:self withTitle:@"博爱温馨提示" mutableAttributedTitle:nil message:@"请在iPhone的“设置-隐私-通讯录”选项中，允许PPAddressBook访问您的通讯录" mutableAttributedMessage:nil buttonTitlesArray:@[@"取 消", @"确 定"] buttonTitleColorArray:@[UIColorGreen, UIColorRed] tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
            
        }];
        return ;
    }];
    
}

#pragma mark - TableViewDatasouce/TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.namesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contactPeopleDict[self.namesArray[section]] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.namesArray[section];
}

#pragma mark - 右侧的索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.namesArray;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cell";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[QMUITableViewCell alloc] initForTableView:self.tableView withStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    NSString *userName = self.namesArray[indexPath.section];
    PPPersonModel *model = self.contactPeopleDict[userName][indexPath.row];
    
    UIImage *image = model.headerImage ? model.headerImage:BAKit_DefaultUserImage;
    cell.imageView.image = [UIImage ba_imageToChangeCellRoundImageViewSizeWithCell:cell image:image imageSize:CGSizeMake(cellImageViewSize, cellImageViewSize)];
    cell.textLabel.text = model.name;
    
    NSString *mobileText = @"";
    if (model.mobileArray)
    {
        
        for (NSInteger i = 0; i < model.mobileArray.count; i++)
        {
            if (i == 0)
            {
                mobileText = [NSString stringWithFormat:@"%@", model.mobileArray[i]];
            }
            else
            {
                mobileText = [NSString stringWithFormat:@"%@，%@", mobileText, model.mobileArray[i]];
            }
        }
        cell.detailTextLabel.text = mobileText;
        cell.detailTextLabel.font = UIFontMake(12);
        cell.detailTextLabelEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0);
    }
    
    [cell updateCellAppearanceWithIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *userName = self.namesArray[indexPath.section];
    PPPersonModel *model = self.contactPeopleDict[userName][indexPath.row];
    NSString *msg = [NSString stringWithFormat:@"姓名：%@，电话：%@", model.name, model.mobileArray];
    [UIAlertController ba_alertControllerShowAlertInViewController:self withTitle:@"博爱温馨提示" mutableAttributedTitle:nil message:msg mutableAttributedMessage:nil buttonTitlesArray:@[@"取 消", @"确 定"] buttonTitleColorArray:@[UIColorGreen, UIColorRed] tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

#pragma mark - setter / getter
- (NSDictionary *)contactPeopleDict
{
	if(_contactPeopleDict == nil)
    {
		_contactPeopleDict = [[NSDictionary alloc] init];
	}
	return _contactPeopleDict;
}

- (NSArray *)namesArray
{
	if(_namesArray == nil)
    {
		_namesArray = [[NSArray alloc] init];
	}
	return _namesArray;
}

@end
