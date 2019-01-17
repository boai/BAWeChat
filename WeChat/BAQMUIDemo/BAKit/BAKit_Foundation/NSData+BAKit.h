
/*!
 *  @header BAKit.h
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright  Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

/*
 
 *********************************************************************************
 *
 * 在使用 BAKit 的过程中如果出现 bug 请及时以以下任意一种方式联系我，我会及时修复 bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * BAHome : https://github.com/BAHome
 * 博客    : http://boaihome.com
 
 *********************************************************************************
 
 */


#import <Foundation/Foundation.h>

@interface NSData (BAKit)

+ (unsigned short)ba_datacrc8:(NSData *)data;


+ (UInt16)ba_dataNeedTranlate:(NSData *)data;
+ (UInt16)ba_dataCMUnEscape:(UInt8 *)pOut and:(UInt8 *)pIn and:(UInt16)ba_datalen;
+ (UInt16)ba_dataCMEscape:(UInt8 *)pOut and:(UInt8 *)pIn and:(UInt16)ba_datalen;
+ (UInt16)ba_dataNeeUnTranlate:(NSData *)data;

/**
 转义
 
 @param data 要转的数据
 @return 转后的数据
 */
+ (NSData *)ba_dataTranlateData:(NSData *)data;

/**
 反转义
 
 @param data 要转的数据
 @return 反转义的数据
 */
+ (NSData *)ba_dataUnTranlateData:(NSData *)data;

/**
 CRC16 校验
 
 @param data 要校验的数据
 @return 返回校验和
 */
+ (unsigned short)ba_datacrc16:(NSData *)data;

/**
 10进制转换成1个字节的NSData
 
 @param len 10进制数
 @return 1字节的NSData
 */
+ (NSData *)ba_dataGet1BDataFromInt:(int)len;

/**
 10进制数转换成2字节数
 
 @param len 10进制数 可传递0xffff 或345632这样的指令
 */
+ (NSData *)ba_dataGet2BDataFromInt:(int)len;

/**
 1字节转int
 */
+ (int)ba_dataTht1BDataToInt:(NSData *)data;

/**
 2字节大端字节序转换成int型
 
 @param data 大端字节序
 @return int 型数据
 */
+ (int)ba_dataThe2BDataToInt:(NSData *)data;

/**
 4字节大端字节序转int 型数据
 
 @param data 大端字节序列
 @return int 型数据
 */
+ (int)ba_dataThe4BDataToInt:(NSData *)data;

/**
 通用型字节转int
 */
+ (unsigned)ba_dataParseIntFromData:(NSData *)data;

/**
 二进制转10进制
 
 @param binary 二进制字符串
 @return 10进制数据
 */
+ (NSString *)ba_dataToDecimalWithBinary:(NSString *)binary;

/**
 10 进制数转换成16进制字符串
 @param intData 10进制数
 @return 返回16进制字符串
 */
+ (NSString *)ba_dataToHex:(int)intData;

/**
 16进制字符串转换成NSdata
 
 @param hexString 16进制字符串
 @return NSdata
 */
+ (NSData *)ba_dataHexStringToData:(NSString *)hexString;

/**
 16进制的nsdata数原封不动转成字符串
 @param data 0011223344556677
 @return  0011223344556677
 */
+ (NSString *)ba_dataHexDataToString:(NSData *)data;


/**
 任意字符串转换成6字节
 
 @param string 字符串
 @return 6字节nsdata
 */
+ (NSData *)ba_dataStringTo6BData:(NSString *)string;


/**
 两个字节的int 型数据转换成大端字节序
 
 @param num 整形数据
 @return 2字节的NSData
 */
+ (NSData *)ba_dataIntToBigEndianData:(uint16_t)num;

@end
