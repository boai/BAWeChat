//
//  BAKit_ModelCodingCopying.h
//  yunlianWIFI
//
//  Created by boai on 2017/4/10.
//  Copyright © 2017年 yunlianhui. All rights reserved.
//

#import "BAKit_Model.h"

/**
 *  用于解析json数据,子类模型继承此类,包含coding跟copying
 */
@interface BAKit_ModelCodingCopying : BAKit_Model<NSCopying, NSCoding, NSSecureCoding>

@end
