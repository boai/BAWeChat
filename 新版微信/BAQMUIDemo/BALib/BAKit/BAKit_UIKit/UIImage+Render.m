//
//  UIImage+Render.m
//  BAQMUIDemo
//
//  Created by 博爱 on 15/10/16.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "UIImage+Render.h"
#import <objc/runtime.h>

#define _FOUR_CC(c1,c2,c3,c4) ((uint32_t)(((c4) << 24) | ((c3) << 16) | ((c2) << 8) | (c1)))
#define _TWO_CC(c1,c2) ((uint16_t)(((c2) << 8) | (c1)))

@implementation UIImage (Render)

/*!
 让图片不被渲染
 
 @param imageName 图片名称
 @return 不被渲染的图片
 */
+ (UIImage *)ba_imageNamedWithOriginal:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName] ;
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    return image ;
}

/*!
 获得新的圆形图片
 
 @param image 传入需要裁剪成圆形的图片
 @return 返回裁剪好的圆形图片
 */
+ (UIImage *)ba_imageToRoundImageWithImage:(UIImage *)image
{
    if (!image)return nil;
    
    /*! 1、开启位图上下文 */
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0) ;
    
    /*! 2、描述圆形裁剪区域 */
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)] ;
    
    /*! 3、设置裁剪区域 */
    [clipPath addClip] ;
    
    /*! 4、绘图 */
    [image drawAtPoint:CGPointZero] ;
    
    /*! 5、取出图片 */
    image = UIGraphicsGetImageFromCurrentImageContext() ;
    
    /*! 6、关闭图片上下文 */
    UIGraphicsEndImageContext() ;
    
    return image ;
}

/*!
 传入图片，获得有边框、边框颜色的圆形图片
 
 @param borderW 边框宽度
 @param color   变宽颜色
 @param image   传入图片
 
 @return 获得有边框、边框颜色的圆形新图片
 */
+ (UIImage *)ba_imageWithBorderW:(CGFloat)borderW
                     borderColor:(UIColor *)color
                           image:(UIImage *)image
{
    if (!image) return nil;
    
    /*! 1.生成一张图片,开启一个位图上下文(大小,图片的宽高 + 2 * 边框宽度) */
    CGSize size = CGSizeMake(image.size.width + 2 *borderW, image.size.height + 2 *borderW);
    UIGraphicsBeginImageContext(size);
    
    /*! 2.绘制一个大圆 */
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [color set];
    [path fill];
    
    /*! 3.设置裁剪区域 */
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    
    /*! 3.1 把路径设置为裁剪区域 */
    [clipPath addClip];
    
    /*! 4 把图片绘制到上下文 */
    [image drawAtPoint:CGPointMake(borderW, borderW)];
    
    /*! 5.从上下文当中获取图片 */
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    /*! 6.关闭上下文 */
    UIGraphicsEndImageContext();
    
    return newImage;
}

/*!
 *  传入图片，cell，imageSize，改变自定义大小的系统 cell image
 *
 *  @param cell      cell
 *  @param image     image 可以自己切圆角：[UIImage ba_imageToRoundImageWithImage:UIImageMake(@"icon1.jpg")]；
 *  @param imageSize 图像的 size 记得先切圆角再传 size
 *
 *  @return 返回自定义大小的系统 cell image
 */
+ (UIImage *)ba_imageToChangeCellNormalImageViewSizeWithCell:(UITableViewCell *)cell
                                                   image:(UIImage *)image
                                                   imageSize:(CGSize)imageSize
{
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGRect imageRect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    [image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cell.imageView.image;
}

/*!
 *  传入图片，cell，imageSize，改变自定义大小的圆形系统 cell image
 *
 *  @param cell      cell
 *  @param image     image 可以自己切圆角：[UIImage ba_imageToRoundImageWithImage:UIImageMake(@"icon1.jpg")]；
 *  @param imageSize 图像的 size 记得先切圆角再传 size
 *
 *  @return 返回自定义大小的圆形系统 cell image
 */
+ (UIImage *)ba_imageToChangeCellRoundImageViewSizeWithCell:(UITableViewCell *)cell
                                                            image:(UIImage *)image
                                                        imageSize:(CGSize)imageSize
{
    UIImage *roundImage = [UIImage ba_imageToRoundImageWithImage:image];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGRect imageRect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    [roundImage drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cell.imageView.image;
}

/*!
 *  根据图片url获取图片尺寸
 *
 *  @param imageURL imageURL description
 *
 *  @return 根据图片url获取图片尺寸
 */
+ (CGSize)ba_imageGetImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size = [self ba_imageGetPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size = [self ba_imageGetGIFImageSizeWithRequest:request];
    }
    else{
        size = [self ba_imageGetJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage *image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}

/*!
 *  获取PNG图片的大小
 *
 *  @param request request description
 *
 *  @return 获取PNG图片的大小
 */
+ (CGSize)ba_imageGetPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

/*!
 *  获取gif图片的大小
 *
 *  @param request request description
 *
 *  @return 获取gif图片的大小
 */
+ (CGSize)ba_imageGetGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

/*!
 *  获取jpg图片的大小
 *
 *  @param request request description
 *
 *  @return 获取jpg图片的大小
 */
+ (CGSize)ba_imageGetJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}

/*!
 *  根据宽比例去缩放图片
 *
 *  @param width width description
 *
 *  @return return value description
 */
- (UIImage *)ba_imageScaleToWidth:(CGFloat)width
{
//    // 如果传入的宽度比当前宽度还要大,就直接返回
//    if (width > self.size.width)
//    {
//        return  self;
//    }
//    
//    // 计算缩放之后的高度
//    CGFloat height = (width / self.size.width) * self.size.height;
//    
//    // 初始化要画的大小
//    CGRect rect = CGRectMake(0, 0, width, height);
//    
//    // 1. 开启图形上下文
//    UIGraphicsBeginImageContext(rect.size);
//    
//    // 2. 画到上下文中 (会把当前image里面的所有内容都画到上下文)
//    [self drawInRect:rect];
//    
//    // 3. 取到图片
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    
//    // 4. 关闭上下文
//    UIGraphicsEndImageContext();
//    // 5. 返回
//    return image;
    
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat old_width = imageSize.width;
    CGFloat old_height = imageSize.height;
    CGFloat targetWidth = width;
    CGFloat targetHeight = old_height / (old_width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if (CGSizeEqualToSize(imageSize, size) == NO)
    {
        CGFloat widthFactor = targetWidth / old_width;
        CGFloat heightFactor = targetHeight / old_height;
        if(widthFactor > heightFactor)
        {
            scaleFactor = widthFactor;
        }
        else
        {
            scaleFactor = heightFactor;
        }
        scaledWidth = old_width * scaleFactor;
        scaledHeight = old_height * scaleFactor;
        if(widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    
    return newImage;
}

/*!
 *  通过图片Data数据第一个字节 来获取图片扩展名
 *
 *  @param imageURL description
 *
 *  @return 通过图片Data数据第一个字节 来获取图片扩展名
 */
//+ (BAKit_BAKit_ImageType)ba_imageGetContentTypeWihtImageURL:(id)imageURL
//{
//    NSURL *URL = nil;
//    if([imageURL isKindOfClass:[NSURL class]])
//    {
//        URL = imageURL;
//    }
//    if([imageURL isKindOfClass:[NSString class]])
//    {
//        URL = [NSURL URLWithString:imageURL];
//    }
//    if(URL == nil) BAKit_ShowAlertWithMsg(@"url 为空！");
//
//    if ([BAKit_Helper ba_helperURLIsMp4WithUrl:imageURL])
//    {
//        return BAKit_BAKit_ImageTypeMp4;
//    }
//    NSData *data = [NSData dataWithContentsOfURL:URL];
//    uint8_t c;
//    [data getBytes:&c length:1];
//    switch (c) {
//        case 0xFF:
//            return BAKit_BAKit_ImageTypeJpeg;
////            return @"jpeg";
//        case 0x89:
//            return BAKit_BAKit_ImageTypePng;
////            return @"png";
//        case 0x47:
//            return BAKit_BAKit_ImageTypeGif;
////            return @"gif";
//        case 0x49:
//        case 0x4D:
//            return BAKit_BAKit_ImageTypeTiff;
////            return @"tiff";
//        case 0x52:
//            if ([data length] < 12) {
//                return nil;
//            }
//            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
//            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
//                return BAKit_BAKit_ImageTypeWebp;
////                return @"webp";
//            }
//            return nil;
//    }
//    return nil;
//}

BAKit_ImageType ImageDetectType(id imageURL) {
    
    NSURL *URL = nil;
    if([imageURL isKindOfClass:[NSURL class]])
    {
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]])
    {
        URL = [NSURL URLWithString:imageURL];
        if ([BAKit_Helper ba_helperURLIsMp4WithUrl:imageURL])
        {
            return BAKit_ImageTypeMp4;
        }
    }
    
    NSData *data2 = [NSData dataWithContentsOfURL:URL];
    CFDataRef data = (__bridge CFDataRef)(data2);
    
    if (!data) return BAKit_ImageTypeUnknow;
    uint64_t length = CFDataGetLength(data);
    if (length < 16) return BAKit_ImageTypeUnknow;
    
    const char *bytes = (char *)CFDataGetBytePtr(data);
    
    uint32_t magic4 = *((uint32_t *)bytes);
    switch (magic4) {
        case _FOUR_CC(0x4D, 0x4D, 0x00, 0x2A): { // big endian TIFF
            return BAKit_ImageTypeTIFF;
        } break;
            
        case _FOUR_CC(0x49, 0x49, 0x2A, 0x00): { // little endian TIFF
            return BAKit_ImageTypeTIFF;
        } break;
            
        case _FOUR_CC(0x00, 0x00, 0x01, 0x00): { // ICO
            return BAKit_ImageTypeICO;
        } break;
            
        case _FOUR_CC('i', 'c', 'n', 's'): { // ICNS
            return BAKit_ImageTypeICNS;
        } break;
            
        case _FOUR_CC('G', 'I', 'F', '8'): { // GIF
            return BAKit_ImageTypeGIF;
        } break;
            
        case _FOUR_CC(0x89, 'P', 'N', 'G'): {  // PNG
            uint32_t tmp = *((uint32_t *)(bytes + 4));
            if (tmp == _FOUR_CC('\r', '\n', 0x1A, '\n')) {
                return BAKit_ImageTypePNG;
            }
        } break;
            
        case _FOUR_CC('R', 'I', 'F', 'F'): { // WebP
            uint32_t tmp = *((uint32_t *)(bytes + 8));
            if (tmp == _FOUR_CC('W', 'E', 'B', 'P')) {
                return BAKit_ImageTypeWebP;
            }
        } break;
    }
    
    uint16_t magic2 = *((uint16_t *)bytes);
    switch (magic2) {
        case _TWO_CC('B', 'A'):
        case _TWO_CC('B', 'M'):
        case _TWO_CC('I', 'C'):
        case _TWO_CC('P', 'I'):
        case _TWO_CC('C', 'I'):
        case _TWO_CC('C', 'P'): { // BMP
            return BAKit_ImageTypeBMP;
        }
        case _TWO_CC(0xFF, 0x4F): { // JPEG2000
            return BAKit_ImageTypeJPEG2000;
        }
    }
    if (memcmp(bytes,"\377\330\377",3) == 0) return BAKit_ImageTypeJPEG;
    if (memcmp(bytes + 4, "\152\120\040\040\015", 5) == 0) return BAKit_ImageTypeJPEG2000;
    return BAKit_ImageTypeUnknow;
}


@end
