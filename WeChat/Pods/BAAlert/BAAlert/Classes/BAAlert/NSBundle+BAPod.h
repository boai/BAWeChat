//
//  NSBundle+BAPod.h
//  BAAlert_Example
//
//  Created by 孙博岩 on 2018/11/15.
//  Copyright © 2018 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (BAPod)

/**
 获取文件所在name，默认情况下podName和bundlename相同，传一个即可
 
 @param bundleName bundle名字，就是在resource_bundles里面的名字
 @param podName pod的名字
 @return bundle
 */
+ (NSBundle *)ba_bundleWithBundleName:(NSString *)bundleName
                              podName:(NSString *)podName;

@end

NS_ASSUME_NONNULL_END
