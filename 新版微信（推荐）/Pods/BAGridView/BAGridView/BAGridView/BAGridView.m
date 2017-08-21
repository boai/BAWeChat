//
//  BAGridView.m
//  BAKit
//
//  Created by boai on 2017/4/14.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BAGridView.h"
#import "BAGridCollectionCell.h"
#import "BAGridViewTypeTitleDescCell.h"
#import "BAGridItemModel.h"
#import "BAKit_ConfigurationDefine.h"

static NSString * const kCellID = @"BAGridCollectionCell";
static NSString * const kCellID2 = @"BAGridViewTypeTitleDescCell";

@interface BAGridView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, assign) CGFloat gridItem_w;
@property(nonatomic, assign) CGFloat ba_gridView_lineWidth;
@property(nonatomic, weak) NSIndexPath  *selectIndexPath;

@end

@implementation BAGridView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setupUI];
    }
    return self;
}

/**
 快速创建宫格
 
 @param gridViewType 样式
 @param dataArray 数据
 @param configurationBlock 配置回调
 @param block 点击事件回调
 @return BAGridView
 */
+ (instancetype)ba_creatGridViewWithGridViewType:(BAGridViewType)gridViewType
                                       dataArray:(NSArray <BAGridItemModel *>*)dataArray
                              configurationBlock:(BAGridView_configurationBlock)configurationBlock
                                           block:(BAGridViewBlock)block
{
    BAGridView *tempView = [[BAGridView alloc] init];
    if (configurationBlock)
    {
        configurationBlock(tempView);
    }
    tempView.gridViewType = gridViewType;
    tempView.dataArray = dataArray;
    tempView.ba_gridViewBlock = block;
    
    return tempView;
}

- (void)setupUI
{
    self.backgroundColor = BAKit_Color_Clear_pod;
    self.collectionView.hidden = NO;
    
    // 默认配置
    self.gridViewType = BAGridViewTypeImageTitle;
    
    self.ba_gridView_rowCount = 4;
    self.ba_gridView_lineColor = BAKit_Color_Gray_10_pod;
    self.ba_gridView_lineWidth = BAKit_Flat_pod(0.5f);
    self.ba_gridView_titleColor = BAKit_Color_Black_pod;
    self.ba_gridView_titleDescColor = BAKit_Color_Gray_9_pod;
    self.ba_gridView_itemImageInset = 0;
    self.ba_gridView_backgroundColor = BAKit_Color_White_pod;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BAGridCollectionCell *cell;
    BAGridViewTypeTitleDescCell *cell2;
    [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    if (self.gridViewType == BAGridViewTypeImageTitle)
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
        cell.backgroundColor = BAKit_Color_Clear_pod;
        
        cell.model = self.dataArray[indexPath.row];
        cell.ba_gridView_titleColor = self.ba_gridView_titleColor;
        cell.ba_gridView_lineColor = self.ba_gridView_lineColor;
        cell.ba_gridView_lineWidth = self.ba_gridView_lineWidth;
        cell.ba_gridView_itemImageInset = self.ba_gridView_itemImageInset;
        cell.ba_gridView_titleFont = self.ba_gridView_titleFont;
        
        return cell;
    }
    else if (self.gridViewType == BAGridViewTypeTitleDesc)
    {
        cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID2 forIndexPath:indexPath];
        cell2.backgroundColor = BAKit_Color_Clear_pod;
        
        cell2.model = self.dataArray[indexPath.row];
        cell2.ba_gridView_titleColor = self.ba_gridView_titleColor;
        cell2.ba_gridView_titleDescColor = self.ba_gridView_titleDescColor;
        cell2.ba_gridView_lineColor = self.ba_gridView_lineColor;
        cell2.ba_gridView_lineWidth = self.ba_gridView_lineWidth;
        cell2.ba_gridView_itemImageInset = self.ba_gridView_itemImageInset;
        cell2.ba_gridView_titleFont = self.ba_gridView_titleFont;
        cell2.ba_gridView_titleDescFont = self.ba_gridView_titleDescFont;
        
        return cell2;
    }
    
    return [UICollectionViewCell new];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    UICollectionViewCell *cell =  [collectionView cellForItemAtIndexPath:indexPath];
    // 选中之后的cell变颜色
    [self ba_updateCell:cell indexPath:indexPath selected:YES];
    
    BAGridItemModel *model = self.dataArray[indexPath.row];

    if (self.ba_gridViewBlock)
    {
        self.ba_gridViewBlock(model, indexPath);
    }    
}

// 取消选中操作
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];

    [self ba_updateCell:cell indexPath:indexPath selected:NO];
}

// 改变cell的背景颜色
- (void)ba_updateCell:(id)cell
            indexPath:(NSIndexPath *)indexPath
             selected:(BOOL)selected
{
    [UIView animateWithDuration:0.20f animations:^{
        ((UICollectionViewCell *)cell).backgroundColor = selected ? self.ba_gridView_selectedBackgroundColor : self.ba_gridView_backgroundColor;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f animations:^{
            ((UICollectionViewCell *)cell).backgroundColor = self.backgroundColor;
        }];
    }];

    self.selectIndexPath = indexPath;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSizeMake(self.gridItem_w, self.ba_gridView_itemHeight));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - setter / getter
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = BAKit_Color_Clear_pod;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;

        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)setGridViewType:(BAGridViewType)gridViewType
{
    _gridViewType = gridViewType;
    
    if (self.gridViewType == BAGridViewTypeImageTitle)
    {
        [_collectionView registerClass:[BAGridCollectionCell class] forCellWithReuseIdentifier:kCellID];
    }
    else if (self.gridViewType == BAGridViewTypeTitleDesc)
    {
        [_collectionView registerClass:[BAGridViewTypeTitleDescCell class] forCellWithReuseIdentifier:kCellID2];
    }
    [self.collectionView reloadData];
}

- (void)setBa_gridView_rowCount:(NSInteger)ba_gridView_rowCount
{
    _ba_gridView_rowCount = ba_gridView_rowCount;
    self.gridItem_w = (BAKit_SCREEN_WIDTH - (ba_gridView_rowCount - 1) * self.ba_gridView_lineWidth)/ba_gridView_rowCount;

    [self.collectionView reloadData];
}

- (void)setBa_gridView_lineWidth:(CGFloat)ba_gridView_lineWidth
{
    _ba_gridView_lineWidth = ba_gridView_lineWidth;
    [self.collectionView reloadData];
}

- (void)setBa_gridView_itemHeight:(CGFloat)ba_gridView_itemHeight
{
    _ba_gridView_itemHeight = ba_gridView_itemHeight;
    [self.collectionView reloadData];
}

- (void)setBa_gridView_titleColor:(UIColor *)ba_gridView_titleColor
{
    _ba_gridView_titleColor = ba_gridView_titleColor;
    [self.collectionView reloadData];
}

- (void)setBa_gridView_titleDescColor:(UIColor *)ba_gridView_titleDescColor
{
    _ba_gridView_titleDescColor = ba_gridView_titleDescColor;
    [self.collectionView reloadData];
}

- (void)setBa_gridView_lineColor:(UIColor *)ba_gridView_lineColor
{
    _ba_gridView_lineColor = ba_gridView_lineColor;
    [self.collectionView reloadData];
}

- (void)setBa_gridView_itemImageInset:(CGFloat)ba_gridView_itemImageInset
{
    _ba_gridView_itemImageInset = ba_gridView_itemImageInset;
    [self.collectionView reloadData];
}

- (void)setShowLineView:(BOOL)showLineView
{
    _showLineView = showLineView;
    
    if (!showLineView)
    {
        self.ba_gridView_lineWidth = 0;
        [self.collectionView reloadData];
    }
}

- (void)setBa_gridView_titleFont:(UIFont *)ba_gridView_titleFont
{
    _ba_gridView_titleFont = ba_gridView_titleFont;
    [self.collectionView reloadData];
}

- (void)setBa_gridView_titleDescFont:(UIFont *)ba_gridView_titleDescFont
{
    _ba_gridView_titleDescFont = ba_gridView_titleDescFont;
    [self.collectionView reloadData];
}

- (void)setBa_gridView_backgroundColor:(UIColor *)ba_gridView_backgroundColor
{
    _ba_gridView_backgroundColor = ba_gridView_backgroundColor;
    self.backgroundColor = ba_gridView_backgroundColor;
    [self.collectionView reloadData];
}

- (void)setBa_gridView_selectedBackgroundColor:(UIColor *)ba_gridView_selectedBackgroundColor
{
    _ba_gridView_selectedBackgroundColor = ba_gridView_selectedBackgroundColor;
}

@end
