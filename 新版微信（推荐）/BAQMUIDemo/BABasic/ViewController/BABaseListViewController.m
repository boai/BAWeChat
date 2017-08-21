//
//  BABaseListViewController.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/10.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BABaseListViewController.h"

@interface BABaseListViewController ()

@end

@implementation BABaseListViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style])
    {
        [self initDataSource];
    }
    return self;
}

#pragma mark - UITableView Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceWithDetailText ? self.dataSourceWithDetailText.count : self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"BABaseListViewController";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        if (self.dataSourceWithDetailText)
        {
            cell = [[QMUITableViewCell alloc] initForTableView:self.tableView withStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        else
        {
            cell = [[QMUITableViewCell alloc] initForTableView:self.tableView withStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (self.dataSourceWithDetailText)
    {
        NSString *keyName = self.dataSourceWithDetailText.allKeys[indexPath.row];
        cell.textLabel.text = keyName;
        cell.detailTextLabel.text = (NSString *)[self.dataSourceWithDetailText objectForKey:keyName];
    }
    else
    {
        cell.textLabel.text = self.dataSourceArray[indexPath.row];
    }
    cell.textLabel.font = UIFontMake(15);
    cell.detailTextLabel.font = UIFontMake(13);
    [cell updateCellAppearanceWithIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSourceWithDetailText && ((NSString *)[self.dataSourceWithDetailText objectForKey:self.dataSourceWithDetailText.allKeys[indexPath.row]]).length)
    {
        return 64;
    }
    return TableViewCellNormalHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *title = nil;
    if (self.dataSourceWithDetailText)
    {
        title = self.dataSourceWithDetailText.allKeys[indexPath.row];
    }
    else
    {
        title = self.dataSourceArray[indexPath.row];
    }
    [self didSelectCellWithTitle:title];
}

@end

@implementation BABaseListViewController (UISubclassingHooks)

// 子类继承，可以不调super
- (void)initDataSource
{

}

- (void)didSelectCellWithTitle:(NSString *)title
{
    
}

@end
