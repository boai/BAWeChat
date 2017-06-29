//
//  NSData+BAKit.m
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//


#import "NSData+BAKit.h"

@implementation NSData (BAKit)
+(unsigned short)crc16:(NSData *)data
{
    const uint8_t *byte = (const uint8_t *)data.bytes;
    uint16_t length = (uint16_t)data.length;
    uint16_t crc = 0xffff;
    return MthCrc16(crc, byte, length);
}

#define PLOY 0X1021
uint16_t gen_crc16(const uint8_t *data, uint16_t size)
{
    uint16_t crc = 0;
    uint8_t i;
    for (; size > 0; size--) {
        crc = crc ^ (*data++ <<8);
        for (i = 0; i < 8; i++) {
            if (crc & 0X8000) {
                crc = (crc << 1) ^ PLOY;
            }else {
                crc <<= 1;
            }
        }
        crc &= 0XFFFF;
    }
    return crc;
    
}

/************************************************************************************** *
 FunctionName : MthCrc16()
 * Description : 16 位 CRC 校验
 * EntryParameter : crc - 第一次调用值必须是(0xFFFF)
 * ReturnValue : 返回校验结果 **************************************************************************************/
uint16_t MthCrc16(uint16_t crc, const uint8_t *pDat, uint16_t len)
{
    uint8_t tmpDat;
    uint16_t tmpCrc = crc;
    static uint16_t crc16Tbl[] =  {
        0x0000, 0xC0C1, 0xC181, 0x0140, 0xC301, 0x03C0, 0x0280, 0xC241,
        0xC601, 0x06C0, 0x0780, 0xC741, 0x0500, 0xC5C1, 0xC481, 0x0440,
        0xCC01, 0x0CC0, 0x0D80, 0xCD41, 0x0F00, 0xCFC1, 0xCE81, 0x0E40,
        0x0A00, 0xCAC1, 0xCB81, 0x0B40, 0xC901, 0x09C0, 0x0880, 0xC841,
        0xD801, 0x18C0, 0x1980, 0xD941, 0x1B00, 0xDBC1, 0xDA81, 0x1A40,
        0x1E00, 0xDEC1, 0xDF81, 0x1F40, 0xDD01, 0x1DC0, 0x1C80, 0xDC41,
        0x1400, 0xD4C1, 0xD581, 0x1540, 0xD701, 0x17C0, 0x1680, 0xD641,
        0xD201, 0x12C0, 0x1380, 0xD341, 0x1100, 0xD1C1, 0xD081, 0x1040,
        0xF001, 0x30C0, 0x3180, 0xF141, 0x3300, 0xF3C1, 0xF281, 0x3240,
        0x3600, 0xF6C1, 0xF781, 0x3740, 0xF501, 0x35C0, 0x3480, 0xF441,
        0x3C00, 0xFCC1, 0xFD81, 0x3D40, 0xFF01, 0x3FC0, 0x3E80, 0xFE41,
        0xFA01, 0x3AC0, 0x3B80, 0xFB41, 0x3900, 0xF9C1, 0xF881, 0x3840,
        0x2800, 0xE8C1, 0xE981, 0x2940, 0xEB01, 0x2BC0, 0x2A80, 0xEA41,
        0xEE01, 0x2EC0, 0x2F80, 0xEF41, 0x2D00, 0xEDC1, 0xEC81, 0x2C40,
        0xE401, 0x24C0, 0x2580, 0xE541, 0x2700, 0xE7C1, 0xE681, 0x2640,
        0x2200, 0xE2C1, 0xE381, 0x2340, 0xE101, 0x21C0, 0x2080, 0xE041,
        0xA001, 0x60C0, 0x6180, 0xA141, 0x6300, 0xA3C1, 0xA281, 0x6240,
        0x6600, 0xA6C1, 0xA781, 0x6740, 0xA501, 0x65C0, 0x6480, 0xA441,
        0x6C00, 0xACC1, 0xAD81, 0x6D40, 0xAF01, 0x6FC0, 0x6E80, 0xAE41,
        0xAA01, 0x6AC0, 0x6B80, 0xAB41, 0x6900, 0xA9C1, 0xA881, 0x6840,
        0x7800, 0xB8C1, 0xB981, 0x7940, 0xBB01, 0x7BC0, 0x7A80, 0xBA41,
        0xBE01, 0x7EC0, 0x7F80, 0xBF41, 0x7D00, 0xBDC1, 0xBC81, 0x7C40,
        0xB401, 0x74C0, 0x7580, 0xB541, 0x7700, 0xB7C1, 0xB681, 0x7640,
        0x7200, 0xB2C1, 0xB381, 0x7340, 0xB101, 0x71C0, 0x7080, 0xB041,
        0x5000, 0x90C1, 0x9181, 0x5140, 0x9301, 0x53C0, 0x5280, 0x9241,
        0x9601, 0x56C0, 0x5780, 0x9741, 0x5500, 0x95C1, 0x9481, 0x5440,
        0x9C01, 0x5CC0, 0x5D80, 0x9D41, 0x5F00, 0x9FC1, 0x9E81, 0x5E40,
        0x5A00, 0x9AC1, 0x9B81, 0x5B40, 0x9901, 0x59C0, 0x5880, 0x9841,
        0x8801, 0x48C0, 0x4980, 0x8941, 0x4B00, 0x8BC1, 0x8A81, 0x4A40,
        0x4E00, 0x8EC1, 0x8F81, 0x4F40, 0x8D01, 0x4DC0, 0x4C80, 0x8C41,
        0x4400, 0x84C1, 0x8581, 0x4540, 0x8701, 0x47C0, 0x4680, 0x8641,
        0x8201, 0x42C0, 0x4380, 0x8341, 0x4100, 0x81C1, 0x8081, 0x4040,
    };
    while (len--){
        tmpDat   = *pDat++ ^ tmpCrc;
        tmpCrc >>= 8;
        tmpCrc  ^= crc16Tbl[tmpDat];
    }
    return tmpCrc;
}

+(unsigned short)crc8:(NSData *)data
{
    const uint8_t *bytes = (const uint8_t *)[data bytes];
    uint16_t length = (uint16_t)[data length];
    return (unsigned short)gen_crc8(bytes, length);
}

uint16_t gen_crc8(const uint8_t *data, uint16_t size)
{
    uint16_t out = 0;
    return f_crc8(out, data, size);
}


uint8_t f_crc8(uint8_t  crc_val,const uint8_t *buf,uint32_t len)
{
    uint32_t l=0;
    uint8_t i, crc;
    uint16_t init=0;
    
    init=crc_val*0x100;
    for(l=0;l<len;l++)
    {
        init^=(buf[l]*0x100);
        for(i=0;i<8;i++)
        {
            if(init&0x8000)
                init^=0x8380;
            init*=2;
        }
    }
    crc = init/0x100;
    return crc;
}

/**
 转义数据
 @param data  要转义的数据
 @return 转义后的数据
 */
+(NSData*)TranlateData:(NSData *)data{
    
    Byte pout[data.length+[self NeedTranlate:data]];
    Byte *byte = (Byte*)[data bytes];
    UInt16 len = [NSData CMEscape:pout and:byte and:data.length];
    NSData * lastData = [[NSData alloc] initWithBytes:pout length:len];
    return lastData;
}

/**
 反转义数据
 
 @param data 要反转以的数据
 @return 反转义的数据
 */
+(NSData*)UnTranlateData:(NSData *)data{
    
    Byte pout[data.length];
    Byte *byte = (Byte*)[data bytes];
    UInt16 len = [NSData CMUnEscape:pout and:byte and:data.length];
    NSData * lastData = [[NSData alloc] initWithBytes:pout length:len];
    return lastData;
}

/**
 需要进行转义的个数
 @return 个数
 */
+ (UInt16) NeedTranlate:(NSData *)data{
    Byte *bytes = (Byte*)[data bytes];
    UInt16 count = 0;
    for (int i = 0; i < data.length; i++) {
        if ((bytes[i]==0x7d) || (bytes[i]==0x7e) || (bytes[i]==0x7f)){
            count=count+1;
        }
    }
    return count;
}

/**
 需要反转义的个数
 @param data 反转义的数据
 @return 反转义的个数
 */
+(UInt16) NeeUnTranlate:(NSData *)data{
    Byte *bytes = (Byte*)[data bytes];
    UInt16 count = 0;
    for (int i = 0; i < data.length; i++) {
        if (bytes[i]==0x7d ){
            count=count+1;
        }
    }
    return count;
}
/************************************************************************************** * FunctionName : CMEscape()
 * Description : 数据转义
 * EntryParameter : pOut - 转义后的数据; pIn - 需转义的数据; len - 数据长度
 * ReturnValue : 转义后的数据长度 **************************************************************************************/
+(UInt16) CMEscape:(UInt8 *)pOut and:(UInt8 *)pIn and:(UInt16) len
{
    UInt16 i;
    UInt16 tmpLen = 0;
    for (i=0; i<len; i++)
    {
        if ((i == 0) || (i == len-1)) {
            pOut[tmpLen++] = pIn[i];
        }
        else {
            // 把帧头和帧尾之家出现的 0x7D\0x7E\0x7F 转换成 0x5D\0x5E\0x5F，并在前面加上 0x7D
            if ((pIn[i]==0x7D) || (pIn[i]==0x7E) || (pIn[i]==0x7F))
            {
                pOut[tmpLen++] = 0x7D;
                pOut[tmpLen++] = pIn[i] - 0x20;
            } else {
                pOut[tmpLen++] = pIn[i];
            }
        }
    }
    return tmpLen;
}

/************************************************************************************** * FunctionName : CMUnEscape()
 * Description : 数据反转义
 * EntryParameter : pOut - 反转义后的数据; pIn - 需反转义的数据; len - 数据长度
 * ReturnValue : 转义后的数据长度 CMUnEscape  **************************************************************************************/
+(UInt16) CMUnEscape:(UInt8 *)pOut and:(UInt8 *)pIn and:(UInt16) len
{
    UInt16 i;
    UInt16 tmpLen = 0;
    for (i=0; i<len; i++){
        // 去掉加上的 0x7D,加上 0x20,获取原始值
        pOut[tmpLen++] = ((pIn[i] == 0x7d) ? (pIn[++i] + 0x20) : pIn[i]);
    }
    return tmpLen;
}

+(NSData *) get2BDataFromInt:(int)len{
    //用2个字节接收
    Byte bytes[2];
    bytes[0] = (Byte)(len>>8);
    bytes[1] = (Byte)(len);
    NSData *data = [NSData dataWithBytes:bytes length:2];
    return data;
}
+(NSData*) get1BDataFromInt:(int)len{
    Byte  bytes[1];
    bytes[0] = (Byte)len;//强制转型转成1字节，多余的去掉
    NSData * data = [NSData dataWithBytes:bytes length:1];
    return data;
}

//  二进制转十进制
+(NSString *)toDecimalWithBinary:(NSString *)binary{
    int ll = 0 ;
    int  temp = 0 ;
    for (int i = 0; i < binary.length; i ++){
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    NSString * result = [NSString stringWithFormat:@"%d",ll];
    return result;
}
//将十进制转化为十六进制字符串表示
+ (NSString *)ToHex:(int)intData{
    NSString *nLetterValue;
    NSString *str =@"";
    int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig =intData%16;
        intData=intData/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (intData == 0) {
            break;
        }
    }
    //不够一个字节凑0
    if(str.length == 1){
        return [NSString stringWithFormat:@"0%@",str];
    }else{
        return str;
    }
}

+(NSData *)hexStringToData:(NSString *)hexString{
    @try {
        NSLog(@"Device Code:::>>> %@", hexString);
        NSInteger hexStringLen = [hexString length];
        NSInteger dataLen = hexStringLen / 2;
        Byte outdate[dataLen];
        memset(outdate, 0x00, dataLen);
        for (int i=0; i<hexStringLen; i++) {
            NSString *macsub = [[hexString substringWithRange:NSMakeRange(i, 2)] lowercaseString];
            outdate[(i/2)]=strtoul([[NSString stringWithFormat:@"0x%@",macsub] UTF8String],0,0);
            i++;
        }
        NSData *udpPacketData = [[NSData alloc] initWithBytes:outdate length:dataLen];
        return udpPacketData;
    } @catch (NSException *exception) {
        NSLog(@"hexStringToData: %@", exception.userInfo);
    } @finally {
        
    }
}
+(NSString*)hexDataToString:(NSData*)data{
    
    NSMutableString * hexString = [NSMutableString string];
    Byte * byte = (Byte*)[data bytes];
    for (int i = 0; i < data.length; i++) {
        Byte temp = byte[i];
        int hi4 = (temp & 0xf0)>>4;
        int lo4 = (temp & 0x0f);
        [hexString appendFormat:@"%x",hi4];
        [hexString appendFormat:@"%x",lo4];
    }
    NSLog(@"***************%@",hexString);
    return hexString;
}

+(int)the2BDataToInt:(NSData *)data{
    int value = CFSwapInt16BigToHost(*(int*)([data bytes]));//290
    NSLog(@"%d",value);
    return value;
}
+(int)the4BDataToInt:(NSData *)data{
    int value = CFSwapInt32BigToHost(*(int*)([data bytes]));//655650
    NSLog(@"%d",value);
    return value;
}
+(int)tht1BDataToInt:(NSData *)data{
    int value = *(int*)[data bytes];
    NSLog(@"%d",value);
    return value;
}
//补充内容，因为没有三个字节转int的方法，这里补充一个通用方法
+ (unsigned)parseIntFromData:(NSData *)data{
    
    NSString *dataDescription = [data description];
    NSString *dataAsString = [dataDescription substringWithRange:NSMakeRange(1, [dataDescription length]-2)];
    unsigned intData = 0;
    NSScanner *scanner = [NSScanner scannerWithString:dataAsString];
    [scanner scanHexInt:&intData];
    return intData;
}

+(NSData*)stringTo6BData:(NSString*)string{
    
    Byte dataArr[6];
    char * cString = (char*)[string UTF8String];
    memcpy(dataArr, cString, strlen(cString));
    NSData * data = [[NSData alloc] initWithBytes:dataArr length:strlen(cString)];
    return data;
    
}

+(NSData*)intToBigEndianData:(uint16_t)num{
    
    uint16_t theNum = HTONS(num);
    NSData * bigData = [NSData dataWithBytes:&theNum length:2];
    NSLog(@"%@",bigData);
    return bigData;
}
@end
