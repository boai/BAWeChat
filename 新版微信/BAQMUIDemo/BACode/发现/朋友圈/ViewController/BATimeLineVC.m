//
//  BATimeLineVC.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/9.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BATimeLineVC.h"

#import "BATimeLineCell.h"
#import "BATimeLineViewModel.h"
#import "BATimeLineModel.h"
#import "BAUser.h"

#import "BATimeLineContentView.h"
#import "BATimeLineOperationMenuView.h"

#import "BATimeLineTableHeaderView.h"

#import <YYModel.h>
#import "YYFPSLabel.h"


@interface BATimeLineVC () <UITableViewDelegate, UITableViewDataSource>
{
    int page;
    CABasicAnimation *_rotateAnimation;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <BATimeLineModel *>*dataArray;

@property (nonatomic, strong) NSMutableArray *viewModelArray;

//@property (nonatomic, strong) BAKit_LoadingView *loadingView;

@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@property (nonatomic, assign) CGFloat history_offset_y;

@property (nonatomic, strong) BAKit_KeyboardView *keyboardBar;

@property (nonatomic, strong) BATimeLineTableHeaderView *headerView;

@end

@implementation BATimeLineVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    self.view.backgroundColor = UIColorGreen;
}

- (void)setupUI
{
    self.title = @"朋友圈";
    self.view.backgroundColor = UIColorBlue;
    self.tableView.hidden = NO;
    self.headerView.hidden = NO;
    self.keyboardBar.hidden = YES;
    /*! 添加上下拉刷新 */
    [self setupRefreshView];

    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithType:QMUINavigationButtonTypeNormal title:@"清理缓存" position:QMUINavigationButtonPositionRight target:self action:@selector(handleClearCacheItemEvent)];
    
    _fpsLabel = [YYFPSLabel new];
    [_fpsLabel sizeToFit];
    _fpsLabel.bottom = self.view.height - 12;
    _fpsLabel.left = 12;
    _fpsLabel.alpha = 0;
    [self.view addSubview:_fpsLabel];
    
    if (kSystemVersion < 7) {
        _fpsLabel.top -= 44;
        _tableView.top -= 64;
        _tableView.height += 20;
    }
}

#pragma mark - UITableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BATimeLineCell *cell = [BATimeLineCell timeLineCellWithTableView:tableView indexPath:indexPath];
         
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    BATimeLineCell *cell2 = (BATimeLineCell *)cell;
    BATimeLineViewModel *viewModel = self.viewModelArray[indexPath.row];
    cell2.timeLineViewModel = viewModel;
    
    BAKit_WeakSelf
    [cell2.originalContentView.operationMenuView setLikedButtonActionBlock:^{
        
    }];
    [cell2.originalContentView.operationMenuView setCommentButtonActionBlock:^{
        
        weak_self.keyboardBar.hidden = NO;
//        weak_self.keyboardBar.showEmotionButton = YES;
        [weak_self.keyboardBar ba_showKeyboardView];
        
        [weak_self.keyboardBar setBATimeLineKeyboardViewReturnBlock:^(id contentString) {
            NSString *msg = [NSString stringWithFormat:@"成功发送文字：%@",contentString];
            NSLog(@"%@", msg);
            BATimeLineModel *tempModel = viewModel.model;
            NSMutableArray *temp = [NSMutableArray new];
            [temp addObjectsFromArray:tempModel.comments];
            
            BATimeLineCommentModel *model = [BATimeLineCommentModel new];
            BAUser *firstUser = [BAUser new];
            firstUser.user_Id = @"18";
            firstUser.user_Name = @"博爱1616";
            model.firstUser = firstUser;
            if ([contentString isKindOfClass:[NSString class]])
            {
                model.commentContent = contentString;
            }
            else if ([contentString isKindOfClass:[NSString class]])
            {
                model.attributedContent = [BAKit_EmotionString ba_getEmotionMutableAttributedStringWithContent:contentString];
            }
            
            [temp addObject:model];
            
            tempModel.comments = [temp copy];
            viewModel.model = tempModel;
            [weak_self.tableView reloadData];
            [weak_self.keyboardBar ba_hideKeyboardView];
            weak_self.keyboardBar.hidden = YES;
        }];
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.keyboardBar ba_hideKeyboardView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BATimeLineViewModel *viewModel = self.viewModelArray[indexPath.row];
    return viewModel.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    BATimeLineViewModel *viewModel = self.viewModelArray[indexPath.row];
//    [viewModel.model.comments enumerateObjectsUsingBlock:^(BATimeLineCommentModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"你点击了评论：%@", obj.commentContent);
//    }];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 1;
        } completion:NULL];
    }
    [self.keyboardBar ba_hideKeyboardView];
    self.keyboardBar.hidden = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (_fpsLabel.alpha != 0) {
            [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                _fpsLabel.alpha = 0;
            } completion:NULL];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha != 0) {
        [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 0;
        } completion:NULL];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark - custom method
- (void)viewWillLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, -100, SCREEN_WIDTH, SCREEN_HEIGHT+100);
    BAKit_UITableViewSetSeparatorInset(self.tableView, BAKit_ColorCyan, UIEdgeInsetsMake(0, 0, 0, 0));
    
//    CGFloat lodingViewSizeWidth  = SCREEN_WIDTH * 0.55;
//    CGFloat lodingViewSizeHeight = lodingViewSizeWidth * 0.68;

//    self.loadingView.frame = CGRectMake(0, 0, lodingViewSizeWidth, lodingViewSizeHeight);
//    self.loadingView.center = self.view.center;
    
    self.keyboardBar.frame = CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44);

}

#pragma mark 清理缓存
- (void)handleClearCacheItemEvent
{
    [self ba_clearCache];
}

#pragma mark - ***** 添加上下拉刷新
- (void)setupRefreshView
{
    BAKit_WeakSelf
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.tableView ba_addHeaderRefresh:^{
        [weak_self loadNewData];
    }];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];

    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.tableView ba_addFooterRefresh:^{
        [weak_self loadMoreData];
    }];
    
}

- (void)loadNewData
{
    [self getDataWithHead:YES];
}

- (void)loadMoreData
{
    [self getDataWithHead:NO];
}

#pragma mark - *****  接口数据
- (void)getDataWithHead:(BOOL)isHead
{
//    [QMUITips showLoading:@"加载中..." inView:self.navigationController.view hideAfterDelay:2.0f];
    
    if (isHead)
    {
//        self.loadingView.hidden = NO;
    }
    BAKit_WeakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (isHead)
        {
            [weak_self.tableView.mj_header endRefreshing];
            [weak_self.viewModelArray removeAllObjects];
//            weak_self.loadingView.hidden = YES;
        }
        else
        {
            [weak_self.tableView.mj_footer endRefreshing];
        }
//        sleep(1.0f);
//        [QMUITips showSucceed:@"加载成功！" inView:self.navigationController.view hideAfterDelay:2.0f];
        [weak_self creatDataWithCount:10];
        [weak_self.tableView reloadData];
    });
}

- (void)creatDataWithCount:(NSInteger)count
{
//    BAKit_WeakSelf
//    NSDictionary *dict = BAKit_GetDictionaryWithContentsOfFile(@"timeLineResources", @"json");
//
//    NSArray *dataArray = dict[@"data"];
//    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        BATimeLineModel *model = [BATimeLineModel yy_modelWithDictionary:obj];
//        [weakSelf.dataArray addObject:model];
//    }];
//    
//    NSMutableArray *statusF = [NSMutableArray array];
//    for (BATimeLineModel *model in self.dataArray)
//    {
//        BATimeLineViewModel *viewModel = [[BATimeLineViewModel alloc] init];
//        viewModel.model = model;
//        [statusF addObject:viewModel];
//    }
//    [self.viewModelArray addObjectsFromArray:statusF];
    
    
    NSArray *iconImageNamesArray = @[
                                     @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1809343/dots17.1.gif",
                                     @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1845612/dots22.gif",
                                     @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1820014/big-hero-6.gif",
                                     @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1819006/dots11.0.gif",
                                     @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1799885/dots21.gif",
                                     @"http://imgsrc.baidu.com/forum/w%3D580/sign=4aecdc7096dda144da096cba82b6d009/af51f3deb48f8c54d2d5bd4c3b292df5e0fe7f4a.jpg",
                                     @"http://yun.hainei.org/forum/201511/29/211741jst1c9dypdpquz82.jpg",
                                     @"http://pic.962.net/up/2012-7/2012070515200911897.jpg",
                                     @"http://imgsrc.baidu.com/forum/w%3D580/sign=c42ab2bfe850352ab16125006342fb1a/9a504fc2d56285351b046f2991ef76c6a6ef63d6.jpg",
                                     @"http://imgsrc.baidu.com/forum/pic/item/29381f30e924b8999865a79e6e061d950a7bf63f.jpg",
                                     @"http://imgsrc.baidu.com/forum/pic/item/6ee43801213fb80e9ec17e2036d12f2eb83894c6.jpg",
                                     @"http://www.kkeju.com/data/attachment/image/20130720/9c96e4bb50d6d058a82316e5605c9162.jpg",
                                     @"http://imgsrc.baidu.com/forum/w%3D580/sign=0877b1ad71cf3bc7e800cde4e101babd/7b899e510fb30f242dd9a1a3c995d143ac4b03ca.jpg",
                                     @"http://imgsrc.baidu.com/forum/pic/item/e61190ef76c6a7ef64f37f8afdfaaf51f2de6641.jpg",
                                     @"http://img3.fengniao.com/forum/attachpics/697/198/27879556_600.jpg",
                                     @"http://imgsrc.baidu.com/forum/pic/item/9f2f070828381f30cb964001a9014c086f06f08f.jpg",
                                     @"http://wx4.sinaimg.cn/mw690/722ed599ly1fconzatfwtj206406474e.jpg",
                                     @"http://wx3.sinaimg.cn/mw690/722ed599ly1fconzh115oj206406474d.jpg"
                                     ];

    NSArray *namesArray = @[@"博爱",
                            @"小明",
                            @"陆晓峰",
                            @"石少庸是小明的老师",
                            @"石少庸"];

    NSArray *textArray = @[@"耳机只要一取出，就可与你的各种设备配合使用。将它们戴入耳中，瞬间便完成连接。对它们讲话时，你的声音格外清晰。全新 AirPods，令简约与技术的融合更胜以往，带来妙处连连。",
                           @"简单轻点一下即可完成设置，然后 AirPods 便自动开启并始终保持连接1。(http://boaihome.com)使用也同样轻轻松松，一戴入耳中它们即可感知，一取出就会暂停播放。(https://github.com/boai)无论是聆听你的 iPhone、Apple Watch、iPad，还是 Mac 上的内容，使用 AirPods 的体验都同样精彩。",
                           @"与你喜爱的私人助理交谈轻而易举。",
                           @"AirPods 的所有创举均得益于 Apple(http://boaihome.com) 特别设计的 W1 芯片。它带来十分高效的无线性能，从而提供更佳的连接和更好的音质。【晓峰电话：18566664494】W1 芯片对电池续航时间的管理十分出色，一次充电即可让你尽情聆听 5 小时3。如此高性能，集成在如此小巧的设备中，闻所未闻。",
                           @"AirPods 一次充电可聆听 5 小时3，表现出众。再加上充电盒能存储多次额外充电的电量，满足超过 24 小时的续航， AirPods 更能与你时刻相伴4。(https://www.baidu.com)需要快速充电？只需放入充电盒中 15 分钟即可获得最长可达 3 小时的聆听时间5。【博爱电话：[tel:10010]】要查看电池电量，只需将 AirPods 靠近你的 iPhone，或者问问 Siri 你的 AirPods 还剩多少电量。",
                           @"Multi-Touch Bar 取代了以往键盘最上方的功能键，为你带来更多能、更实用的功能2。它会根据你当前的操作自动显示不同的样子，呈现给你相关的工具，比如系统控制键里的音量和亮度、互动操作中的调整和内容浏览工具、智能输入功能中的表情符号和文本输入预测等等，这些都是你早就运用自如的。此外，Touch ID 功能也首次登陆 Mac，让你可以在转瞬之间完成登录等各种操作。",
                           @"新一代 MacBook Pro 的推出，将笔记本电脑的性能与便携性提升到一个新的高度。无论你的目标有多远大，它强劲的图形处理器、高性能的中央处理器、先进的存储设备，以及众多强大配置，都能助你加速实现创意构想。",
                           @"各行各业， 都是专业利器。",
                           @"MacBook Pro 配备的是更胜以往的 Mac 笔记本电脑显示屏。它采用比以往亮度更高的 LED 背光组件，并且提升了对比度，因此呈现出来的黑色更加深邃，白色更加明亮。更大的像素孔径和可变的刷新率，使它比上一代机型能效更高。而且，全新 MacBook Pro 是首款拥有广色域的 Mac 笔记本电脑，可以使绿色和红色的显示效果更加鲜艳生动，让画面的细节鲜明毕现，栩栩如生。对于图形设计、调色和影像编辑来说，这一点至关重要。"
                           ];
    
    NSArray *commentsArray = @[
                               @"你好，我好，(https://www.baidu.com)大家好才是真的好",
                               @"让画面的细节鲜明毕现，栩栩如生。对于图形设计、调色和影像编辑来说，这一点至关重要。",
                               @"正宗好凉茶，(https://www.baidu.com)正宗好声音。。。",
                               @"有意思",
                               @"你瞅啥？",
                               @"瞅你咋地？？？！！！",
                               @"hello，看我",
                               @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真",
                               @"人艰不拆",
                               @"咯咯哒",
                               @"MacBook Pro 的推出，将笔记本电脑的性能与便携性提升到一个新的高度。无论你的目标有多远大，它强劲的图形处理器、高性能的中央处理器、先进的存储设备，以及众多强大配置，都能助你加速实现创意构想。",
                               @"我勒个去，(https://www.baidu.com)啥世道啊",
                               @"真有意思啊你💢💢💢"];
    
    NSArray *timeArray = @[@"2017-01-06 16:08:01",
                           @"2017-01-11 19:25:01",
                           @"2017-01-12 16:30:01",
                           @"2017-01-10 18:09:01",
                           @"2017-01-12 11:18:01"];

    NSArray *sourceArray = @[@"iPhone 7 黑",
                             @"iPhone 7 亮黑",
                             @"iPhone 7 Plus 亮黑",
                             @"锤子 M1L 白金",
                             @"锤子 T3 珊瑚蓝"];

    NSArray *picImageNamesArray = @[
                                    @"http://pic.58pic.com/58pic/15/14/01/23E58PIC2dw_1024.jpg",
                                    @"http://pic2.ooopic.com/11/84/38/09bOOOPICa0_1024.jpg",
                                    @"http://cdn.duitang.com/uploads/blog/201408/22/20140822202718_hneZH.jpeg",
                                    @"http://img2.3lian.com/2014/f2/159/40.jpg",
                                    @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1780193/dots18.gif",
                                    @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1809343/dots17.1.gif",
                                    @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1845612/dots22.gif",
                                    @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1820014/big-hero-6.gif",
                                    @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1819006/dots11.0.gif",
                                    @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1799885/dots21.gif",
                                    @"http://img4.duitang.com/uploads/item/201312/21/20131221161708_z2mKE.jpeg",
                                    @"http://img3.fengniao.com/forum/attachpics/840/60/33571903_1024.jpg",
                                    @"http://image92.360doc.com/DownloadImg/2015/12/3122/63804170_1.jpg",
                                    @"http://img2.3lian.com/2014/f4/102/d/91.jpg",
                                    @"http://img5.duitang.com/uploads/item/201504/19/20150419H0914_rf5xj.thumb.700_0.jpeg",
                                    @"http://images.sx.dagongnet.com/2013/1010/20131010103819706.jpg",
                                    @"http://pic.58pic.com/58pic/15/12/54/94758PICNwY_1024.jpg",
                                    @"http://wx4.sinaimg.cn/mw690/722ed599ly1fconzatfwtj206406474e.jpg",
                                    @"http://wx3.sinaimg.cn/mw690/722ed599ly1fconzh115oj206406474d.jpg"
                                    ];

    for (NSInteger i = 0; i < count; i++)
    {
        BAUser *user = [[BAUser alloc] init];
        user.user_Name = namesArray[BAKit_RandomNumber(namesArray.count-1)];
        user.user_Image_url = iconImageNamesArray[BAKit_RandomNumber(iconImageNamesArray.count-1)];
        user.user_Id = @(i).stringValue;

        BATimeLineModel *model = [[BATimeLineModel alloc] init];
        model.user = user;
        model.content = textArray[BAKit_RandomNumber(textArray.count-1)];
        model.contentId = @(i).stringValue;
        model.created_time = timeArray[BAKit_RandomNumber(timeArray.count-1)];
        model.source = sourceArray[BAKit_RandomNumber(sourceArray.count-1)];

        /*! 模拟“随机图片” */
        NSInteger random = BAKit_RandomNumber(9);
        NSMutableArray *temp = [NSMutableArray array];
        for (NSInteger i = 0; i < random; i++)
        {
            [temp addObject:picImageNamesArray[BAKit_RandomNumber(picImageNamesArray.count-1)]];
        }
        if (temp.count > 0)
        {
            model.pic_urls = [temp copy];
        }

        /*! 模拟随机评论数据 */
        NSInteger commentRandom = BAKit_RandomNumber(3);
        NSMutableArray *tempCommentsArray = [NSMutableArray array];
        for (int i = 0;  i < commentRandom; i ++)
        {
            BATimeLineCommentModel *commentModel = [BATimeLineCommentModel new];
            NSInteger index = BAKit_RandomNumber(namesArray.count);
            BAUser *firstUser = [BAUser new];
            firstUser.user_Name = namesArray[index];
            firstUser.user_Id = @(index).stringValue;
            commentModel.firstUser = firstUser;
            
            if (BAKit_RandomNumber(8) < 5)
            {
                BAUser *secondUser = [BAUser new];
                secondUser.user_Name = namesArray[arc4random_uniform((int)namesArray.count)];
                secondUser.user_Id = @(index).stringValue;
                commentModel.secondUser = secondUser;
            }
            commentModel.commentContent = commentsArray[BAKit_RandomNumber(commentsArray.count)];
            
            [tempCommentsArray addObject:commentModel];
        }
        model.comments = [tempCommentsArray copy];
        
        [self.dataArray addObject:model];
    }

    NSMutableArray *statusF = [NSMutableArray array];
    for (BATimeLineModel *model in self.dataArray)
    {
        BATimeLineViewModel *viewModel = [[BATimeLineViewModel alloc] init];
        viewModel.model = model;
        [statusF addObject:viewModel];
    }
    [self.viewModelArray addObjectsFromArray:statusF];
}

#pragma mark - setter / getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        
        _tableView.backgroundColor = TableViewBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray <BATimeLineModel *> *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

- (NSMutableArray *)viewModelArray
{
    if(_viewModelArray == nil) {
        _viewModelArray = [[NSMutableArray alloc] init];
    }
    return _viewModelArray;
}

//- (BAKit_LoadingView *)loadingView {
//	if(_loadingView == nil) {
//		_loadingView = [[BAKit_LoadingView alloc] init];
//        
//        self.loadingView.loadingType = BALoadingViewTypeWin10;
//        self.loadingView.themColor = BAKit_ColorCyan;
//        self.loadingView.ballSize = 15;
//        
//        [self.loadingView jm_setImageWithCornerRadius:15.0f borderColor:UIColorMask borderWidth:nice(0) backgroundColor:BAKit_ColorTranslucent];
//        [self.view addSubview:self.loadingView];
//	}
//	return _loadingView;
//}

- (BAKit_KeyboardView *)keyboardBar {
    if(_keyboardBar == nil) {
        _keyboardBar = [[BAKit_KeyboardView alloc] init];
        _keyboardBar.frame = CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44);
        
        [self.view addSubview:self.keyboardBar];
    }
    return _keyboardBar;
}

- (BATimeLineTableHeaderView *)headerView {
    if(_headerView == nil) {
        _headerView = [[BATimeLineTableHeaderView alloc] init];
        self.headerView.frame = CGRectMake(0, 0, 0, SCREEN_HEIGHT * 0.6);
        
        self.tableView.tableHeaderView = self.headerView;
    }
    return _headerView;
}

- (void)dealloc
{
    if (self.tableView)
    {
        [self.tableView removeFromSuperview];
        self.tableView = nil;
    }
    if (self.dataArray)
    {
        [self.dataArray removeAllObjects];
        self.dataArray = nil;
    }
    if (self.viewModelArray)
    {
        [self.viewModelArray removeAllObjects];
        self.viewModelArray = nil;
    }
//    if (self.loadingView)
//    {
//        [self.loadingView removeFromSuperview];
//        self.loadingView = nil;
//    }
}




@end

