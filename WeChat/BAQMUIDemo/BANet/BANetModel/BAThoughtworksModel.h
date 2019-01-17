//
//  BAThoughtworksModel.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/18.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BAThoughtworksModelRows;
@interface BAThoughtworksModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<BAThoughtworksModelRows *> *rows;

@end

@interface BAThoughtworksModelRows : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *imageHref;

@property (nonatomic, copy) NSString *desc;

@end

