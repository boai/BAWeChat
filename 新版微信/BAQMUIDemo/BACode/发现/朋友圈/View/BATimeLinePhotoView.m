//
//  BATimeLinePhotoView.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/13.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BATimeLinePhotoView.h"
#import "BATimeLineModel.h"
#import "BATimeLineViewModel.h"
//#import "SDPhotoBrowser.h"

#import "MWPhotoBrowser.h"

#import "BABaseViewController.h"

@interface BATimeLinePhotoView ()
{
    CGRect photoViewFrame;
}
@property (nonatomic, strong) NSArray *imageViewsArray;
@property (nonatomic, strong) NSArray *photosArray;

@end

@implementation BATimeLinePhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{

}

//- (void)layoutSubviews
//{
//    [self setupFrame];
//}

#pragma mark - custom method
- (void)setupFrame
{
//    self.frame = _timeLineViewModel.photoViewFrame;
}

- (void)setupData
{
    /*! 图片创建 */
    CGFloat item_width = [self itemWidthForPicPathArray:self.photosArray];
    CGFloat item_height = 0;
    photoViewFrame = CGRectZero;
    if (self.photosArray.count > 0)
    {
        if (self.photosArray.count == 1)
        {
            item_height = CGRectGetHeight(_timeLineViewModel.photoViewFrame);
        }
        else
        {
            item_height = item_width;
        }
        long perRowItemCount = [self perRowItemCountForPicPathArray:self.photosArray];
        BAKit_WeakSelf
        [self.photosArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            YYAnimatedImageView *imageView = [YYAnimatedImageView new];
            imageView.clipsToBounds = YES;
            imageView.backgroundColor = [UIColor whiteColor];
            
            imageView.userInteractionEnabled = YES;
            imageView.tag = idx;
            [weak_self addSubview:imageView];
            
            long columnIndex = idx % 3;
            long rowIndex = idx / perRowItemCount;
            
            photoViewFrame = CGRectMake(columnIndex * (item_width + kMargin_5), rowIndex * (item_height + kMargin_5), item_width, item_height);
            imageView.frame = photoViewFrame;
            
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:weak_self action:@selector(tapImageView:)];
            [imageView addGestureRecognizer:singleTap];
            
            
            if ([obj isKindOfClass:[NSURL class]])
            {
                [imageView yy_setImageWithURL:obj placeholder:BAKit_DefaultImage options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation completion:nil];
            }
            else if ([obj isKindOfClass:[NSString class]])
            {
                [imageView yy_setImageWithURL:[NSURL URLWithString:obj] placeholder:BAKit_DefaultImage options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation completion:nil];
            }
        }];
    }
}

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    BAKit_WeakSelf
    
    /*! 用了两种图片浏览器，打开注释和 Delegate 即可迅速切换 */
//    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
//    browser.currentImageIndex = imageView.tag;
//    browser.sourceImagesContainerView = self;
//    browser.imageCount = self.timeLineViewModel.self.photosArray.count;
//    browser.delegate = (id<SDPhotoBrowserDelegate>)weakSelf;
//    [browser show];
    
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:(id<MWPhotoBrowserDelegate>)weak_self];
    /*! 分享按钮,默认是 */
    browser.displayActionButton = YES;
    /*! 左右分页切换,默认否<屏幕下方的左右角标> */
    browser.displayNavArrows = NO;
    /*! 是否显示选择按钮在图片上,默认否 */
    browser.displaySelectionButtons = NO;
    /*! 控制条件控件 是否显示,默认否 */
    browser.alwaysShowControls = NO;
    /*! 是否全屏,默认是 */
    browser.zoomPhotosToFill = YES;
    /*! 是否允许用网格查看所有图片,默认是 */
    browser.enableGrid = NO;
    browser.enableSwipeToDismiss = NO;
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    [browser setCurrentPhotoIndex:imageView.tag];
    
    /*! 转场动画 */
    [(BABaseViewController *)[self getCurrentViewController] ba_animationWithBATransitionType:BAKit_RandomNumber(12) animationView:[self getCurrentViewController].navigationController.view];
    [[self getCurrentViewController].navigationController pushViewController:browser animated:YES];
}

- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    if (array.count == 1)
    {
        return self.timeLineViewModel.photoViewFrame.size.width;
    }
    else
    {
        CGFloat w = (CGRectGetWidth(self.timeLineViewModel.contentLabelFrame) - 5 * 2) / 3;
        return w;
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count <= 3)
    {
        return array.count;
    }
    else
    {
        return 3;
    }
}

#pragma mark - SDPhotoBrowserDelegate
//- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
//    NSString *imageName = self.timeLineViewModel.self.photosArray[index];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
//    return url;
//}
//
//- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
//{
//    UIImageView *imageView = self.subviews[index];
//    return imageView.image;
//}


#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photosArray.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photosArray.count)
    {
        return [self getImageType:index];
    }
    return nil;
}

- (MWPhoto *)getImageType:(NSInteger)index
{
    NSString *urlString = [self.photosArray objectAtIndex:index];
    NSURL *url = [NSURL URLWithString:urlString];
    MWPhoto *photo;

    return photo = [MWPhoto photoWithURL:url];
}

//- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
//    if (index < _timeLineViewModel.self.photosArray.count)
//        return [_timeLineViewModel.self.photosArray objectAtIndex:index];
//    return nil;
//}

/*! 自定义底部视图，继承MWCaptionView这个类，在子类中重写-setupCaption和 -sizeThatFits:，或者加视图。 */
- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
    MWPhoto *photo = [self getImageType:index];
    photo.caption = [NSString stringWithFormat:@"第 %lu / %lu 张图片！", (unsigned long)index+1, (unsigned long)self.photosArray.count];
    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
    return captionView;
}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
//}

//- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
//    return [[_selections objectAtIndex:index] boolValue];
//}

/*! 自定义标题 */
- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
     return [NSString stringWithFormat:@"%lu / %lu", (unsigned long)index+1, (unsigned long)self.photosArray.count];
}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
//    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
//    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
//}

//- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
//    // If we subscribe to this method we must dismiss the view controller ourselves
//    NSLog(@"Did finish modal presentation");
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

#pragma mark - setter / getter
- (void)setTimeLineViewModel:(BATimeLineViewModel *)timeLineViewModel
{
    _timeLineViewModel = timeLineViewModel;
    self.photosArray = timeLineViewModel.model.pic_urls;

    [self setupFrame];
    [self setupData];
}




@end
