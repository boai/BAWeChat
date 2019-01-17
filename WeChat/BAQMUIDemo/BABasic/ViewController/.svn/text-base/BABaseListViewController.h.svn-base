//
//  BABaseListViewController.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/10.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BABaseTableViewController.h"

@interface BABaseListViewController : BABaseTableViewController

@property (nonatomic, strong) NSArray<NSString *> *dataSourceArray;
@property (nonatomic, strong) QMUIOrderedDictionary *dataSourceWithDetailText;

@end

@interface BABaseListViewController (UISubclassingHooks)

// 子类继承，可以不调super
- (void)initDataSource;
- (void)didSelectCellWithTitle:(NSString *)title;

@end
