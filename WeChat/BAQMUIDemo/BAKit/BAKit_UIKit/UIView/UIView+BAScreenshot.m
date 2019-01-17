//
//  UIView+BAScreenshot.m
//  BAQMUIDemo
//
//  Created by boai on 2017/5/27.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "UIView+BAScreenshot.h"

@implementation UIView (BAScreenshot)

- (UIImage *)ba_viewGetImageShot
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


//- (UIImage *)screenshot
//{
//    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
//    
//    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    NSData *imageData = UIImagePNGRepresentation(image);
//    image = [UIImage imageWithData:imageData];
//    
//    return image;
//}

- (UIImage *)ba_viewSaveScreenshot
{
    UIImage *image = [self ba_viewGetImageShot];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    return image;
}

@end
