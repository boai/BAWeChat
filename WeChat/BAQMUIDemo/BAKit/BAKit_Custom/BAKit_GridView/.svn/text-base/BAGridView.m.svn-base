//
//  BAGridView.m
//  yunlianWIFI
//
//  Created by boai on 2017/4/6.
//  Copyright © 2017年 yunlianhui. All rights reserved.
//

#import "BAGridView.h"
#import "BAGridCollectionCell.h"
#import "BAGridViewTypeTitleDescCell.h"
#import "BAGridItemModel.h"

static NSString * const kCellID = @"BAGridCollectionCell";
static NSString * const kCellID2 = @"BAGridViewTypeTitleDescCell";

@interface BAGridView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, assign) CGFloat gridItem_w_h;
/**
 每行有多少个 item，默认为4个，正方形方格
 */
@property(nonatomic, assign) NSInteger rowCount;


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

- (instancetype)ba_creatGridViewWithType:(BAGridViewType)type
                                itemSize:(CGSize)itemSize
                               dataArray:(NSArray <BAGridItemModel *>*)dataArray
                                   block:(BAGridViewBlock)block
{
    if (self == [super init])
    {
        self.gridViewType = type;
        self.gridViewItemSize = itemSize;
        self.dataArray = dataArray;
        self.gridViewBlock = block;
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = BAKit_Color_White;
    self.collectionView.hidden = NO;
    
    self.gridViewType = BAGridViewTypeImageTitle;
    
    self.rowCount = 4;
    self.gridViewItemSize = BAKit_CGSizeFlatted(CGSizeMake(self.gridItem_w_h, self.gridItem_w_h));
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
    if (self.gridViewType == BAGridViewTypeImageTitle)
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
        cell.backgroundColor = BAKit_Color_White;
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }
    else if (self.gridViewType == BAGridViewTypeTitleDesc)
    {
        cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID2 forIndexPath:indexPath];
        cell2.backgroundColor = BAKit_Color_White;
        cell2.model = self.dataArray[indexPath.row];
        
        return cell2;
    }
    
//    BAGridCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
//    cell.backgroundColor = BAKit_Color_White;
//    cell.model = self.dataArray[indexPath.row];
//    
    return [UICollectionViewCell new];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    BAGridItemModel *model = self.dataArray[indexPath.row];

    if (self.gridViewBlock)
    {
        self.gridViewBlock(model, indexPath);
    }    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return BAKit_CGSizeFlatted(self.gridViewItemSize);
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
        flowLayout.minimumLineSpacing = BAKit_Margin_1;
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = BAKit_Color_Gray_10;
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

- (void)setGridViewCellHeight:(CGFloat)gridViewCellHeight
{
    [self.collectionView reloadData];
}

- (void)setGridViewIemSize:(CGSize)gridViewItemSize
{
    _gridViewItemSize = gridViewItemSize;
    [self.collectionView reloadData];
}

- (void)setRowCount:(NSInteger)rowCount
{
    _rowCount = rowCount;
    
    self.gridItem_w_h = BAKit_Flat((BAKit_SCREEN_WIDTH - (rowCount - 1) * BAKit_Margin_1)/rowCount);
    [self.collectionView reloadData];
}


@end
